import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(0...20, id: \.self) { item in
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello, world! \(item)")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Sick Title")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarColor(.white)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {} label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}


struct NavigationBarColor: ViewModifier {
    private let color: UIColor
    private let navigationBarAppearance = UINavigationBar.appearance()
    private let originalStandardAppearance: UINavigationBarAppearance
    private let originalCompactAppearance: UINavigationBarAppearance?
    private let originalScrollEdgeAppearance: UINavigationBarAppearance?
    private let originalCompactScrollEdgeAppearance: UINavigationBarAppearance?

    init(_ color: UIColor?) {
        self.color = color ?? .clear
        self.originalStandardAppearance = navigationBarAppearance.standardAppearance
        self.originalCompactAppearance = navigationBarAppearance.compactAppearance
        self.originalScrollEdgeAppearance = navigationBarAppearance.scrollEdgeAppearance
        self.originalCompactScrollEdgeAppearance = navigationBarAppearance.compactScrollEdgeAppearance

        setNavBarAppearance()
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(color)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                        .shadow(color: .gray.opacity(0.25), radius: 10, x: 0, y: 2.0)
                    Spacer()
                }
            }
        }
        .onAppear {
            setNavBarAppearance()
        }
        .onDisappear {
            restoreNavBarAppearance()
        }
    }

    private func setNavBarAppearance() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.shadowImage = nil
        coloredAppearance.backgroundColor = .clear

        navigationBarAppearance.standardAppearance = coloredAppearance
        navigationBarAppearance.compactAppearance = coloredAppearance
        navigationBarAppearance.scrollEdgeAppearance = coloredAppearance
        navigationBarAppearance.compactScrollEdgeAppearance = coloredAppearance
    }

    private func restoreNavBarAppearance() {
        navigationBarAppearance.standardAppearance = originalStandardAppearance
        navigationBarAppearance.compactAppearance = originalCompactAppearance
        navigationBarAppearance.scrollEdgeAppearance = originalScrollEdgeAppearance
        navigationBarAppearance.compactScrollEdgeAppearance = originalCompactScrollEdgeAppearance
    }
}

extension View {
    func navigationBarColor(_ color: UIColor?) -> some View {
        modifier(NavigationBarColor(color))
    }
}
