import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello World")
        }
        .onAppear {
            print("Array Addition: \(arrayAddition([0,2,3], [0,2,3]))")
            print("Multiple Array Addition: \(multipleArrayAddition([[0,2,3], [0,2,3], [0,2,3], [1,1,0]]))")
        }
    }
}


extension ContentView {
    private func arrayAddition(_ array1: [Int], _ array2: [Int]) -> [Int] {
        var results: [Int] = []

        var x = array1.count - 1
        var y = array2.count - 1
        var carryOver = 0

        while x >= 0 || y >= 0 || carryOver > 0 {
            let first = x >= 0 ? array1[x] : 0
            let second = y >= 0 ? array2[y] : 0

            let sum = first + second + carryOver

            carryOver = sum / 10
            results.insert(sum % 10, at: 0)

            x -= 1
            y -= 1
        }

        return results
    }

    private func multipleArrayAddition(_ arrays: [[Int]]) -> [Int] {
        var results: [Int] = []

        for array in arrays {
            var x = array.count - 1
            var y = results.count - 1
            var carryOver = 0

            while x >= 0 || y >= 0 || carryOver > 0 {
                let first = x >= 0 ? array[x] : 0
                let second = y >= 0 ? results[y] : 0

                let sum = first + second + carryOver

                carryOver = sum / 10
                if y >= 0 {
                    results[y] = sum % 10
                } else {
                    results.insert(sum % 10, at: 0)
                }

                x -= 1
                y -= 1
            }
        }

        return results
    }
}
