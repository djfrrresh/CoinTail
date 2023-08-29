//
//  Int.swift
//  CoinTail
//
//  Created by Eugene on 19.06.23.
//

import Foundation


extension Int {
    
    static func norm(hi: Int, lo: Int, base: Int) -> (nhi: Int, nlo: Int) {
        var hi = hi
        var lo = lo
        if lo < 0 {
            let n = (-lo - 1) / base + 1
            hi -= n
            lo += n * base
        }
        if lo >= base {
            let n = lo / base
            hi += n
            lo -= n * base
        }
        
        return (hi, lo)
    }
    
}
