//
//  SettingsCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 30.08.23.
//

import UIKit


extension SettingsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Переход на контроллер
//    func pushVC(vc: UIViewController) {
//        self.navigationItem.rightBarButtonItem?.target = nil
//
//        let vc = vc
//        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
//
//        navigationController?.pushViewController(vc, animated: true)
//    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsMenu.count
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SettingsCell.id,
            for: indexPath
        ) as? SettingsCell else {
            fatalError("Unable to dequeue SettingsCell.")
        }
        
        cell.menuLabel.text = settingsMenu[indexPath.row]
        cell.menuImage.image = UIImage(systemName: settingsMenuImages[indexPath.row])
                    
        return cell
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SettingsCell.size()
    }
    
}
