//
//  NumbersOnly.swift
//  statapp
//
//  Created by Rodrigo Leo on 04/07/2021.
//

import Foundation

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { ".0123456789".contains($0) }
            
            if value != filtered {
                value = filtered
            }
        }
    }
    
    init(value: String = "") {
        self.value = value
    }
    
    func float() -> Float? {
        if let valueFloat = Float(value) {
            return Float(valueFloat)
        }
        else {
            return nil
        }
    }
}
