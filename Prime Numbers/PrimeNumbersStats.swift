//
//  PrimeNumbersStats.swift
//  Prime Numbers
//
//  Created by Тарас on 29.05.17.
//  Copyright © 2017 Taras Minin. All rights reserved.
//

import Foundation

class PrimeNumbersStats {
    
    private var summ: Int64
    private var list: String
    
    init() {
        summ = 0
        list = ""
    }
    
    func addNewPrimeNumber(_ number: Int64) {
    
        summ = summ + number
        
        if list == "" {
            list = "\(number)"
        } else {
            list = list + ", \(number)"
        }
    }
    
    func getSumm() -> Int64 {
        return summ
    }
    
    func getList() -> String {
        return list
    }
    
    func clear() {
        summ = 0
        list = ""
    }
}
