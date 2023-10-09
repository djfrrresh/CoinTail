//
//  AboutAppMailDelegate.swift
//  CoinTail
//
//  Created by Eugene on 09.10.23.
//

import UIKit
import MessageUI


extension AboutAppVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
