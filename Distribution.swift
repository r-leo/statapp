//
//  Distribution.swift
//  statapp
//
//  Created by Rodrigo Leo on 02/07/2021.
//

import Foundation

struct Parameter: Identifiable {
    let id: UUID
    let name_short: String
    let name_long: String
    var value: NumbersOnly
    
    init(id: UUID = UUID(), name_short: String, name_long: String, value: NumbersOnly) {
        self.id = id
        self.name_short = name_short
        self.name_long = name_long
        self.value = value
    }
}

class Distribution: Identifiable, ObservableObject {
    let id: UUID
    let name: String
    let pdf: ([Parameter], NumbersOnly) -> String
    let cdf: ([Parameter], NumbersOnly) -> [String: String]
    let ipdf: ([Parameter], NumbersOnly) -> String
    let icdf: ([Parameter], NumbersOnly) -> String
    let mean: ([Parameter]) -> String
    let variance: ([Parameter]) -> String
    @Published var direct: Bool
    @Published var parameters: [Parameter]
    @Published var x: NumbersOnly
    @Published var p: NumbersOnly
    
    init(
        id: UUID = UUID(),
        name: String,
        direct: Bool,
        parameters: [Parameter],
        x: NumbersOnly,
        p: NumbersOnly,
        pdf: @escaping ([Parameter], NumbersOnly) -> String,
        cdf: @escaping ([Parameter], NumbersOnly) -> [String: String],
        ipdf: @escaping ([Parameter], NumbersOnly) -> String,
        icdf: @escaping ([Parameter], NumbersOnly) -> String,
        mean: @escaping ([Parameter]) -> String,
        variance: @escaping ([Parameter]) -> String
        
    ) {
        self.id = id
        self.name = name
        self.direct = direct
        self.parameters = parameters
        self.pdf = pdf
        self.cdf = cdf
        self.ipdf = ipdf
        self.icdf = icdf
        self.mean = mean
        self.variance = variance
        self.x = x
        self.p = p
    }
    
}


func anon(parameters: [Parameter], xStr: NumbersOnly) -> String {
    return ""
}

func anon_cdf(parameters: [Parameter], xStr: NumbersOnly) -> [String: String] {
    return ["left": "", "right": ""]
}
