//
//  HomeTVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import EasyPeasy


extension HomeVC: UITableViewDelegate {
    
    // Высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

    // Дата в header'е группы ячеек
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = monthSections[section]
        
        let date = section.month
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_EN")
            return formatter
        }()
        dateFormatter.dateFormat = "MMMM yyyy"

        let dateLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = dateFormatter.string(from: date)
            return label
        }()
        
        let dateView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 8
            view.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.953, alpha: 1)
            return view
        }()
    
        dateView.addSubview(dateLabel)
        dateLabel.easy.layout([CenterY(), CenterX()])
        
        return dateView
    }
    
}
