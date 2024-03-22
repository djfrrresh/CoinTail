//
//  SnackBarController.swift
//  CoinTail
//
//  Created by Eugene on 21.03.24.
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


extension Notification.Name {
    static let showNotification = Notification.Name("showNotification")
    static let openNotificationsScreen = Notification.Name("openNotificationsScreen")
    static let hideNotification = Notification.Name("hideNotification")
}

final class SnackBarController: UIViewController {
    
    private static let notificationLifetime: TimeInterval = 3
    private static let notificationAnimationTime: TimeInterval = 0.3
    
    private let window: NotificationWindow
    private var currentNotificationView: CustomNotificationView?
    private var minOriginY: CGFloat {
        if let tabBar = topController(skipTabBar: false) as? TabBar,
            !tabBar.tabBar.isHidden {
            return tabBar.tabBar.frame.minY-(currentNotificationView?.frame.height ?? 0)-16
        } else {
            let buttomInset = UIDevice.current.hasNotch ? topController().view.safeAreaInsets.bottom : 0
            return UIScreen.main.bounds.height-(currentNotificationView?.frame.height ?? 0) - 16 - buttomInset
        }
    }
    
    var onNotificationTap: (() -> Void)?
    
    init() {
        window = NotificationWindow(
            windowScene: UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }!.windowScene!
        )
        
        super.init(nibName: nil, bundle: nil)
        
        window.windowLevel = .alert
        window.rootViewController = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .hideNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(_ notificationView: CustomNotificationView) {
        DispatchQueue.main.async {
            self.showSafe(notificationView)
        }
    }
    
    @objc func hideCurrentNotification() {
        Self.cancelPreviousPerformRequests(withTarget: self)
        guard let view = currentNotificationView else { return }
        view.button.isUserInteractionEnabled = false
        currentNotificationView = nil
        
        UIView.animate(
            withDuration: Self.notificationAnimationTime,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                view.frame.origin.y = self.minOriginY + view.frame.height
            },
            completion: { [weak self] _ in
                view.removeFromSuperview()
                if self?.currentNotificationView != nil { return }
                self?.window.isHidden = true
            }
        )
    }
    
    @objc private func didTapNotification() {
        hideCurrentNotification()
        onNotificationTap?()
    }
    
    private func showSafe(_ notificationView: CustomNotificationView) {
        window.isHidden = false
        window.notificationView = notificationView
        
        hideCurrentNotification()
        
        currentNotificationView = notificationView
        view.addSubview(notificationView)
        addGestures(notificationView)
        layout(notificationView)
        
        NotificationCenter.default.post(name: .hideNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.hideCurrentNotification),
            name: .hideNotification,
            object: nil
        )
        
        UIView.animate(
            withDuration: Self.notificationAnimationTime,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                notificationView.frame.origin.y = self.minOriginY
            },
            completion: { [weak self] _ in
                guard let self = self else { return }
                self.perform(
                    #selector(self.hideCurrentNotification),
                    with: nil,
                    afterDelay: Self.notificationLifetime
                )
            }
        )
    }
    
    private func addGestures(_ view: CustomNotificationView) {
        view.button.addTarget(self, action: #selector(didTapNotification), for: .touchUpInside)
    }
    
    private func layout(_ view: UIView) {
        view.frame = CGRect(
            origin: .zero,
            size: view.sizeThatFits(self.view.bounds.size)
        )
        view.frame.origin.y = UIScreen.main.bounds.height
    }
    
}
