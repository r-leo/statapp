//
//  DistBinomial.swift
//  statapp
//
//  Created by Rodrigo Leo on 11/07/2021.
//

import Foundation

func pdf_binomial(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let n = parameters.first(where: { $0.name_short == "n" })!.value.float(),
       let p = parameters.first(where: { $0.name_short == "p" })!.value.float(),
       let x = xStr.float() {
        if n >= x && n >= 0 && x >= 0 && p >= 0 && p <= 1 {
            let pdf: Float = comb(n: n, k: x) * pow(p, x) * pow(1.0 - p, n - x)
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

func cdf_binomial(parameters: [Parameter], xStr: NumbersOnly) -> [String : String] {
    if let n = parameters.first(where: { $0.name_short == "n" })!.value.float(),
       let p = parameters.first(where: { $0.name_short == "p" })!.value.float(),
       let x = xStr.float() {
        if n >= x && n >= 0 && x >= 0 && p >= 0 && p <= 1 {
            var left: Float = 0.0
            let lim = Int(x)
            for i in 0...lim {
                left = left + comb(n: n, k: Float(i)) * pow(p, Float(i)) * pow(1.0 - p, n - Float(i))
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

func ipdf_binomial(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func icdf_binomial(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func mean_binomial(parameters: [Parameter]) -> String {
    if let n = parameters.first(where: { $0.name_short == "n" })!.value.float(),
       let p = parameters.first(where: { $0.name_short == "p" })!.value.float() {
        if n >= 0 && p >= 0 && p <= 1 {
            return String(n * p)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func variance_binomial(parameters: [Parameter]) -> String {
    if let n = parameters.first(where: { $0.name_short == "n" })!.value.float(),
       let p = parameters.first(where: { $0.name_short == "p" })!.value.float() {
        if n >= 0 && p >= 0 && p <= 1 {
            return String(n * p * (1.0 - p))
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

var binomial = Distribution(
    name: "Binomial",
    direct: true,
    parameters: [
        Parameter(name_short: "n", name_long: "No. de ensayos", value: NumbersOnly(value: "", isInteger: true)),
        Parameter(name_short: "p", name_long: "Prob. de éxito", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: "", isInteger: true),
    p: NumbersOnly(value: ""),
    pdf: pdf_binomial,
    cdf: cdf_binomial,
    ipdf: ipdf_binomial,
    icdf: icdf_binomial,
    mean: mean_binomial,
    variance: variance_binomial
)

