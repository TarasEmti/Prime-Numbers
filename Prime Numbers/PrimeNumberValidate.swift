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
}
