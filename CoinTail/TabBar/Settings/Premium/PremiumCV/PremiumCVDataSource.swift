//
//  PremiumCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
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


extension PremiumVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellIdentifier(for: indexPath) {
        case PremiumDescriptionCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumDescriptionCell.id,
                for: indexPath
            ) as? PremiumDescriptionCell else {
                return UICollectionViewCell()
            }
            
            cell.descriptionLabel.text = "Try it for free to get access to all the features".localized()
            
            return cell
        case PremiumPlansCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumPlansCell.id,
                for: indexPath
            ) as? PremiumPlansCell else {
                return UICollectionViewCell()
            }
            
            cell.plansDelegate = self
            cell.planCellData = plans
            cell.planCellSize = .init(
                width: planCellSizes.sorted(by: { l, r in
                    l.width > r.width
                }).first?.width ?? 0,
                height: max(planCellSizes.sorted(by: { l, r in
                    l.height > r.height
                }).first?.height ?? 0, 120)
            )

            return cell
        case PremiumAdvantagesCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumAdvantagesCell.id,
                for: indexPath
            ) as? PremiumAdvantagesCell else {
                return UICollectionViewCell()
            }
            
            cell.advantagesCellData = AdvantagesData.advantages

            return cell
        case PremiumPrivacyCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumPrivacyCell.id,
                for: indexPath
            ) as? PremiumPrivacyCell else {
                return UICollectionViewCell()
            }
            
            cell.privacyDelegate = self
            cell.setupDescriptionLabelText(plan ?? plans.sorted(by: { l, r in
                l.isTrial && !r.isTrial
            }).first!)

            return cell
        default:
            fatalError("error: supporting only 4 section")
        }
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return PremiumDescriptionCell.id
        case 1:
            return PremiumPlansCell.id
        case 2:
            return PremiumAdvantagesCell.id
        case 3:
            return PremiumPrivacyCell.id
        default:
            fatalError("error: supporting only 4 section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: PremiumPlansHeader.id,
            for: indexPath
        ) as? PremiumPlansHeader else {
            return UICollectionViewCell()
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case PremiumDescriptionCell.id:
            return .init(top: 0, left: 0, bottom: 28, right: 0)
        case PremiumPlansCell.id:
            return .init(top: 0, left: 0, bottom: 32, right: 0)
        case PremiumAdvantagesCell.id:
            return .init(top: 0, left: 0, bottom: 16, right: 0)
        case PremiumPrivacyCell.id:
            return .init(top: 0, left: 0, bottom: 20, right: 0)
        default:
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case PremiumPlansCell.id:
            return CGSize(width: UIScreen.main.bounds.width, height: 20)
        default:
            return CGSize()
        }
    }
    
}
