//
//  DistChiSquare.swift
//  statapp
//
//  Created by Rodrigo Leo on 06/07/2021.
//

import Foundation
import SwiftyStatsMobile

func pdf_chi(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       let x = xStr.float(),
       let pdf = try? SSProbDist.ChiSquare.pdf(chi: x, degreesOfFreedom: gl) {
        switch pdf {
        case Float.infinity:
            return "∞"
        case -Float.infinity:
            return "-∞"
        default:
            return String(pdf)
        }
    }
    else {
        return ""
    }
}

func cdf_chi(parameters: [Parameter], xStr: NumbersOnly) -> [String: String] {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       let x = xStr.float(),
       let left = try? SSProbDist.ChiSquare.cdf(chi: x, degreesOfFreedom: gl) {
        return ["left": String(left), "right": String(1.0 - left)]
    }
    else {
        return ["left": "", "right": ""]
    }
}

func ipdf_chi(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func icdf_chi(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       let p = pStr.float(),
       let icdf = try? SSProbDist.ChiSquare.quantile(p: p, degreesOfFreedom: gl) {
        switch icdf {
        case Float.infinity:
            return "∞"
        case -Float.infinity:
            return "-∞"
        default:
            return String("cc")
        }
    }
    else {
        return ""
    }
}

func icdf_chi2(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       let p = pStr.float() {
        switch p {
        case 0.0:
            return String(0.0)
        case 1.0:
            return "∞"
        default:
            let z: Float = Float(icdf_normal_estandar(parameters: [], pStr: pStr))!
            let chi: Float = 0.5 * pow(z + sqrt(2.0 * gl - 1.0), 2)
            return String(chi)
        }
    }
    else {
        return ""
    }
}

func mean_chi(parameters: [Parameter]) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       gl > 0 {
        return String(gl)
    }
    else {
        return ""
    }
}

func variance_chi(parameters: [Parameter]) -> String {
    if let gl = parameters.first(where: { $0.name_short == "gl" })!.value.float(),
       gl > 0 {
        return String(2.0 * gl)
    }
    else {
        return ""
    }
}

var chi_cuadrada = Distribution(
    name: "Chi cuadrada (𝜒²)",
    direct: true,
    parameters: [
        Parameter(name_short: "gl", name_long: "Grados de libertad", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: ""),
    p: NumbersOnly(value: ""),
    pdf: pdf_chi,
    cdf: cdf_chi,
    ipdf: ipdf_chi,
    icdf: icdf_chi,
    mean: mean_chi,
    variance: variance_chi
)

