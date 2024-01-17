//
//  HavePremiumCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
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


extension HavePremiumVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2, 3, 4:
            return 1
        default:
            return 0
        }
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return HavePremiumTitleCell.id
        case 1:
            return HavePremiumImageCell.id
        case 2:
            return PremiumDescriptionCell.id
        case 3:
            return PremiumAdvantagesCell.id
        case 4:
            return HavePremiumDateCell.id
        default:
            fatalError("error: supporting only 4 section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellIdentifier(for: indexPath) {
        case HavePremiumTitleCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HavePremiumTitleCell.id,
                for: indexPath
            ) as? HavePremiumTitleCell else {
                return UICollectionViewCell()
            }
            
            return cell
        case HavePremiumImageCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HavePremiumImageCell.id,
                for: indexPath
            ) as? HavePremiumImageCell else {
                return UICollectionViewCell()
            }

            return cell
        case PremiumDescriptionCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumDescriptionCell.id,
                for: indexPath
            ) as? PremiumDescriptionCell else {
                return UICollectionViewCell()
            }
            
            cell.descriptionLabel.text = "You have bought a premium subscription".localized()
            
            return cell
        case PremiumAdvantagesCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumAdvantagesCell.id,
                for: indexPath
            ) as? PremiumAdvantagesCell else {
                return UICollectionViewCell()
            }

            cell.advantagesCellData = advantages
            
            return cell
        case HavePremiumDateCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HavePremiumDateCell.id,
                for: indexPath
            ) as? HavePremiumDateCell else {
                return UICollectionViewCell()
            }

            cell.dateLabel.text = premiumUntil
            
            return cell
        default:
            fatalError("error: supporting only 4 section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: PremiumAdvantagesHeader.id,
            for: indexPath
        ) as? PremiumAdvantagesHeader else {
            return UICollectionViewCell()
        }
        
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case HavePremiumTitleCell.id:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case HavePremiumImageCell.id:
            return UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
        case PremiumDescriptionCell.id:
            return UIEdgeInsets(top: 16, left: 0, bottom: 32, right: 0)
        case PremiumAdvantagesCell.id:
            return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        case HavePremiumDateCell.id:
            return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case PremiumAdvantagesCell.id:
            return CGSize(width: UIScreen.main.bounds.width, height: 20)
        default:
            return CGSize()
        }
    }
    
}
