//
//  TransfersHistoryUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit
import EasyPeasy


extension TransfersHistoryVC {
    
    static func getNoTransfersLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "You have no transfer transactions".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        
        return label
    }
    
    static func getTransfersDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Once you transfer money from one account to another – you can check transfer history here".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }
    
    func emptyTransfersSubviews() {
        self.view.addSubview(emptyAccountsView)
        
        emptyAccountsView.easy.layout([
            Left(16),
            Right(16),
            Center(),
            Height(TransfersHistoryVC.noDataViewSize(
                noDataLabel: TransfersHistoryVC.getNoTransfersLabel(),
                descriptionLabel: TransfersHistoryVC.getTransfersDescriptionLabel()
            ))
        ])

        emptyAccountsView.addSubview(monocleImageView)
        emptyAccountsView.addSubview(noAccountsLabel)
        emptyAccountsView.addSubview(descriptionLabel)
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
        
        descriptionLabel.easy.layout([
            Left(),
            Right(),
            Top(16).to(noAccountsLabel, .bottom)
        ])

        addAccountButton.easy.layout([
            Height(52),
            Left(),
            Right(),
            CenterX(),
            Top(16).to(descriptionLabel, .bottom),
            Bottom()
        ])
    }
    
    func transfersSubviews() {
        self.view.addSubview(transfersCV)
        
        transfersCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Bottom()
        ])
    }
    
    func isTransfersEmpty() {
        let isEmpty = transfersDaySections.isEmpty
        
        monocleImageView.isHidden = !isEmpty
        noAccountsLabel.isHidden = !isEmpty
        descriptionLabel.isHidden = !isEmpty
        addAccountButton.isHidden = !isEmpty
        emptyAccountsView.isHidden = !isEmpty
        
        transfersCV.isHidden = isEmpty
    }
    
}
