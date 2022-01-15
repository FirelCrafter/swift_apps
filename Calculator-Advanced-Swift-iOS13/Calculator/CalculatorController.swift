//
//  CalculatorController.swift
//  Calculator
//
//  Created by Михаил Щербаков on 09.01.2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import UIKit


struct CalculatorController {
    
    private var number: Double?
    
    private var intemediateCalculator: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let n = number {
            
            switch symbol {
            case "+/-":
                return n * -1
            case "AC":
                return 0
            case "%":
                return n * 0.01
            case "=":
                return performTwoNumCalculation(n2: n)
            default:
                intemediateCalculator = (n1: n, calcMethod: symbol)
            }
            
        }
        
        return nil
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intemediateCalculator?.n1, let operation = intemediateCalculator?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("Bad operation!")
            }
            
        }
        return nil
        
    }
    
}
