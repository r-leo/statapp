//
//  DistTriangular.swift
//  statapp
//
//  Created by Rodrigo Leo on 06/07/2021.
//

import Foundation

func pdf_triangular(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float(),
       let c = parameters.first(where: { $0.name_short == "c" })!.value.float(),
       let x = xStr.float() {
        var pdf: Float = 0.0
        
        // Forma más general
        if a < b && a < c && c < b {
            switch (a, b, c, x) {
            case let (a, _, _, x) where x < a:
                pdf = 0.0
            case let (a, b, c, x) where a <= x && x < c:
                pdf = (2.0 * (x - a))  / ((b - a) * (c - a))
            case let (a, b, c, x) where x == c:
                pdf = 2.0 / (b - a)
            case let (a, b, c, x) where c < x && x <= b:
                pdf = (2.0 * (b - x)) / ((b - a) * (b - c))
            case let (_, b, _, x) where b < x:
                pdf = 0.0
            default:
                pdf = 0.0
            }
        }
        
        // Forma con a=c
        else if a < b && a == c {
            switch (a, b, c, x) {
            case let (a, _, _, x) where x < a:
                pdf = 0.0
            case let (a, b, c, x) where x == c:
                pdf = 2.0 / (b - a)
            case let (a, b, c, x) where c < x && x <= b:
                pdf = (2.0 * (b - x)) / ((b - a) * (b - c))
            case let (_, b, _, x) where b < x:
                pdf = 0.0
            default:
                pdf = 0.0
            }
        }
        
        // Forma con b=c
        else if a < b && b == c {
            switch (a, b, c, x) {
            case let (a, _, _, x) where x < a:
                pdf = 0.0
            case let (a, b, c, x) where a <= x && x < c:
                pdf = (2.0 * (x - a))  / ((b - a) * (c - a))
            case let (a, b, c, x) where x == c:
                pdf = 2.0 / (b - a)
            case let (_, b, _, x) where b < x:
                pdf = 0.0
            default:
                pdf = 0.0
            }
        }
        
        // Forma degenerada
        else {
            return ""
        }
        return String(pdf)
    }
    else {
        return ""
    }
}

func cdf_triangular(parameters: [Parameter], xStr: NumbersOnly) -> [String : String] {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float(),
       let c = parameters.first(where: { $0.name_short == "c" })!.value.float(),
       let x = xStr.float() {
        var left: Float = 0.0
        
        // Forma más general
        if a < b && a < c && c < b {
            switch (a, b, c, x) {
            case let (a, _, _, x) where x <= a:
                left = 0.0
            case let (a, b, c, x) where a < x && x <= c:
                left = pow(x - a, 2) / ((b - a) * (c - a))
            case let (a, b, c, x) where c < x && x < b:
                left = 1 - pow(b - x, 2) / ((b - a) * (b - c))
            case let (_, b, _, x) where b <= x:
                left = 1.0
            default:
                left = 0.0
            }
        }
        
        // Forma con a=c
        else if a < b && a == c {
            switch (a, b, c, x) {
            case let (a, _, _, x) where x <= a:
                left = 0.0
            case let (a, b, c, x) where c < x && x < b:
                left = 1 - pow(b - x, 2) / ((b - a) * (b - c))
            case let (_, b, _, x) where b <= x:
                left = 1.0
            default:
                left = 0.0
            }
        }
        
        // Forma con b=c
        else if a < b && b == c {
            switch (a, b, c, x) {
            case let (a, _, _, x) where x <= a:
                left = 0.0
            case let (a, b, c, x) where a < x && x <= c:
                left = pow(x - a, 2) / ((b - a) * (c - a))
            case let (_, b, _, x) where b <= x:
                left = 1.0
            default:
                left = 0.0
            }
        }
        
        // Forma degenerada
        else {
            return ["left": "", "right": ""]
        }
        return ["left": String(left), "right": String(1.0 - left)]
    }
    else {
        return ["left": "", "right": ""]
    }
}

func ipdf_triangular(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func icdf_triangular(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float(),
       let c = parameters.first(where: { $0.name_short == "c" })!.value.float(),
       let p = pStr.float() {
        var icdf: Float = 0.0
        if a < b && a <= c && c <= b {
            switch (a, b, c, p) {
            case let (_, _, _, p) where p <= 0:
                return ""
            case let (a, b, c, p) where p > 0 && p < (c-a)/(b-a):
                icdf = a + sqrt(p * (b - a) * (c - a))
            case let (a, b, c, p) where p > 0 && p >= (c-a)/(b-a) && p < 1:
                icdf = b - sqrt((1 - p) * (b - a) * (b - c))
            case let (_, _, _, p) where p >= 1:
                return ""
            default:
                return ""
            }
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

func mean_triangular(parameters: [Parameter]) -> String {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float(),
       let c = parameters.first(where: { $0.name_short == "c" })!.value.float() {
        if a < b && a <= c && c <= b {
            let mean = (a + b + c) / 3
            return String(mean)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func variance_triangular(parameters: [Parameter]) -> String {
    if let a = parameters.first(where: { $0.name_short == "a" })!.value.float(),
       let b = parameters.first(where: { $0.name_short == "b" })!.value.float(),
       let c = parameters.first(where: { $0.name_short == "c" })!.value.float() {
        if a < b && a <= c && c <= b {
            let variance = (pow(a, 2) + pow(b, 2) + pow(c, 2) - a*b - a*c - b*c) / 18
            return String(variance)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

var triangular = Distribution(
    name: "Triangular",
    direct: true,
    parameters: [
        Parameter(name_short: "a", name_long: "Límite inferior (a)", value: NumbersOnly(value: "")),
        Parameter(name_short: "b", name_long: "Límite superior (b)", value: NumbersOnly(value: "")),
        Parameter(name_short: "c", name_long: "Moda (c)", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: ""),
    p: NumbersOnly(value: ""),
    pdf: pdf_triangular,
    cdf: cdf_triangular,
    ipdf: ipdf_triangular,
    icdf: icdf_triangular,
    mean: mean_triangular,
    variance: variance_triangular
)
