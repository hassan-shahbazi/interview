/*
*
* You are in charge of the cake for a child's birthday. You have decided 
* the cake will have one candle for each year of their total age. They will 
* only be able to blow out the tallest of the candles. 
* Count how many candles are tallest. 
*
*/

import Foundation

func birthday_cake_candles(candles: [Int]) -> Int {
    if candles.count < 2 {
        return candles.count
    }

    var result = 0
    var i = candles.count
    let s_candles = candles.sorted()

    repeat {
        result += 1
        i -= 1
    } while(i > 0 && s_candles[i] == s_candles[i-1])

    return result
}

print(birthday_cake_candles(candles: [4, 4, 1, 3]))
print(birthday_cake_candles(candles: [3, 2, 1, 4]))
print(birthday_cake_candles(candles: [4, 4]))
print(birthday_cake_candles(candles: [4]))
