//
//  AboutAppActions.swift
//  CoinTail
//
//  Created by Eugene on 07.10.23.
//

import UIKit
import MessageUI


extension AboutAppVC {
    
    func telegramAction() {
        if let url = URL(string: "https://t.me/just_eugeny") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func gmailAction() {
        let subject = "CoinTail"
        let body = "Hello, I have a question / suggestion regarding the CoinTail app..."
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
            errorAlert("We can't open the Mail app on your device")
        }
    }
    
    private func createEmailUrl(_ subject: String, _ body: String, _ recipient: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let defaultUrl = URL(string: "mailto:\(recipient)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        return defaultUrl
    }
    
}
