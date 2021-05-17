/*
*
* question:
*   This is a staircase of size n = 4
*       #
*      ##
*     ###
*    ####
*   Its base and height are both equal to n. 
*   It is drawn using # symbols and spaces. 
*   The last line is not preceded by any spaces. 
*
*/

import Foundation

func staircase(n: Int) {
    for line in 0..<n {
        var str = ""
        
        for _ in 0..<n-line-1 {
            str.append(" ")
        }
        for _ in 0...line {
            str.append("#")
        }

        print(str)
    }
}


staircase(n: 4)
print("\n")
staircase(n: 6)
