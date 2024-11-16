import SwiftUI

enum SelectType {
    case image
    case text
}
struct ContentView: View {
    let generatedMessage = "🌟 Calling all app users! Your feedback shapes the future of our app! Keep those brilliant feature suggestions coming and upvote the ones you love. Let's create something amazing together! 🚀💡 https://smartpostapp.featureos.app/ #AppFeedback #UserEngagement #InnovateTogether"
    @State var isExpanded: Bool = false
    @State var generatedImageURL = URL(string: "https://picsum.photos/1000?v=\(Int.random(in: 0...1000))")
    @State var message: String = ""
    @State var images: [URL] = []
    
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
                            .padding(.top, 10)
                        Divider()
                            .frame(width: 225)
                        actionButtonsView
                            .padding(.top, 10)
                        imageGalleryView
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
        TextField("What's on your mind?", text: $message, axis: .vertical)
            .font(.title)
            .foregroundStyle(.primary)
            .frame(minHeight: 75, alignment: .top)
            .onSubmit {
                isExpanded = true
            }
            .padding(.top, 10)
    }
    
    private var actionButtonsView: some View {
        HStack(spacing: 20) {
            Button("Add Media", systemImage: "plus") {}
                .font(.footnote)
            Button("AI Assistant", systemImage: "wand.and.sparkles") {}
                .font(.footnote)
        }
    }
    
    private var imageGalleryView: some View {
        ForEach(images, id: \.absoluteString) { url in
            AsyncImage(
                url: url,
                transaction: .init(animation: .default)
            ) { image in
                image
                    .image?.resizable()
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.rect(cornerRadius: 15.0))
                    .transition(.opacity)
                    .overlay(alignment: .topTrailing) {
                        removeButton {
                            withAnimation {
                                images.removeAll { $0 == url }
                            }
                        }
                    }
            }
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
                    Image(systemName: "chevron.up")
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
        Text(generatedMessage)
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
                selectButton {
                    message = generatedMessage
                }
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
                    selectButton {
                        if let generatedImageURL {
                            images.append(generatedImageURL)
                        }
                    }
                }
        }
    }

    @ViewBuilder
    private func regenerateButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.clockwise")
                .font(.title3)
                .fontWeight(.regular)
                .foregroundStyle(.white.opacity(0.85))
                .padding(8)
                .background {
                    Color(.secondaryLabel.withAlphaComponent(0.6))
                        .clipShape(.circle)
                }
        }
    }

    @ViewBuilder
    private func selectButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.up.square")
                .font(.title3)
                .fontWeight(.regular)
                .foregroundStyle(.white.opacity(0.85))
                .padding(5)
                .background {
                    Color(.secondaryLabel.withAlphaComponent(0.6))
                        .clipShape(.rect(cornerRadius: 8.0))
                }
        }
        .padding(10)
    }
    
    @ViewBuilder
    private func removeButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.85))
                .padding(8)
                .background {
                    Color(.secondaryLabel.withAlphaComponent(0.6))
                        .clipShape(.circle)
                }
        }
        .padding(10)
    }
}
