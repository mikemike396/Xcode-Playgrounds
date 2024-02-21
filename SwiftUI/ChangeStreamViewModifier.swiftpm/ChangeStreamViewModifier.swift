//
//  ChangeStreamViewModifier.swift
//  ChangeStreamViewModifier
//
//  Created by Michael Kushinski on 2/20/24.
//

import SwiftUI
import AsyncAlgorithms

struct ChangeStream<Value: Equatable & Sendable>: ViewModifier {
    @State private var continuation: AsyncStream<Value>.Continuation?

    var value: Value
    var provideStream: @Sendable (AsyncStream<Value>) async -> Void

    func body(content: Content) -> some View {
        content
            .task {
                let (stream, continuation) = AsyncStream<Value>.makeStream()
                self.continuation = continuation
                await provideStream(stream)
            }
            .onChange(of: value) { _, newValue in
                continuation?.yield(newValue)
            }
    }
}

extension View {
    func streamChanges<Value: Equatable & Sendable>(
        of value: Value,
        provideStream: @escaping @Sendable (AsyncStream<Value>) async -> Void
    ) -> some View {
        modifier(ChangeStream(value: value, provideStream: provideStream))
    }
}
