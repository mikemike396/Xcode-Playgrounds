import SwiftUI

struct ContentView: View {
    @State var isExpanded: Bool = true
    @State var generatedImageURL = URL(string: "https://picsum.photos/1000")
    @State var suggestedTextSelected = false
    @State var suggestedImageSelected = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 20) {
                    Divider()
                    selectAccountView
                        .padding(.horizontal, 20)
                    Divider()
                }

                ScrollView {
                    VStack(alignment: .leading) {
                        messageView
                            .padding(.top, 15)
                            .padding(.bottom, 30)
                        Divider()
                            .frame(width: 225)
                        actionButtonsView
                            .padding(.top, 10)
                        suggestionsView
                            .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                }
            }
            .navigationTitle("Compose")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {}
                        .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Next") {}
                        .bold()
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    private var selectAccountView: some View {
        VStack {
            HStack {
                Text("Select Social Account")
                    .font(.title)
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "plus.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .fontWeight(.light)
            }
        }
    }
    
    private var messageView: some View {
        Text("Feedback is important to us. Let us know your thoughts.")
            .font(.title)
            .foregroundStyle(.primary)
    }
    
    private var actionButtonsView: some View {
        HStack(spacing: 20) {
            Button("Add Media", systemImage: "plus") {}
                .font(.footnote)
            Button("AI Assistant", systemImage: "wand.and.sparkles") {}
                .font(.footnote)
        }
    }
    
    private var suggestionsView: some View {
        VStack(spacing: 10) {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("Suggestions")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 0 : 180))
                        .animation(.default, value: isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                VStack {
                    generatedText
                    generatedImage
                }
            }
        }
    }

    private var generatedText: some View {
        Text("🌟 Calling all app users! Your feedback shapes the future of our app! Keep those brilliant feature suggestions coming and upvote the ones you love. Let's create something amazing together! 🚀💡 https://smartpostapp.featureos.app/ #AppFeedback #UserEngagement #InnovateTogether")
            .font(.system(size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(15)
            .background {
                Color(.secondaryLabel.withAlphaComponent(0.05))
                    .cornerRadius(15.0)
            }
            .overlay {
                regenerateButton {
                    generatedImageURL = URL(string: "https://picsum.photos/1000?v=\(Int.random(in: 0...1000))")
                }
            }
            .overlay(alignment: .topTrailing) {
                selectButton(selected: $suggestedTextSelected)
            }
    }

    private var generatedImage: some View {
        AsyncImage(
            url: generatedImageURL,
            transaction: .init(animation: .default)
        ) { image in
            image
                .image?.resizable()
                .frame(height: 200)
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 15.0))
                .transition(.opacity)
                .overlay {
                    regenerateButton {
                        generatedImageURL = URL(string: "https://picsum.photos/1000?v=\(Int.random(in: 0...1000))")
                    }
                }
                .overlay(alignment: .topTrailing) {
                    selectButton(selected: $suggestedImageSelected)
                }
        }
    }

    @ViewBuilder
    private func regenerateButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.clockwise")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.85))
                .padding(10)
                .background {
                    Color(.secondaryLabel.withAlphaComponent(0.6))
                        .clipShape(.circle)
                }
        }
    }

    @ViewBuilder
    private func selectButton(selected: Binding<Bool>) -> some View {
        Button {
            selected.wrappedValue.toggle()
        } label: {
            Image(systemName: selected.wrappedValue ? "checkmark.square" : "square")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(selected.wrappedValue ? .green : .white.opacity(0.85))
                .padding(5)
                .background {
                    Color(.secondaryLabel.withAlphaComponent(0.2))
                        .clipShape(.rect(cornerRadius: 8.0))
                }
        }
        .padding(10)
    }
}
