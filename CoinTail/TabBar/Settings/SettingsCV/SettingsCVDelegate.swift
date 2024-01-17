//
//  SettingsCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
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


extension SettingsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            var vc: UIViewController?
            
            switch indexPath.row {
            case 0:
                vc = CurrenciesVC()
            case 1:
                vc = NotificationsVC()
            case 2:
                rateApp()
            case 3:
                vc = AboutAppVC()
            case 4:
                deleteData()
            default:
                return
            }
            
            if let vc = vc {
                vc.hidesBottomBarWhenPushed = true
                
                navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            let vc = PremiumVC(PremiumPlans.shared.plans)
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true)
        default:
            return
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellIdentifier(for: indexPath) {
        case SettingsCell.id:
            return SettingsCell.size()
        case SettingsPremiumCell.id:
            return SettingsPremiumCell.size()
        default:
            return CGSize()
        }
    }
    
}
