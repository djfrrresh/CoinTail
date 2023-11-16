//
//  AccountsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import EasyPeasy


extension AccountsVC {
    
    static func getNoAccountsLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "You have no accounts added".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        
        return label
    }
    
    static func getAccountsDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Here you can add different money storage methods, such as cards, cash or a bank deposit".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }

    func emptyAccountsSubviews() {        
        self.view.addSubview(emptyAccountsView)
        
        emptyAccountsView.easy.layout([
            Left(16),
            Right(16),
            Center(),
            Height(AccountsVC.noDataViewSize(
                noDataLabel: AccountsVC.getNoAccountsLabel(),
                descriptionLabel: AccountsVC.getAccountsDescriptionLabel()
            ))
        ])

        emptyAccountsView.addSubview(monocleImageView)
        emptyAccountsView.addSubview(noAccountsLabel)
        emptyAccountsView.addSubview(accountsDescriptionLabel)
        emptyAccountsView.addSubview(addAccountButton)
        
        monocleImageView.easy.layout([
            Height(100),
            Width(100),
            Top(),
            CenterX()
        ])
        
        noAccountsLabel.easy.layout([
            Left(),
            Right(),
            Top(32).to(monocleImageView, .bottom)
        ])
        
        accountsDescriptionLabel.easy.layout([
            Left(),
            Right(),
            Top(16).to(noAccountsLabel, .bottom)
        ])

        addAccountButton.easy.layout([
            Height(52),
            Left(),
            Right(),
            CenterX(),
            Top(16).to(accountsDescriptionLabel, .bottom),
            Bottom()
        ])
    }
    
    func accountsSubviews() {
        self.view.addSubview(accountsCV)
        self.view.addSubview(transferButton)
        self.view.addSubview(historyButton)
        
        historyButton.easy.layout([
            Height(52),
            Left(16),
            Right(16),
            CenterX(),
            Bottom(24).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        transferButton.easy.layout([
            Height(52),
            Left(16),
            Right(16),
            CenterX(),
            Bottom(16).to(historyButton, .top)
        ])
        
        accountsCV.easy.layout([
            Top().to(self.view.safeAreaLayoutGuide, .top),
            CenterX(),
            Left(16),
            Right(16),
            Bottom(24).to(transferButton, .top)
        ])
    }
    
    func isAccountEmpty() {
        let isEmpty = accounts.isEmpty
        
        monocleImageView.isHidden = !isEmpty
        noAccountsLabel.isHidden = !isEmpty
        accountsDescriptionLabel.isHidden = !isEmpty
        addAccountButton.isHidden = !isEmpty
        emptyAccountsView.isHidden = !isEmpty
        
        transferButton.isHidden = isEmpty
        historyButton.isHidden = isEmpty
        accountsCV.isHidden = isEmpty
    }
    
}
