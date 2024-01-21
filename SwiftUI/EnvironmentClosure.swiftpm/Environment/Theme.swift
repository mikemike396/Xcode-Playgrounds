//
//  Theme.swift
//
//
//  Created by Michael Kushinski on 1/21/24.
//

import SwiftUI

struct Theme {
    enum Style {
        case dark
        case light
        
        var background: Color {
            switch self {
            case .dark:
                return .black
            case .light:
                return .white
            }
        }
        
        var text: Color {
            switch self {
            case .dark:
                return .white
            case .light:
                return .black
            }
        }
    }
    
    var style: Style
    
    var background: Color {
        style.background
    }
    
    var text: Color {
        style.text
    }
    
    init(style: Theme.Style) {
        self.style = style
    }
}

extension EnvironmentValues {
    enum ThemeKey: EnvironmentKey {
        static let defaultValue: Theme = .init(style: .light)
    }

    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}


