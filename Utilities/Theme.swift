//
//  Theme.swift
//  SSC
//
//  Created by Ashish Dutt on 30/03/23.
//

import Foundation
import SwiftUI

let backgroundGradient: [Color] = [Color(red: 0.86, green: 0.04, blue: 0.37), Color(red: 0.44, green: 0.00, blue: 0.93)]

struct Theme {
    static var generalBackground: LinearGradient {
        LinearGradient(gradient: Gradient(colors: backgroundGradient), startPoint: .top, endPoint: .bottom)
    }
    
    static func ellipsesTopLeading(forScheme scheme: ColorScheme) -> Color {
        let any = Color(red: 0.70, green: 0.3, blue: 0.85, opacity: 0.81)
        let dark = Color(red: 0.98, green: 0.00, blue: 0.75, opacity: 80.0)
        switch scheme {
        case .light:
            return any
        case .dark:
            return dark
        @unknown default:
            return any
        }
    }

    static func ellipsesTopTrailing(forScheme scheme: ColorScheme) -> Color {
        let any = Color(red: 1.00, green: 0.52, blue: 0.70, opacity: 0.5)
        let dark = Color(red: 1.00, green: 0.52, blue: 0.70, opacity: 0.61)
        switch scheme {
        case .light:
            return any
        case .dark:
            return dark
        @unknown default:
            return any
        }
    }

    static func ellipsesBottomTrailing(forScheme scheme: ColorScheme) -> Color {
        Color(red: 0.60, green: 0.00, blue: 0.94, opacity: 0.7)
    }

    static func ellipsesBottomLeading(forScheme scheme: ColorScheme) -> Color {
        let any = Color(red: 0.28, green: 0.00, blue: 0.85, opacity: 0.55)
        let dark = Color(red: 0.28, green: 0.00, blue: 0.85, opacity: 0.45)
        switch scheme {
        case .light:
            return any
        case .dark:
            return dark
        @unknown default:
            return any
        }
    }
}


