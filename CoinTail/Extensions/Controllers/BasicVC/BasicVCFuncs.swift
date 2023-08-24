//
//  BasicVCFuncs.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit


extension BasicVC {
    
    // Всплывающий алерт при ошибке
    func errorAlert(_ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alertView.addAction(alertAction)
        self.present(alertView, animated: true)
    }
    
    // Создание стака между элементами
    func setStack(stack: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, viewsArray: [UIView]) {
        stack.axis = axis
        stack.spacing = spacing
        stack.alignment = alignment // Выравнивание
        stack.distribution = distribution // Заполнение
        
        for view in viewsArray {
            stack.addArrangedSubview(view)
        }
    }
    
    // Убрать клавиатуру при нажатии на экран
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(endEditingRecognizer())
        navigationController?.navigationBar.addGestureRecognizer(endEditingRecognizer())
    }
    // Регистрирует нажатия на экран
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
}
