//
//  PremiumVC.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
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

import UIKit


final class PremiumVC: BasicVC, PremiumPlansDelegate {
        
    func selectedPlanCell(_ index: Int, isSelectedBefore: Bool) {
        if isSelectedBefore {
            buyButtonAction()
        }
        
        plan = plans[index]
    }
    
    var selectedPlan: PlanData {
        return plan
    }
    var plans: [PlanData] = [] {
        didSet {
            premiumCV.reloadData()
        }
    }
    var plan: PlanData! {
        didSet {
            buyPremiumButton.setTitle(plan.isTrial ? "Start trial subscription".localized() : "\(plan.buyButtonTitle.localized())", for: .normal)
            
            premiumCV.reloadData()
        }
    }
    var planCellSizes: [CGSize] = []
    
    let buttonBackgroundView: UIView = {
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
    let premiumNavBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    let premiumAppName: UILabel = {
        let label = UILabel()
        label.text = "CoinTail"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.textColor = .black
        label.sizeToFit()
        
        return label
    }()
    let premiumLabel: UILabel = {
        let label = UILabel()
        label.text = "Premium".localized()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.textColor = UIColor(named: "primaryAction")
        label.sizeToFit()
        
        return label
    }()
    
    let premiumStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.backgroundColor = .clear
        
        return stack
    }()
    
    let buyPremiumButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
    let navBarButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("✖️", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return button
    }()

    let premiumCV: UICollectionView = {
        let premiumLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: premiumLayout)
        cv.backgroundColor = .clear
        cv.register(PremiumDescriptionCell.self, forCellWithReuseIdentifier: PremiumDescriptionCell.id)
        cv.register(PremiumPlansCell.self, forCellWithReuseIdentifier: PremiumPlansCell.id)
        cv.register(PremiumPlansHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PremiumPlansHeader.id)
        cv.register(PremiumAdvantagesCell.self, forCellWithReuseIdentifier: PremiumAdvantagesCell.id)
        cv.register(PremiumPrivacyCell.self, forCellWithReuseIdentifier: PremiumPrivacyCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delaysContentTouches = true
        cv.alwaysBounceVertical = true
        cv.isScrollEnabled = true

        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RevenueCatService.shared.getOfferings(completion: { [self] plan in
            guard let plan = plan else { return }
            
            self.plans = plan
            self.planCellSizes = plan.map({ data in
                PlanCell.size(data)
            })
            
            buyPremiumButton.addTarget(self, action: #selector(buyButtonAction), for: .touchUpInside)
            
            premiumCV.delegate = self
            
            premiumCV.dataSource = self
            
            getPlan()
            premiumSubviews()
            premiumTargets()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
