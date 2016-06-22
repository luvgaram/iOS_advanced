import UIKit

func makeAccumulator(defaultValue : Double) -> (Double) -> Double {
    var runningTotal = defaultValue
    func incrementer(amount: Double) -> Double {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let x = makeAccumulator(1)
x(5)
x(2.3)