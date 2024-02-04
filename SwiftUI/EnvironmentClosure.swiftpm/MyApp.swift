//
//  MyApp.swift
//  EnvironmentClosure
//
//  Created by Michael Kushinski on 1/21/24.
//

import SwiftUI

@main
struct MyApp: App {
    @State private var currentStyle = Theme.Style.light
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.theme, .init(
                    style: currentStyle,
                    updateStyle: { currentStyle = $0 }
                ))
                /// Demonstrates `callAsFunction`
                //.environment(\.setTheme, .init { currentStyle = $0 })
        }
    }
}
