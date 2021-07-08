//
//  DistExponencial.swift
//  statapp
//
//  Created by Rodrigo Leo on 03/07/2021.
//

import Foundation

func pdf_exponencial(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float(),
       let x = xStr.float() {
        var pdf: Float = 0.0
        if x >= 0.0 && lambda > 0 {
            pdf = lambda * exp(-1.0 * lambda * x)
        }
        else if x < 0 && lambda > 0 {
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

func cdf_exponencial(parameters: [Parameter], xStr: NumbersOnly) -> [String: String] {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float(),
       let x = xStr.float() {
        var left: Float = 0.0
        if x >= 0 && lambda > 0 {
            left = 1.0 - exp(-1.0 * lambda * x)
        }
        else if x < 0 && lambda > 0 {
            left = 0.0
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

func ipdf_exponencial(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float(),
       let p = pStr.float() {
        var ipdf: Float = 0.0
        if p > 0.0 && lambda > 0 {
            ipdf = -1.0 * log(p / lambda) / lambda
            return String(ipdf)
        }
        else if p == 0 && lambda > 0 {
            return "∞"
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func icdf_exponencial(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float(),
       let p = pStr.float() {
        var icdf: Float = 0.0
        if p >= 0 && p < 1 && lambda > 0 {
            icdf = -1.0 * log(1 - p) / lambda
        }
        else if p == 1 && lambda > 0 {
            return "∞"
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

func mean_exponencial(parameters: [Parameter]) -> String {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float() {
        if lambda > 0 {
            return String(1.0 / lambda)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func variance_exponencial(parameters: [Parameter]) -> String {
    if let lambda = parameters.first(where: { $0.name_short == "lambda" })!.value.float() {
        if lambda > 0 {
            return String(1.0 / pow(lambda, 2.0))
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

var exponencial = Distribution(
    name: "Exponencial",
    direct: true,
    parameters: [
        Parameter(name_short: "lambda", name_long: "Lambda", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: ""),
    p: NumbersOnly(value: ""),
    pdf: pdf_exponencial,
    cdf: cdf_exponencial,
    ipdf: ipdf_exponencial,
    icdf: icdf_exponencial,
    mean: mean_exponencial,
    variance: variance_exponencial
)
