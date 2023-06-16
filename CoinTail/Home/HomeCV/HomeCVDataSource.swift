//
//  HomeCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CategoryDelegate {

    func categoryIsHidden(isHidden: Bool) {
            categoryIsHidden = isHidden
            globalCV.reloadData()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // Возвращается id ячейки по секции
    private func cellIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return HomeDateCell.id
        case 1:
            return HomeCategoryCell.id
        case 2:
            return HomeOperationCell.id
        default:
            fatalError("no section")
        }
    }

    // Заполнение ячеек по их id.
    // Каждой ячейке соответствует свой массив, данные которого берутся из HomeVC
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellIdentifier(for: indexPath) {
        case HomeDateCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeDateCell.id,
                for: indexPath
            ) as? HomeDateCell else {
                fatalError("Unable to dequeue HomeSelectedDateCell.")
            }
                        
            return cell
        case HomeCategoryCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeCategoryCell.id,
                for: indexPath
            ) as? HomeCategoryCell else { fatalError("Unable to dequeue HomeCategoryCell.")
            }
            
            cell.categoryDelegate = self
            
            cell.chartsUpdate(homeSegment)
            
            cell.categoriesArrCellData = HomeCategoryCell.packBins(data: categoriesArr).1
                        
            return cell
        case HomeOperationCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeOperationCell.id,
                for: indexPath
            ) as? HomeOperationCell else { fatalError("Unable to dequeue HomeOperationCell.")
            }

            cell.monthSectionsCellData = monthSections

            return cell
        default:
            fatalError("no section")
        }
    }
    
    // Отступы по краям ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case HomeDateCell.id:
            return .init(top: 0, left: 0, bottom: 16, right: 0)
        case HomeCategoryCell.id:
            return .init(top: 0, left: 0, bottom: 32, right: 0)
        case HomeOperationCell.id:
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        default:
            fatalError("no section")
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellIdentifier(for: indexPath) {
        case HomeDateCell.id:
            return HomeDateCell.size()
        case HomeCategoryCell.id:
            return HomeCategoryCell.size(categoryIsHidden: categoryIsHidden, data: HomeCategoryCell.packBins(data: categoriesArr).0)
        case HomeOperationCell.id:
            return HomeOperationCell.size(data: monthSections)
        default:
            fatalError("no section")
        }
    }
    
}
