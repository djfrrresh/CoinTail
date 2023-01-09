//
//  SettingsViewController.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit
import EasyPeasy


class SettingsViewController: UIViewController {
    
    let changeCurrencyButton = UIButton(name: "Lari")
    
    let currencyLabel = UILabel()
    
    let currencyStack = UIStackView()
    
    let currencyVC: CurrencyTableVC
    init(currencyVC: CurrencyTableVC) {
        self.currencyVC = currencyVC
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Settings"
        
        setLabel(label: currencyLabel, text: "Select Currency")
        setButton(button: self.changeCurrencyButton, background: .white, textColor: .black)
        changeCurrencyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        setUniqueStack(stack: currencyStack, view_1: currencyLabel, view_2: changeCurrencyButton)
        
        view.addSubview(currencyStack)
        currencyStack.easy.layout([Left(16), Right(16), CenterY(), CenterX()])
    }
    
}
