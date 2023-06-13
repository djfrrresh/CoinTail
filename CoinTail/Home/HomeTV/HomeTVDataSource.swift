//
//  HomeTVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


//extension HomeVC: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        monthSections.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let monthSection = monthSections[section].records
//
//        return monthSection[segment]?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTVCell.id, for: indexPath) as? HomeTVCell else {
//            fatalError("Unable to dequeue CustomCell.")
//        }
//        cell.selectionStyle = .none
//
//        let recordData: Record?
//        let section = monthSections[indexPath.section]
//
//        let record = [Record(amount: 1, categoryImage: UIImage(systemName: "trash")!, date: Date(), id: 0, type: .expense, categoryColor: .black)]
//
//        if segment == .allOperations {
//            let allRecordsArr: [Record] =
//            (section.records[.income] ?? record) +
//            (section.records[.expense] ?? record)
//
//            recordData = allRecordsArr[indexPath.row]
//        } else {
//            recordData = section.records[segment]?[indexPath.row]
//        }
//
//        let image = recordData?.categoryImage
//        let amount = "\(recordData?.amount ?? 1)"
//        let category = recordData?.categoryText
//        let backView = recordData?.categoryColor
//
//        cell.amountLabel.text = amount
//        cell.categoryLabel.text = category
//        cell.categoryImage.image = image
//        cell.backImage.backgroundColor = backView
//
//        // Ставит цвет в зависимости от типа операции
//        setAmountColor(
//            recordType: RecordType(
//                rawValue: (recordData?.type)?.rawValue ?? "allOperations") ?? .allOperations,
//            cell: cell,
//            amountLabel: cell.amountLabel
//        )
//
//        return cell
//    }
    
//}
