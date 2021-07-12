//
//  DistT.swift
//  statapp
//
//  Created by Rodrigo Leo on 06/07/2021.
//

import Foundation
import SwiftyStatsMobile

func pdf_t(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       let x = xStr.float() {
        var pdf: Float = 0.0
        if gl > 0.0 {
            pdf = pow(1 + pow(x, 2) / gl, -1.0 * (gl + 1) / 2) * tgamma((gl + 1) / 2) / (sqrt(gl * .pi) * tgamma(gl / 2))
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

func cdf_t(parameters: [Parameter], xStr: NumbersOnly) -> [String: String] {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       let x = xStr.float() {
        if let left = try? SSProbDist.StudentT.cdf(t: x, degreesOfFreedom: gl) {
            return ["left" : String(left), "right": String(1.0 - left)]
        }
        else {
            return ["left": "", "right": ""]
        }
    }
    else {
        return ["left": "", "right": ""]
    }
}

func ipdf_t(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func icdf_t(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       let p = pStr.float() {
        if let icdf = try? SSProbDist.StudentT.quantile(p: p, degreesOfFreedom: gl) {
            switch icdf {
            case Float.infinity:
                return "∞"
            case -Float.infinity:
                return "-∞"
            default:
                return String(icdf)
            }
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func mean_t(parameters: [Parameter]) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float() {
        if gl > 0 {
            return String(0.0)
        }
        else {
            return "indefinido"
        }
    }
    else {
        return ""
    }
}

func variance_t(parameters: [Parameter]) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float() {
        if gl > 2 {
            return String(gl / (gl - 2))
        }
        else if gl > 1 {
            return "∞"
        }
        else {
            return "indefinido"
        }
    }
    else {
        return ""
    }
}

var t = Distribution(
    name: "t de Student",
    direct: true,
    parameters: [
        Parameter(name_short: "gl", name_long: "Grados de libertad", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: ""),
    p: NumbersOnly(value: ""),
    pdf: pdf_t,
    cdf: cdf_t,
    ipdf: ipdf_t,
    icdf: icdf_t,
    mean: mean_t,
    variance: variance_t
)

