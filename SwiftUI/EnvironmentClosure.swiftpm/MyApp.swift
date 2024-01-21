//
//  MyApp.swift
//  EnvironmentClosure
//
//  Created by Michael Kushinski on 1/21/24.
//

import SwiftUI

@main
struct MyApp: App {
    @State private var theme = Theme(style: .light)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.theme, theme)
                .environment(\.setTheme, .init { theme.style = $0 })
        }
    }
}
