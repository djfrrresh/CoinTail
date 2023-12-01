//
//  BasicVCFuncs.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import EasyPeasy


extension BasicVC {
    
    func pickerSubview() {
        self.view.addSubview(itemsPickerView)
        self.view.addSubview(pickerToolBar)
        
        itemsPickerView.easy.layout([
            Left(),
            Right(),
            Height(200),
            Bottom(-300).to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        pickerToolBar.easy.layout([
            Left(),
            Right(),
            Height(44),
            Bottom().to(itemsPickerView, .top)
        ])
    }
    
    // Всплывающий алерт при ошибке
    func errorAlert(_ message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        let alertView = UIAlertController(title: "Error".localized(), message: message, preferredStyle: .alert)
        
        alertView.addAction(alertAction)
        
        self.present(alertView, animated: true)
    }
    
    // Алерт с подтверждением действия
    func confirmationAlert(title: String, message: String, confirmActionTitle: String, confirmActionHandler: @escaping () -> Void) {
        let confirmAction = UIAlertAction(title: confirmActionTitle, style: .default) { _ in
            confirmActionHandler()
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertView.addAction(confirmAction)
        alertView.addAction(cancelAction)
        
        self.present(alertView, animated: true)
    }
    
    // Настройка title для контроллера
    func setupNavigationTitle(title: String, large: Bool = false) {
        prefersLargeTitle = large
        navigationController?.navigationBar.prefersLargeTitles = large
        navigationItem.largeTitleDisplayMode = large ? .always : .never
        
        if large {
            navigationItem.title = title
            navigationItem.setValue(1, forKey: "__largeTitleTwoLineMode")
        } else {
            let titleLabel: UILabel = {
                let label = UILabel()
                label.text = title
                label.textAlignment = .center
                label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
                label.textColor = UIColor(named: "black")
                
                return label
            }()
            
            navigationItem.titleView = titleLabel
        }
    }
    
    @objc func doneButtonAction() {
        hidePickerView()
    }
    
    func setupToolBar() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonAction)
        )

        pickerToolBar.setItems([doneButton], animated: true)
    }
    
    func showPickerView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.itemsPickerView.isHidden = false
            strongSelf.pickerToolBar.isHidden = false
            strongSelf.itemsPickerView.easy.layout(
                Bottom()
            )
            strongSelf.view.layoutIfNeeded()
        }
        isPickerHidden = false
    }
    
    func hidePickerView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.itemsPickerView.easy.layout(
                Bottom(-300).to(strongSelf.view.safeAreaLayoutGuide, .bottom)
            )
            strongSelf.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.itemsPickerView.isHidden = true
            self?.pickerToolBar.isHidden = true
        }
        isPickerHidden = true
    }
    
    func setupNavigationTitle(title: String, large: Bool = false, selector: Selector) {
        prefersLargeTitle = large
        navigationController?.navigationBar.prefersLargeTitles = large
        navigationItem.largeTitleDisplayMode = large ? .always : .never
        
        if large {
            let titleView = UIView()
            let titleLabel = UILabel()
            titleLabel.text = title
            titleView.addSubview(titleLabel)
            
            navigationItem.titleView = titleView
            navigationItem.setValue(1, forKey: "__largeTitleTwoLineMode")
        } else {
            let titleLabel: UILabel = {
                let label = UILabel()
                label.text = title
                label.textAlignment = .center
                label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
                label.textColor = UIColor(named: "black")
                
                return label
            }()
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: selector
            )
            
            navigationItem.titleView = titleLabel
        }
    }
    
    // Убрать клавиатуру при нажатии на экран за пределы клавиатуры
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
    
    static func noDataViewSize(noDataLabel: UILabel, descriptionLabel: UILabel) -> CGFloat {
        let padding: CGFloat = 16.0
        let imagePadding: CGFloat = 32.0
        
        let textWidth = UIScreen.main.bounds.width - (2 * padding)
    
        let noDataLabelHeight: CGFloat = noDataLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let descriptionHeight: CGFloat = descriptionLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let imageViewHeight: CGFloat = 100.0
        let buttonHeight: CGFloat = 52.0
        
        let viewHeight = imageViewHeight + imagePadding + noDataLabelHeight + descriptionHeight + padding * 2 + buttonHeight
                        
        return viewHeight
    }
    
}

extension BasicVC: UITextFieldDelegate {
    
    // Обработка нажатия Return на клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Закрыть клавиатуру
        
        return true
    }
    
}
