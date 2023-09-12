//
//  TransfersHistoryUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit
import EasyPeasy


extension TransfersHistoryVC {
    
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
    
}
