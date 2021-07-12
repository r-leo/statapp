//
//  NumbersOnly.swift
//  statapp
//
//  Created by Rodrigo Leo on 04/07/2021.
//

import Foundation

class NumbersOnly: ObservableObject {
    
    var isInteger: Bool
    
    @Published var value = "" {
        didSet {
            var mask: String
            if isInteger {
                mask = "0123456789"
            }
            else {
                mask = ".0123456789"
            }
            let filtered = value.filter { mask.contains($0) }
            
            if value != filtered {
                value = filtered
            }
        }
    }
    
    init(value: String = "", isInteger: Bool = false) {
        self.value = value
        self.isInteger = isInteger
    }
    
    func float() -> Float? {
        if let valueFloat = Float(value) {
            return Float(valueFloat)
        }
        else {
            return nil
        }
    }
    
    func int() -> Int? {
        if let valueInt  = Int(value) {
            return Int(valueInt)
        }
        else {
            return nil
        }
    }
}
