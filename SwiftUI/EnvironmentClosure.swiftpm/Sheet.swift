//
//  Sheet.swift
//  EnvironmentClosure
//
//  Created by Michael Kushinski on 1/21/24.
//

import SwiftUI

struct Sheet: View {
    @Environment(\.theme) var theme
    @Environment(\.setTheme) var setTheme: SetTheme
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button("Toggle Dark") {
                setTheme(value: .dark)
            }
            
            Button("Toggle Light") {
                setTheme(value: .light)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(theme.background))
        .foregroundStyle(theme.text)
    }
}

#Preview {
    Sheet()
}
