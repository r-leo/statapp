//
//  DistNormalEstandar.swift
//  statapp
//
//  Created by Rodrigo Leo on 05/07/2021.
//

import Foundation

var media: Float = 0.0
var varianza: Float = 1.0

func pdf_normal_estandar(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let x = xStr.float() {
        let pdf: Float = (1.0 / sqrt(2.0 * varianza * Float.pi)) * exp(-0.5 * pow(x - media, 2) / varianza)
        return String(pdf)
    }
    else {
        return ""
    }
}

func cdf_normal_estandar(parameters: [Parameter], xStr: NumbersOnly) -> [String: String] {
    if let x = xStr.float() {
        let left: Float = 0.5 * (1.0 + erf((x - media) / sqrt(2.0 * varianza)))
        return ["left": String(left), "right": String(1.0 - left)]
    }
    else {
        return ["left": "", "right": ""]
    }
}

func ipdf_normal_estandar(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let p = pStr.float() {
        var ipdf: Float = 0.0
        if p > 0.0 && p < (1.0 / sqrt(2.0 * Float.pi * varianza)) {
            ipdf = sqrt(-2.0 * varianza * log(p * sqrt(2.0 * Float.pi * varianza)))
            return String(media) + "±" + String(ipdf)
        }
        else if p == 0.0 {
            return "±∞"
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func icdf_normal_estandar(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let p = pStr.float() {
        var icdf: Float = 0.0
        if p > 0.0 && p < 1.0 {
            icdf = media + sqrt(2.0 * varianza) * Float(erfinv(y: 2.0 * Double(p) - 1))
        }
        else if p == 0.0 {
            return "-∞"
        }
        else if p == 1.0 {
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

func mean_normal_estandar(parameters: [Parameter]) -> String {
    return String(media)
}

func variance_normal_estandar(parameters: [Parameter]) -> String {
    return String(varianza)
}

var normal_estandar = Distribution(
    name: "Normal estándar",
    direct: true,
    parameters: [],
    x: NumbersOnly(value: ""),
    p: NumbersOnly(value: ""),
    pdf: pdf_normal_estandar,
    cdf: cdf_normal_estandar,
    ipdf: ipdf_normal_estandar,
    icdf: icdf_normal_estandar,
    mean: mean_normal_estandar,
    variance: variance_normal_estandar
)

