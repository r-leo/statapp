//
//  DistPoisson.swift
//  statapp
//
//  Created by Rodrigo Leo on 11/07/2021.
//

import Foundation

func pdf_poisson(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float(),
       let x = xStr.float() {
        if lambda > 0 && x >= 0 {
            let pdf: Float = exp(x * log(lambda) - lambda - lgamma(x + 1.0).0)
            return String(pdf)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func cdf_poisson(parameters: [Parameter], xStr: NumbersOnly) -> [String : String] {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float(),
       let x = xStr.float() {
        if lambda > 0 && x >= 0 {
            var left: Float = 0.0
            for k in 0...Int(x) {
                left = left + exp(Float(k) * log(lambda) - lambda - lgamma(Float(k) + 1.0).0)
            }
            return ["left": String(left), "right": String(1.0 - left)]
        }
        else {
            return ["left": "", "right": ""]
        }
    }
    else {
        return ["left": "", "right": ""]
    }
}


func ipdf_poisson(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func icdf_poisson(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func mean_poisson(parameters: [Parameter]) -> String {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float() {
        if lambda > 0 {
            return String(lambda)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

    
var poisson = Distribution(
    name: "Poisson",
    direct: true,
    parameters: [
        Parameter(name_short: "lambda", name_long: "Lambda", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: "", isInteger: true),
    p: NumbersOnly(value: ""),
    pdf: pdf_poisson,
    cdf: cdf_poisson,
    ipdf: ipdf_poisson,
    icdf: icdf_poisson,
    mean: mean_poisson,
    variance: mean_poisson
)

