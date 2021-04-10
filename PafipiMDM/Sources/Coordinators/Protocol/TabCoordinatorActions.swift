//
//  TabCoordinatorActions.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 26/03/2021.
//

import UIKit

protocol TabCoordinatorActions {
    
    func createTabBarItem(title: String,
                          image: UIImage,
                          selectedImage: UIImage,
                          accessbilityIdentifier: String,
                          accessibilityLabel: String) -> UITabBarItem
}

extension TabCoordinatorActions {
    
    func createTabBarItem(title: String = "",
                          image: UIImage,
                          selectedImage: UIImage,
                          accessbilityIdentifier: String,
                          accessibilityLabel: String) -> UITabBarItem {
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabItem.accessibilityIdentifier = accessbilityIdentifier
        tabItem.accessibilityLabel = accessibilityLabel
        return tabItem
    }
}
