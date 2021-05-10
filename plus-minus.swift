/*
* 
* Given an array of integers, calculate the ratios of 
* its elements that are positive, negative, and zero. 
* Print the decimal value of each fraction on a new line 
* with 6 places after the decimal.
*
*/

import Foundation

func plus_minus(array: [Int]) -> (Double, Double, Double) {

    let sortedArray = array.sorted()
    let negativeIntegers = array.filter({ $0 < 0 })
    let zeroOnes = array.filter({ $0 == 0 })
    let positiveIntegers = array.filter({ $0 > 0 })

    if sortedArray.count == 0 {
        return (0.0, 0.0, 0.0)
    }
    return (Double(positiveIntegers.count)/Double(sortedArray.count),
            Double(zeroOnes.count)/Double(sortedArray.count),
            Double(negativeIntegers.count)/Double(sortedArray.count))
}


var (p,z,n) = plus_minus(array: [1, 1, 0, -1, -1])
print(String(format: "%6f, %6f, %6f", p,z,n))

(p,z,n) = plus_minus(array: [-4, 3, -9, 0, 4, 1])
print(String(format: "%6f, %6f, %6f", p,z,n))
