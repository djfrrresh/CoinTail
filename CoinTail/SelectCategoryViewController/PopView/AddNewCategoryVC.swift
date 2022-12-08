//
//  CustomPopVC.swift
//  CoinTail
//
//  Created by Eugene on 15.11.22.
//

import UIKit
import EasyPeasy


class CustomPopVC: UIViewController, UIGestureRecognizerDelegate {
    
    var collectionView: UICollectionView?
    
    weak var addNewCategoryDelegate: AddNewCategory?

    // Иконки для новых категорий
    var newCategoryImages = ["trash", "text.book.closed", "graduationcap", "mustache", "die.face.3", "stethoscope.circle", "theatermasks.circle", "airplane.circle", "bicycle", "fuelpump.circle"]
    
    var selectedCategoryImage: String?
    
    // Всплывающее окно добавления новой категории
    var popUpView: UIView = {
       let popUp = UIView()
        popUp.layer.cornerRadius = 15
        popUp.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        popUp.layer.borderWidth = 1
        popUp.layer.masksToBounds = true
        popUp.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return popUp
    }()
    
    var titleLabel = UILabel()
    var categoryTextField = UITextField()
    var errorLabel = UILabel()
    var addButton = UIButton()
    
    // Ссылка на AddNewOperationPopVC, на объекты внутри него
    let popVC: AddNewOperationPopVC
    // Инициализация переменной popVC
    init(popVC: AddNewOperationPopVC) {
        self.popVC = popVC
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.85)
        
        addButton.addTarget(self, action: #selector(addNewItem), for: .touchUpInside)
        setObjectsSettings() // Настройки для элементов
        setConstraints() // Расположение элементов
        createCollectionView() // Создание ячеек
    }
    
    // Проверка на наличие текста и выбранной иконки, вывод ошибки или закрытие PopVC
    @objc private func addNewItem(_ sender: UIButton) {
        if (addCategory() == false) {
            print("error")
        } else {
            addNewCategoryDelegate?.sendNewCategoryData(name: categoryTextField.text!, image: selectedCategoryImage!)
            popVC.addItemToEnd()
            
            dismiss(animated: true, completion: nil)
        }
    }
}
