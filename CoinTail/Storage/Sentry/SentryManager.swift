//
//  SentryManager.swift
//  CoinTail
//
//  Created by Eugene on 23.02.24.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Sentry
import RevenueCat


final class SentryManager {
    
    static let shared = SentryManager()
    
    private var workQueue = DispatchQueue(label: "SentryManagerWorkQueue", qos: .background)
    private let udid: String = "com.kunavinEugene.CoinTail.keychain"
    
    private init() {
        SentrySDK.start { options in
            options.beforeSend = { event in
                if let error = event.error as? NSError {
                    event.fingerprint = [
                        error.localizedDescription,
                        self.udid
                    ]
                }
                
                if let message = event.message?.description {
                    event.fingerprint = [
                        message,
                        self.udid
                    ]
                }
                
                return event
            }
            options.dsn = "https://7baa576bc7c1fc4c7cebdddfa208f62e@o4506796713639936.ingest.sentry.io/4506796715868160"
            options.debug = Purchases.logLevel == .debug
            options.tracesSampleRate = 1.0
            options.attachScreenshot = true
            options.enableAutoPerformanceTracing = true
            options.enablePreWarmedAppStartTracing = true
            options.enableFileIOTracing = false
//            options.profilesSampleRate = Purchases.logLevel == .debug ? 1 : 0.1
            options.appHangTimeoutInterval = 5
            if #available(iOS 15.0, *) {
                options.enableMetricKit = true
            }
        }
        
        SentrySDK.setUser(.init(userId: udid))
    }
    
    func capture(error: NSError, level: SentryLevel) {
        workQueue.async {
            SentrySDK.configureScope { scope in
                scope.setLevel(level)
                SentrySDK.capture(error: error)
            }
        }
    }
    
    func capture(error: String, level: SentryLevel) {
        workQueue.async {
            SentrySDK.configureScope { scope in
                scope.setLevel(level)
                SentrySDK.capture(message: error)
            }
        }
    }

    // LocalizedError
    func capture(error: Error, level: SentryLevel) {
        workQueue.async {
            SentrySDK.configureScope { scope in
                scope.setLevel(level)
                SentrySDK.capture(error: error)
            }
        }
    }
    
}
