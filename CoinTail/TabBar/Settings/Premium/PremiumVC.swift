//
//  PremiumVC.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit


final class PremiumVC: BasicVC, PremiumPlansDelegate {
        
    func selectedPlanCell(_ index: Int, isSelectedBefore: Bool) {
        if isSelectedBefore {
            tapped()
        }
        
        plan = plans[index]
    }
    
    var selectedPlan: PlanData {
        return plan
    }
    var plans: [PlanData] {
        didSet {
            premiumCV.reloadData()
        }
    }
    var plan: PlanData! {
        didSet {
            buyPremiumButton.setTitle(plan.isTrial ? "Start trial subscription".localized() : "\(plan.buyButtonTitle.localized()) \(plan.price) RUB", for: .normal)
            
            premiumCV.reloadData()
        }
    }
    var planCellSizes: [CGSize]
    
    let buttonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
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
    
    public required init(_ arrayPlan: [PlanData]) {
        self.plans = arrayPlan
        self.planCellSizes = arrayPlan.map({ data in
            PlanCell.size(data)
        })
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        premiumCV.delegate = self

        premiumCV.dataSource = self
        
        getPlan()
        premiumSubviews()
        premiumTargets()
    }
    
}
