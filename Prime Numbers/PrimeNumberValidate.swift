//
//  CalculatePrimeNumbers.swift
//  Prime Numbers
//
//  Created by Тарас on 29.05.17.
//  Copyright © 2017 Taras Minin. All rights reserved.
//

import Foundation

class PrimeNumberValidate {
    
    class func isPrimeNumber(_ number: Int64) -> Bool {
        
        //Отсеиваем минимальные простые числа, не подходящие для расчетов
        if number == 2 || number == 3 {
            return true
        }
        
        //Отсеиваем четные, отрицательные и n=0, n=1
        if number < 2 || number % 2 == 0 {
            return false
        }
        
        //Достаточно проверить остаток от деления на числа в промежутке от 2 до sqrt(n)
        let highestNumber = sqrt(Double(number)) + 1
        
        for i in 2...Int64(highestNumber) {
            
            if (number % i) == 0 {
                return false
            }
        }
        return true
    }
    
    class func searchForPrimeNumbers(inRangeTo limit: Int, forStats stats: PrimeNumbersStats) {
        
        if limit < 1 {
            return
        }
        
        var isPrime = Array.init(repeating: false, count: limit + 1)
        
        let sqr = Int(sqrt(Double(limit)))
        
        if limit >= 2 {
            isPrime[2] = true
        }
        
        if limit >= 3 {
            isPrime[3] = true
        }
        
        var n = 0
        var x2 = 0
        
        for i in 1...sqr {
            
            x2 = x2 + 2*i - 1
            var y2 = 0
            
            for j in 1...sqr {
                
                y2 = y2 + 2*j - 1
                n = 4 * x2 + y2
                
                if n <= limit && (n % 12 == 1 || n % 12 == 5) {
                    isPrime[n] = !isPrime[n]
                }
                
                n = n - x2
                if n <= limit && n % 12 == 7 {
                    isPrime[n] = !isPrime[n]
                }
                
                n = n - 2*y2
                if i > j && n <= limit && n % 12 == 11 {
                    isPrime[n] = !isPrime[n]
                }
            }
        }
        
        if sqr >= 5 {
            for i in 5...sqr {
                if isPrime[i] {
                    n = i * i
                    
                    for j in stride(from: n, to: limit, by: n) {
                        
                        isPrime[j] = false
                    }
                }
            }
        }
        
        for i in 0...limit {
            
            if isPrime[i] {
                stats.addNewPrimeNumber(i)
            }
        }
    }
}
