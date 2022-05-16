import Foundation
import _Concurrency
import SwiftUI
import PlaygroundSupport

struct Model: Decodable, Hashable {
    let url: URL
}

class ViewModel: ObservableObject {
    let apiURL = "https://jsonplaceholder.typicode.com/photos"
    @Published var images: [Model] = []
    
    func loadData() async {
        do {
            guard let url = URL(string: apiURL) else { return }
            images = try await getImageUrls(from: url)
        } catch {
            // Handle Error
        }
    }
    
    func getImageUrls(from url: URL) async throws -> [Model] {
        let (data, response) = try await URLSession.shared.data(from: url)
        let results = try JSONDecoder().decode([Model].self, from: data)
        return results
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.images.shuffled().prefix(50), id: \.self) { image in
                    AsyncImage(
                        url: image.url,
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
            }
        }
        .task {
            await viewModel.loadData()
        }
    }
}


let view = ContentView()
let hostingVC = UIHostingController(rootView: view)
PlaygroundPage.current.liveView = hostingVC
