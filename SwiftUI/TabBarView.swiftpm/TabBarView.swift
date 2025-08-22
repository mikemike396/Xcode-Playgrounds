//
//  ContentView.swift
//  ContentView
//
//  Created by Michael Kushinski on 8/22/25.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [
        .yellow,
        .blue,
        .green,
        .indigo,
        .brown
    ]

    let tabbarItems = [
        "Crime",
        "Sports",
        "Local",
        "Racing",
        "Home"
    ]

    @State var selectedIndex = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedIndex) {
                ForEach(colors.indices, id: \.self) { index in
                    Text(tabbarItems[selectedIndex])
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            colors[index]
                                .ignoresSafeArea()
                        }
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            TabBarView(
                tabbarItems: tabbarItems,
                selectedIndex: $selectedIndex
            )
            .padding(
                .horizontal
            )
        }
    }
}

struct TabBarView: View {
    @Namespace private var tabBarItemTransition

    var tabbarItems: [String]
    @Binding var selectedIndex: Int

    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabbarItems.indices, id: \.self) { index in
                        TabbarItem(
                            name: tabbarItems[index],
                            isActive: selectedIndex == index,
                            namespace: tabBarItemTransition
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedIndex = index
                            }
                        }
                    }
                }
            }
            .onChange(of: selectedIndex) { index in
                withAnimation {
                    reader.scrollTo(index, anchor: .center)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(25)
        }
    }
}

struct TabbarItem: View {
    var name: String
    var isActive: Bool = false
    let namespace: Namespace.ID

    var body: some View {
        if isActive {
            Text(name)
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .foregroundColor(.black)
                .overlay(alignment: .bottom) {
                    Color.blue
                        .frame(height: 3)
                        .padding(.horizontal, 14)
                        .matchedGeometryEffect(id: "highlightmenuitem", in: namespace)
                }
        } else {
            Text(name)
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .foregroundColor(.black)
        }

    }
}
