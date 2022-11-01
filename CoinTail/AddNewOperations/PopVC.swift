//
//  AddNewOperationPopVC.swift
//  CoinTail
//
//  Created by Eugene on 27.10.22.
//

import UIKit
import EasyPeasy


class AddNewOperationPopVC: UIViewController {
    
    weak var categoryDelegate: СategorySendText? // Переменная делегата, связывающая протокол с собой
        
    var categories: [String]
    
    var tableView = UITableView()
        
    public required init(_ categories: [String]) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.view.backgroundColor = .white.withAlphaComponent(1)

        self.navigationController?.navigationBar.tintColor = .black
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self // Реагирование на события
        self.tableView.dataSource = self // Здесь подаются данные
                                                
        self.view.addSubview(tableView)
        self.tableView.easy.layout([CenterX(), CenterY(), Top(50), Bottom(0), Left(0), Right(0)])
    }
}
