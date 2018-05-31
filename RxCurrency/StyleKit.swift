//
//  StyleKit.swift
//  RxCurrency
//
//  Created by Michael Remondi on 5/29/18.
//  Copyright © 2018 Michael Remondi. All rights reserved.
//

import Foundation
import UIKit

/// This struct contains style information and tools for the app.
struct StyleKit {
    
    struct Font{
        static let thin = "AppleSDGothicNeo-Thin"
        static let regular = "AppleSDGothicNeo-Regular"
        static let semiBold = "AppleSDGothicNeo-SemiBold"
        static let bold = "AppleSDGothicNeo-Bold"
    }
    
    // Main theme colors for the app
    struct Colors {
        static let marketClosedBackground = UIColor(red: 46/255.0, green: 46/255.0, blue: 46/255.0, alpha: 1.0)
        static let marketOpenBackground = UIColor.white
        static let marketUpLine = UIColor(red: 120/255.0, green: 217/255.0, blue: 117/255.0, alpha: 1.0)
        static let marketDownLine = UIColor(red: 197/255.0, green: 79/255.0, blue: 79/255.0, alpha: 1.0)
        static let activeBlue = UIColor(red: 118/255.0,green: 190/255.0, blue: 255/255.0, alpha: 1.0)
        static let inActiveBlue = UIColor(red: 173/255.0, green: 214/255.0, blue: 255/255.0, alpha: 1.0)
    }
}
