//
//  SettingsViewController.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit
import EasyPeasy


class SettingsViewController: UIViewController {
    
    let button = UIButton()
    let alertView = UIAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .darkGray
        
        self.title = "Settings"
        
        buttonFunc()
    }
    
    func buttonFunc() {
        // Кнопка
        self.button.backgroundColor = .black
        self.button.setTitle("Change Background Button", for: .normal)
        self.button.addTarget(self,
                               action: #selector(buttonAction),
                               for: .touchUpInside)
        // Вызов кнопки
        self.view.addSubview(button)
        // Размеры и расположение кнопки
        self.button.easy.layout([
            Width(250),
            Height(120),
            CenterX(0.0),
            CenterY(0.0)
        ])
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        if (view.backgroundColor == .darkGray) {
        self.view.backgroundColor = .gray
        } else {
            self.view.backgroundColor = .darkGray
        }
    }
    
}
