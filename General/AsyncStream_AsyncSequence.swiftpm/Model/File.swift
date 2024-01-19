//
//  File.swift
//  
//
//  Created by Michael Kushinski on 1/17/24.
//

import Foundation

enum FileState {
    case queued
    case downloaded
    case error
}

class File {
    let name: String
    var state: FileState

    init(name: String, state: FileState = FileState.queued) {
        self.name = name
        self.state = state
    }

    func download() async {
        do {
            try await Task.sleep(for: .seconds(Double.random(in: 0.1...1.8)))
            if Bool.random() {
                state = .error
            } else {
                state = .downloaded
            }
        } catch {
            state = .error
        }
    }
}
