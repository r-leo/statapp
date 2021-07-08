//
//  DistNormal.swift
//  statapp
//
//  Created by Rodrigo Leo on 05/07/2021.
//

import Foundation

func pdf_normal(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let media = parameters.first(where: { $0.name_short == "media" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza" })!.value.float(),
       let x = xStr.float() {
        var pdf: Float = 0.0
        if varianza > 0.0 {
            pdf = (1.0 / sqrt(2.0 * varianza * Float.pi)) * exp(-0.5 * pow(x - media, 2) / varianza)
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

func cdf_normal(parameters: [Parameter], xStr: NumbersOnly) -> [String: String] {
    if let media = parameters.first(where: { $0.name_short == "media" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza" })!.value.float(),
       let x = xStr.float() {
        var left: Float = 0.0
        if varianza > 0.0 {
            left = 0.5 * (1.0 + erf((x - media) / sqrt(2.0 * varianza)))
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

func ipdf_normal(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let media = parameters.first(where: { $0.name_short == "media" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza" })!.value.float(),
       let p = pStr.float() {
        var ipdf: Float = 0.0
        if p > 0.0 && varianza > 0.0 && p < (1.0 / sqrt(2.0 * Float.pi * varianza)) {
            ipdf = sqrt(-2.0 * varianza * log(p * sqrt(2.0 * Float.pi * varianza)))
            return String(media) + "±" + String(ipdf)
        }
        else if p == 0.0 && varianza > 0.0 {
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

func icdf_normal(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let media = parameters.first(where: { $0.name_short == "media" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza" })!.value.float(),
       let p = pStr.float() {
        var icdf: Float = 0.0
        if p > 0.0 && p < 1.0 && varianza > 0.0 {
            icdf = media + sqrt(2.0 * varianza) * Float(erfinv(y: 2.0 * Double(p) - 1))
        }
        else if p == 0.0 && varianza > 0.0 {
            return "-∞"
        }
        else if p == 1.0 && varianza > 0.0 {
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

func mean_normal(parameters: [Parameter]) -> String {
    if let media = parameters.first(where: { $0.name_short == "media" })!.value.float() {
        return String(media)
    }
    else {
        return ""
    }
}

func variance_normal(parameters: [Parameter]) -> String {
    if let varianza = parameters.first(where: { $0.name_short == "varianza" })!.value.float() {
        if varianza > 0 {
            return String(varianza)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

var normal = Distribution(
    name: "Normal",
    direct: true,
    parameters: [
        Parameter(name_short: "media", name_long: "Media", value: NumbersOnly(value: "")),
        Parameter(name_short: "varianza", name_long: "Varianza", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: ""),
    p: NumbersOnly(value: ""),
    pdf: pdf_normal,
    cdf: cdf_normal,
    ipdf: ipdf_normal,
    icdf: icdf_normal,
    mean: mean_normal,
    variance: variance_normal
)

