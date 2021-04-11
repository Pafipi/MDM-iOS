//
//  Colors.swift
//  Core
//
//  Created by Piotr Fraccaro on 10/04/2021.
//

import UIKit

public struct Colors {
    
    public struct Common {
        public static let background = UIColor(named: "background") ?? .white
        public static let tint = UIColor(named: "tabBarTint") ?? .systemBlue
        public static let black = UIColor(named: "black") ?? .black
        public static let justBlack = UIColor(named: "justBlack") ?? .black
        public static let white = UIColor(named: "white") ?? .white
        public static let justWhite = UIColor(named: "justWhite") ?? .white
        public static let placeholder = UIColor(named: "placeholder") ?? .darkGray
        public static let error = UIColor(named: "error") ?? .red
        public static let success = UIColor(named: "success") ?? .green
        public static let disabledButtonColor = UIColor(named: "disabledButtonColor") ?? .lightGray
    }
    
    public struct Form {
        public static let inputBackground = UIColor(named: "inputBackground") ?? .gray
    }
}
