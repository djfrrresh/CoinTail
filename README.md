# Table of Contents
1. [CoinTail description](#cointail-description)
2. [Screenshots](#screenshots)
3. [Structure](#structure)
4. [Requirements](#requirements)
5. [Dependencies](#dependencies)
6. [API](#api)
7. [Meta](#meta)

## CoinTail description
<p>CoinTail is a straightforward iOS application designed to optimize financial management.<br> 
Users can easily record their expenses and income, create categories, manage accounts, and monitor their budget through an intuitive design. Notifications for daily or weekly entries help maintain financial discipline.<br> 
CoinTail provides visualization of financial data using diagrams and also supports multi-currency transactions with easy currency conversion. The ability to analyze and make informed decisions makes CoinTail a valuable tool for effective financial management.</p>

## Screenshots
<img src="images/main.png" alt="Main menu" width="50%" style="display:block; margin:0 auto;">
<img src="images/budgets.png" alt="Budgets and categories" width="50%" style="display:block; margin:0 auto;">
<img src="images/accounts.png" alt="Accounts and transfer money" width="50%" style="display:block; margin:0 auto;">
<img src="images/settings.png" alt="Settings and payment screen" width="50%" style="display:block; margin:0 auto;">

## Structure 
* "Application": Application launch files (info.plist, AppDelegate.swift, LaunchScreen.storyboard).
* "Storage": Models and singletons for managing them, setting up the Realm database, Keychain for storing API keys, setting up RevenueCat for working with payments, currency conversion API.
* "TabBar": Hierarchy of screens located on the TabBar. 
* "Extensions": Extensions to standard classes for UIKit, Foundation and RevenueCat. Basic controller classes to simplify working with screens.
* "Resources": Fonts, assets with pictures and colors, Localizable files for translation into Russian.
  
## Requirements
- iOS 12.0+
- Xcode 14.0+

## Dependencies
[CocoaPods](https://cocoapods.org) is used as a dependency manager.
List of dependencies: 
* pod 'EasyPeasy' -> A library that makes it easy to organize constraints and animations for the user interface.
* pod 'RevenueCat' -> Toolkit for managing paid subscriptions, providing a turnkey solution for implementing and tracking payments.
* pod 'SwiftLint' -> A tool for automatically checking the style and conventions of Swift code, ensuring consistency and cleanliness of code.
* pod 'RealmSwift' -> A database for storing and managing data in Swift, providing a convenient interface for working with objects and queries.
* pod 'Charts' -> A library for creating colorful and interactive charts that provide powerful data visualization.

### Installation
Place the following code in your `Podfile`:
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'

target 'CoinTail' do
  use_frameworks!

  pod 'EasyPeasy'
  pod 'RevenueCat'
  pod 'RealmSwift'
  pod 'SwiftLint'
  pod 'Charts'

end
```

To access the contents of the pods, import modules wherever you import UIKit:

``` swift
import UIKit
import RealmSwift
```

## API 
API requests for currency conversion are taken from the site https://app.exchangerate-api.com.<br>
For the API to work correctly, you need to register on the website and get the key in the [dashboard tab](https://app.exchangerate-api.com/dashboard). This key should then be placed in <b>CoinTail->Storage->Keychain->KeychainManager.swift</b> in the <b>apiKey</b> constant

## Meta
Gmail – kunavinjenya55@gmail.com<br>
Telegram - https://t.me/just_eugeny<br>
LinkedIn - https://www.linkedin.com/in/kunav1n/
