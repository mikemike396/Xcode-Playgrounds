//
//  ContentView.swift
//  EnvironmentClosure
//
//  Created by Michael Kushinski on 1/21/24.
//

import SwiftUI

struct ContentView : View {
    @Environment(\.theme) var theme: Theme
    @Environment(\.setTheme) var setTheme: SetTheme
    
    @State var showSheet = false
    
    var body: some View {
        VStack {
            Button("Toggle Dark") {
                setTheme(value: .dark)
            }
            
            Button("Toggle Light") {
                setTheme(value: .light)
            }
            
            Button("Show Sheet") {
                showSheet = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(theme.background))
        .foregroundStyle(theme.text)
        .sheet(isPresented: $showSheet) {
            Sheet()
        }
    }
}
