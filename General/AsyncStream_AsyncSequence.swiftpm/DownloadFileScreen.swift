import SwiftUI

struct DownloadFileScreen: View {
    @State var downloadCount = 0
    @State var errorCount = 0

    let files = Array(1...6).map {
        File(name: "\($0)")
    }

    var downloadProgress: Double {
        Double(downloadCount) / Double(files.count)
    }

    var body: some View {
        VStack {
            Button("Download") {
                Task {
                    downloadCount = 0
                    errorCount = 0

                    let streams = downloadFileStream()
                    for try await file in streams {
                        if file.state == .error {
                            self.errorCount += 1
                        }
                        self.downloadCount += 1
                    }
                }
            }
            ProgressView(value: downloadProgress) {
                Text("Progress")
            }
            Text("Error: \(errorCount)")
                .opacity(errorCount == 0 ? 0.0 : 1.0)
                .foregroundStyle(.red)
        }
        .padding()
    }

    // MARK: AsyncStream Example

    func downloadFileStream() -> AsyncStream<File> {
        /// Using `unfolding` convenience initializer which can produce elements for the stream, and don’t want to invoke a continuation manually.
//        var index = 0
//
//        return AsyncStream {
//            guard index < files.count else {
//                return nil
//            }
//
//            let file = files[index]
//            index += 1
//
//            await file.download()
//            return file
//        }

        AsyncStream { continuation in
            Task {
                for file in files {
                    await file.download()
                    continuation.yield(file)
                }

                continuation.finish()
            }
        }
    }

    // MARK: Completion Example

    func download(completion: (String) -> Void) async throws {
         for file in files {
             try await file.download()
         }
         completion("Done")

 //        try await download { complete in
 //            print(complete)
 //        }
     }

    // MARK: Combine Example
}
