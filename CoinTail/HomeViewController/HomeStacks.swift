//
//  HomeStacks.swift
//  CoinTail
//
//  Created by Eugene on 13.12.22.
//

import UIKit
import EasyPeasy


extension HomeViewController {
    
    func setStack() {
        let expenseIncomeStack = UIStackView()
        let balanceStack = UIStackView()
        let finalStack = UIStackView()
        
        setLabel(label: expenseBalanceLabel, text: ("- \(Storage.shared.balance(.expense))"), fontSize: 30, alignment: .center)
        setLabel(label: incomeBalanceLabel, text: ("+ \(Storage.shared.balance(.income))"), fontSize: 30, alignment: .right)
        setLabel(label: balanceLabel, text: ("Balance: \(Storage.shared.balance(nil))"), fontSize: 30, alignment: .left)

        setUniqueStack(stack: expenseIncomeStack, axis: .horizontal, view_1: expenseBalanceLabel, view_2: incomeBalanceLabel)
        
        balanceStack.axis = .vertical
//        balanceStack.alignment = .fill // Выравнивание
//        balanceStack.distribution = .equalCentering // Заполнениe
        balanceStack.spacing = 6
        balanceStack.addArrangedSubview(balanceLabel)
        balanceStack.addArrangedSubview(expenseIncomeStack)
        
        finalStack.axis = .vertical
//        finalStack.alignment = .fill // Выравнивание
        finalStack.distribution = .equalCentering // Заполнение
        finalStack.spacing = 10
        finalStack.addArrangedSubview(balanceStack)
        finalStack.addArrangedSubview(pieChart)
        finalStack.addArrangedSubview(switchButton)
        finalStack.addArrangedSubview(tableView)
        
        view.addSubview(finalStack)
        finalStack.easy.layout([Left(16), Right(16), Top(10).to(view.safeAreaLayoutGuide, .top), Bottom(0), CenterX()])
    }
    
    // Создание стака между двумя элементами
    func setUniqueStack (stack: UIStackView, axis: NSLayoutConstraint.Axis, view_1: UIView, view_2: UIView?) {
        stack.axis = axis
        stack.addArrangedSubview(view_1)
        stack.addArrangedSubview(view_2!)
    }
    
}
