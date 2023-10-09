//
//  AboutAppVC.swift
//  CoinTail
//
//  Created by Eugene on 06.10.23.
//

import UIKit


class AboutAppVC: BasicVC {

    // Всплывающее окно
    let popUpView: UIView = {
       let popUp = UIView()
        popUp.layer.cornerRadius = 15
        popUp.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        popUp.layer.borderWidth = 1
        popUp.layer.masksToBounds = true
        popUp.layer.borderColor = UIColor.black.cgColor
        
        return popUp
    }()
    
    let aboutLabel = UILabel(text: "CoinTail is a reliable assistant in accounting for income and expenses, managing accounts and budgets. Convenient charts will help you control your finances".localized())
    let connectionLabel = UILabel(text: "Connect with Developer".localized())
    
    let telegramButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "telegramIcon"), for: .normal)
        
        return button
    }()
    let gmailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gmailIcon"), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        aboutAppTargets()
        setPopupElements()
    }
 
}
