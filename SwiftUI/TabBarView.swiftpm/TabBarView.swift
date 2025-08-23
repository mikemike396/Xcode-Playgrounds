//
//  ContentView.swift
//  ContentView
//
//  Created by Michael Kushinski on 8/22/25.
//

import SwiftUI

struct ContentView: View {
    private let screenWidth = UIScreen.main.bounds.width
    let colors: [Color] = [
        .yellow,
        .blue,
        .green,
        .indigo,
        .brown
    ]

    let tabBarItems = [
        "Crime",
        "Sports",
        "Local",
        "Racing",
        "Home"
    ]

    @State var selectedIndex = 0
    @State private var selectedTabViewScrollPercentage: CGFloat = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedIndex) {
                ForEach(colors.indices, id: \.self) { index in
                    Text(tabBarItems[selectedIndex])
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            colors[index]
                                .ignoresSafeArea()
                        }
                        .tag(index)
                        .scrollOffset { offset in
                            guard selectedIndex == index else { return }

                            selectedTabViewScrollPercentage = offset.x / screenWidth
                            print("Scroll Progress: \(selectedTabViewScrollPercentage)")
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            TabBarView(
                tabBarItems: tabBarItems,
                selectedIndex: $selectedIndex,
                selectedTabViewScrollPercentage: selectedTabViewScrollPercentage
            )
            .padding(.horizontal)
        }
    }
}

struct TabBarView: View {
    @Namespace private var tabBarItemTransition

    var tabBarItems: [String]
    @Binding var selectedIndex: Int
    var selectedTabViewScrollPercentage: CGFloat

    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabBarItems.indices, id: \.self) { index in
                        TabBarItem(
                            namespace: tabBarItemTransition,
                            name: tabBarItems[index],
                            isActive: selectedIndex == index,
                            selectedTabViewScrollPercentage: selectedTabViewScrollPercentage
                        )
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                selectedIndex = index
                            }
                        }
                        .frame(height: 45)
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

struct TabBarItem: View {
    let namespace: Namespace.ID
    let name: String
    let isActive: Bool
    let selectedTabViewScrollPercentage: CGFloat

    @State private var itemWidth: CGFloat = 0

    var body: some View {
        Group {
            if isActive {
                Text(name)
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .foregroundColor(.black)
                    .overlay(alignment: .bottom) {
                        Color.blue
                            .frame(height: 4)
                            .padding(.horizontal, 14)
                            .offset(x: selectedTabViewScrollPercentage * itemWidth)
                            .alignmentGuide(.bottom) { d in
                                d[.bottom] - 6
                            }
                            .matchedGeometryEffect(id: "selectedItem", in: namespace)
                    }

            } else {
                Text(name)
                    .font(.subheadline)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .foregroundColor(.black)
            }
        }
        .onGeometryChange(for: CGSize.self) { proxy -> CGSize in
            proxy.size
        } action: { size in
            itemWidth = size.width
            print("Item Width: \(itemWidth)")
        }
    }
}
