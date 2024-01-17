//
//  ContactsCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
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


extension AboutAppVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return contactsMenu.count
        default:
            return 0
        }
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ContactsCell.id,
            for: indexPath
        ) as? ContactsCell else {
            return UICollectionViewCell()
        }
        switch indexPath.section {
        case 0:
            cell.chevronImageView.isHidden = true
            cell.contactsImageView.isHidden = true
            cell.userAgreementLabel.isHidden = true
            cell.appVersionLabel.isHidden = false
            cell.appVersionTextLabel.isHidden = false
            cell.contactsLabel.isHidden = true

            cell.roundCorners(.allCorners, radius: 12)
            cell.isSeparatorLineHidden(true)
        case 1:
            cell.chevronImageView.isHidden = false
            cell.contactsImageView.isHidden = true
            cell.userAgreementLabel.isHidden = false
            cell.appVersionLabel.isHidden = true
            cell.appVersionTextLabel.isHidden = true
            cell.contactsLabel.isHidden = true
            
            cell.roundCorners(.allCorners, radius: 12)
            cell.isSeparatorLineHidden(true)
        case 2:
            cell.contactsLabel.text = contactsMenu[indexPath.row]
            cell.contactsImageView.image = UIImage(systemName: contactsImages[indexPath.row])
            
            cell.chevronImageView.isHidden = false
            cell.contactsImageView.isHidden = false
            cell.userAgreementLabel.isHidden = true
            cell.appVersionLabel.isHidden = true
            cell.appVersionTextLabel.isHidden = true
            cell.contactsLabel.isHidden = false
            
            switch indexPath.row {
            case 0:
                cell.cornerRadiusTop(radius: 12)
                cell.isSeparatorLineHidden(false)
            case 1:
                cell.cornerRadiusBottom(radius: 12)
                cell.isSeparatorLineHidden(true)
            default:
                return cell
            }
        default:
            return cell
        }
                    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ContactsHeader.id,
            for: indexPath
        ) as? ContactsHeader else {
            return UICollectionViewCell()
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 24, right: 0)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 2:
            return CGSize(width: UIScreen.main.bounds.width, height: 20)
        default:
            return CGSize()
        }
    }
    
}
