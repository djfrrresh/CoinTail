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
                label.textColor = .black
                
                return label
            }()
            
            navigationItem.titleView = titleLabel
        }
    }
    
    func setupNavigationTitle(title: String, large: Bool = false, selector: Selector) {
        prefersLargeTitle = large
        navigationController?.navigationBar.prefersLargeTitles = large
        navigationItem.largeTitleDisplayMode = large ? .always : .never
        
        if large {
            let titleView = UIView()
            let titleLabel = UILabel()
            titleLabel.text = title
//            titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            
//            let addButton = UIBarButtonItem(
//                barButtonSystemItem: .add,
//                target: self,
//                action: selector
//            )
            
//            guard let customView = addButton.customView else { return }
            
            titleView.addSubview(titleLabel)
//            titleView.addSubview(customView)
            
            navigationItem.titleView = titleView
            navigationItem.setValue(1, forKey: "__largeTitleTwoLineMode")
        } else {
            let titleLabel: UILabel = {
                let label = UILabel()
                label.text = title
                label.textAlignment = .center
                label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
                label.textColor = .black
                
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
    
    // Эмодзи из строки в картинку
    func emojiToImage(emoji: String) -> UIImage? {
        // Строка из эмодзи
        let text = NSAttributedString(string: emoji, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 72)])
        
        // Контекст для рендеринга изображения
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 100), false, 0)
        
        // Рисунок эмодзи на контексте
        text.draw(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        // Получение изображение из контекста
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // Завершение контекста
        UIGraphicsEndImageContext()
        
        return image
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
        let noDataLabelWidth = noDataLabel.sizeThatFits(CGSize.zero).width
        let descriptionWidth = descriptionLabel.sizeThatFits(CGSize.zero).width
        
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
