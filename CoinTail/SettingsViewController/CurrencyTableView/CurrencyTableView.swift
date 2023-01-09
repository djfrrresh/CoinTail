//
//  CurrencyTableView.swift
//  CoinTail
//
//  Created by Eugene on 27.12.22.
//

import UIKit
import EasyPeasy


class CurrencyTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let currencyTableView = UITableView()

    var allCurrencies: [String] = ["Dollar", "Euro", "Lari", "Tenge", "Ruble", "Sterling", "Japanese Yen", "Lira", "Zloty"]
    
    var searchBar = UISearchBar()
    var filteredData = [String]()
    var searching = false
    
    weak var currencyDelegate: sendSelectedCurrency?
    
    var searchBarTableViewStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.searchBar.easy.layout([Height(56)])
        self.currencyTableView.easy.layout([Height(600)])
        
        searchBarTableViewStack.axis = .vertical
        searchBarTableViewStack.alignment = .fill // Выравнивание
        searchBarTableViewStack.distribution = .equalCentering // Заполнение
        searchBarTableViewStack.spacing = 0
        searchBarTableViewStack.addArrangedSubview(searchBar)
        searchBarTableViewStack.addArrangedSubview(currencyTableView)
        view.addSubview(searchBarTableViewStack)
        searchBarTableViewStack.easy.layout([Left(0), Right(0), CenterY(), CenterX()])
                        
        self.filteredData = allCurrencies
        
        self.currencyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.currencyTableView.delegate = self // Реагирование на события
        self.currencyTableView.dataSource = self // Здесь подаются данные
        
        self.searchBar.delegate = self
    }
    
    // Задается количество ячеек
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredData.count
        } else {
            return allCurrencies.count
        }
    }
    
    // Ячейки заполняются
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currencyTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if searching {
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            cell.textLabel?.text = allCurrencies[indexPath.row]
        }
        return cell
    }
    
    // Выводит нажатия на ячейки
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.currencyTableView.deselectRow(at: indexPath, animated: true)
        print("Currency \(allCurrencies[indexPath.row]) tapped")
        
        currencyDelegate?.sendCurrency(currency: allCurrencies[indexPath.row])
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}

protocol sendSelectedCurrency: AnyObject {
    func sendCurrency(currency: String)
}
