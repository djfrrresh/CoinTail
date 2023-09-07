//
//  AccountsTransferActions.swift
//  CoinTail
//
//  Created by Eugene on 06.09.23.
//

import UIKit
import EasyPeasy


extension AccountsTransferVC {
    
    @objc func removeTransparentView() {
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: { [self] in
                transparentView.alpha = 0
                accountsCV.removeFromSuperview()
        }, completion: nil)
    }
    
    @objc func selectFirstAccount(_ sender: UIButton) {
        addTransparentView(button: selectFirstAccountButton)
    }
    
    @objc func selectSecondAccount(_ sender: UIButton) {
        addTransparentView(button: selectSecondAccountButton)
    }
    
    @objc func saveTransferAction(_ sender: UIButton) {
        let amount = Double(transferAmountTF.text ?? "") ?? 0

        transferValidation(amount: amount) { [weak self] sourceAccount, targetAccount in
            guard let strongSelf = self else { return }
            
            Accounts.shared.transferBetweenAccounts(from: sourceAccount, to: targetAccount, amount: amount)
            
            strongSelf.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
