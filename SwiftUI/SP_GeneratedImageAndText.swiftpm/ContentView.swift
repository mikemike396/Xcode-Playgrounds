import SwiftUI

struct ContentView: View {
    @State var isExpanded: Bool = true
    
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
        Text("What's on your mind?")
            .font(.title)
            .foregroundStyle(.secondary)
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
        VStack {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("Suggestions")
                        .font(.body)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 0 : 180))
                        .animation(.default, value: isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                AsyncImage(
                    url: URL(string: "https://picsum.photos/1000"),
                    transaction: .init(animation: .default)
                ) { image in
                    image
                        .image?.resizable()
                        .frame(height: 200)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.rect(cornerRadius: 15.0))
                        .transition(.opacity)
                }
            }
        }
    }
}
