//
//  PremiumAlert.swift
//  CoinTail
//
//  Created by Eugene on 20.12.23.
//

import UIKit


final class PremiumAlert: UIViewController, UIPopoverPresentationControllerDelegate {
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        
        return view
    }()
    
    let overlayView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0
        
        return view
    }()
    
    let buyPremiumButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.setTitle("Buy premium".localized(), for: .normal)
        
        return button
    }()
    let dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("✖️", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Premium function".localized()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.sizeToFit()
        
        return label
    }()
    static var descriptionText: String = ""
    let descriptionLabel = getDescriptionLabel(text: descriptionText)
    
    let crownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "crownEmoji")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    public required init(description: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
        
        PremiumAlert.descriptionText = description
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        alertSubviews()
        alertActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.overlayView.alpha = 0.3
        }
    }
    
}
