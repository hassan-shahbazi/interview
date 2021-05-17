/*
*
* Given five positive integers, find the minimum and maximum values 
* that can be calculated by summing exactly four of the five integers. 
* Then print the respective minimum and maximum values as a single line 
* of two space-separated long integers. 
*
*/

import Foundation

func mini_max_sum(array: [Int]) {
    let mini = array.sorted()[..<4].reduce(0, +)
    let max = array.sorted()[1..<array.count].reduce(0, +)
    print("\(mini) \(max)")
}

mini_max_sum(array: [1, 2, 3, 4, 5])
mini_max_sum(array: [1, 3, 5, 7, 9])
