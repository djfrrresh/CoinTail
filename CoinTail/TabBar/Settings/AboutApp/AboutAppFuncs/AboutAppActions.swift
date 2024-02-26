//
//  AboutAppActions.swift
//  CoinTail
//
//  Created by Eugene on 07.10.23.
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

import UIKit
import MessageUI


extension AboutAppVC {
    
    // Открыть телеграм
    func telegramAction() {
        let tgURL = URL.init(string: "tg://resolve?domain=just_eugeny")

        if UIApplication.shared.canOpenURL(tgURL!) {
            UIApplication.shared.open(tgURL!, options: [:])
        } else {
            if let url = URL(string: "https://t.me/just_eugeny") {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    // Открыть почту
    func mailAction() {
        let subject = "CoinTail"
        let body = "Hello, I have a question / suggestion regarding the CoinTail app".localized()
        let recipientEmail = "kunavinjenya55@gmail.com"
        
        // Открыть приложение "Почта" на устройстве
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            present(mail, animated: true)
        } else if let emailUrl = createEmailUrl(subject, body, recipientEmail) {
            // Если "Почты" нет, приложение попросит его скачать
            UIApplication.shared.open(emailUrl)
        } else {
            SentryManager.shared.capture(error: "Can't open mail app", level: .info)
            infoAlert("We can't open the Mail app on your device")
        }
    }
    
    private func createEmailUrl(_ subject: String, _ body: String, _ recipient: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let defaultUrl = URL(string: "mailto:\(recipient)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        return defaultUrl
    }
    
}
