//
//  NotificationsVC.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//

import UIKit
import UserNotifications


class NotificationsVC: BasicVC {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let notificationsSwitcher: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            NotificationPeriods.day.rawValue,
            NotificationPeriods.week.rawValue
        ])
        
        return segmentedControl
    }()
    var notificationSegment: NotificationPeriods = Notifications.shared.periodSwitcher
    
    let onOffToggle: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = Notifications.shared.toggleStatus
        
        return uiSwitch
    }()
    
    let onOffLabel = UILabel(text: "Enable / disable reminder")
    let periodLabel = UILabel(text: "Select period")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Проверка доступа к уведомлениям на случай, если юзер выключит их в настройках при включенных уведомлениях на экране
        notificationCenter.requestAuthorization(options: [.alert, .badge ,.sound]) { [weak self] granted, _ in
            guard let strongSelf = self else { return }

            if !granted {
                DispatchQueue.main.async {
                    strongSelf.onOffToggle.isOn = false
                    
                    Notifications.shared.toggleStatus = strongSelf.onOffToggle.isOn
                }
            }
        }
        
        currentNotificationSegment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notifications"
                
        notificationsSubviews()
        notificationTargets()
    }
    
}
