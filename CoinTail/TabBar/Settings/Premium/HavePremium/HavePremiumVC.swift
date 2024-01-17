//
//  HavePremiumVC.swift
//  CoinTail
//
//  Created by Eugene on 18.12.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import EasyPeasy


final class HavePremiumVC: BasicVC, UINavigationBarDelegate {
    
    var advantages: [AdvantagesData]
    var premiumUntil: String?

    let havePremiumCV: UICollectionView = {
        let havePremiumLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: havePremiumLayout)
        cv.backgroundColor = .clear
        cv.register(HavePremiumTitleCell.self, forCellWithReuseIdentifier: HavePremiumTitleCell.id)
        cv.register(HavePremiumImageCell.self, forCellWithReuseIdentifier: HavePremiumImageCell.id)
        cv.register(PremiumDescriptionCell.self, forCellWithReuseIdentifier: PremiumDescriptionCell.id)
        cv.register(PremiumAdvantagesCell.self, forCellWithReuseIdentifier: PremiumAdvantagesCell.id)
        cv.register(HavePremiumDateCell.self, forCellWithReuseIdentifier: HavePremiumDateCell.id)
        cv.register(PremiumAdvantagesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PremiumAdvantagesHeader.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.delaysContentTouches = true
        cv.isScrollEnabled = true
        
        return cv
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        let subLayer = CALayer()
        subLayer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        subLayer.borderWidth = 0.5
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: 0.5)
        subLayer.frame = CGRect(origin: .zero, size: size)
        
        view.layer.addSublayer(subLayer)
        
        return view
    }()
    
    let greatButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.backgroundColor = UIColor(named: "primaryAction")
        button.setTitle("Great".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter
    }()
    
    public required init(_ advantages: [AdvantagesData], expirationDate: Date) {
        self.advantages = advantages
        self.premiumUntil = "The current period will end".localized() + " \(dateFormatter.string(from: expirationDate))"
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        navigationController?.isNavigationBarHidden = true
        
        greatButton.addTarget(self, action: #selector(greatButtonAction), for: .touchUpInside)
        
        havePremiumCV.delegate = self
        
        havePremiumCV.dataSource = self
        
        havePremiumSubviews()
    }
    
}
