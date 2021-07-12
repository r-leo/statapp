//
//  DistUnforme.swift
//  statapp
//
//  Created by Rodrigo Leo on 06/07/2021.
//

import Foundation

func pdf_uniforme(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float(),
       let x = xStr.float() {
        var pdf: Float = 0.0
        if a < b && a <= x && x <= b {
            pdf = 1.0 / (b - a)
        }
        else if a < b && (x < a || b < x) {
            pdf = 0.0
        }
        else {
            return ""
        }
        return String(pdf)
    }
    else {
        return ""
    }
}

func cdf_uniforme(parameters: [Parameter], xStr: NumbersOnly) -> [String: String] {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float(),
       let x = xStr.float() {
        var left: Float = 0.0
        if a < b && x < a {
            left = 0.0
        }
        else if a < b && a <= x && x <= b {
            left = (x - a) / (b - a)
        }
        else if a < b && x > b {
            left = 1.0
        }
        else {
            return ["left": "", "right": ""]
        }
        return ["left": String(left), "right": String(1.0 - left)]
    }
    else {
        return ["left": "", "right": ""]
    }
}

func ipdf_uniforme(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return "-"
}

func icdf_uniforme(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float(),
       let p = pStr.float() {
        var icdf: Float = 0.0
        if a < b && p > 0 && p < 1 {
            icdf = a + p * (b - a)
        }
        else {
            return ""
        }
        return String(icdf)
    }
    else {
        return ""
    }
}

func mean_uniforme(parameters: [Parameter]) -> String {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float() {
        if a < b {
            return String(0.5 * (a + b))
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func variance_uniforme(parameters: [Parameter]) -> String {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float() {
        if a < b {
            return String(pow(b - a, 2) / 12)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

var uniforme = Distribution(
    name: "Uniforme",
    direct: true,
    parameters: [
        Parameter(name_short: "a", name_long: "Límite inferior (a)", value: NumbersOnly(value: "")),
        Parameter(name_short: "b", name_long: "Límite superior (b)", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: ""),
    p: NumbersOnly(value: ""),
    pdf: pdf_uniforme,
    cdf: cdf_uniforme,
    ipdf: ipdf_uniforme,
    icdf: icdf_uniforme,
    mean: mean_uniforme,
    variance: variance_uniforme
)
