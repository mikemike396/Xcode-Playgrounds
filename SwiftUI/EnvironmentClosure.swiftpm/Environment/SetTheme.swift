//
//  SetTheme.swift
//  
//
//  Created by Michael Kushinski on 1/21/24.
//

import SwiftUI

struct SetTheme {
    let action: (Theme.Style) -> Void
    
    init(_ action: @escaping (Theme.Style) -> Void) {
        self.action = action
    }
    
    func callAsFunction(value: Theme.Style) {
        action(value)
    }
}

private enum SetThemeKey: EnvironmentKey {
    static var defaultValue = SetTheme { _ in }
}

extension EnvironmentValues {
    var setTheme: SetTheme {
        get { self[SetThemeKey.self] }
        set { self[SetThemeKey.self] = newValue }
    }
}
