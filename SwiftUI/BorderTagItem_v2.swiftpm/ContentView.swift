import SwiftUI

struct ContentView: View {
    @State var selected = false

    var body: some View {
        HStack {
            Button {
                selected.toggle()
            } label: {
                VStack(spacing: 10) {
                    Text("Annual Subscription")
                        .foregroundStyle(.primary)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Try the first two weeks free,\nthen $116 billed yearly.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()
                VStack {
                    Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .overlay {
            RoundedRectangle(
                cornerRadius: 10,
                style: .circular
            )
            .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
            .fill(.clear)
        }
        .overlay(alignment: .topTrailing) {
            Text("Intro Offer")
                .font(.caption).bold()
                .foregroundStyle(.blue)
                .textCase(.uppercase)
                .padding(5)
                .background {
                    RoundedRectangle(
                        cornerRadius: 4,
                        style: .circular
                    )
                    .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                    .fill(.white)
                }
                .frame(width: 100, height: 20)
                .alignmentGuide(.top) {
                    $0[.top] + 10
                }
                .alignmentGuide(.trailing) {
                    $0[.trailing] + 20
                }
        }
        .padding()
        .contentShape(Rectangle())
        .tint(.primary)
    }
}
