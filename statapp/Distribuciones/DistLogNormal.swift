//
//  DistLogNormal.swift
//  statapp
//
//  Created by Rodrigo Leo on 07/07/2021.
//

import Foundation
import SwiftyStatsMobile

func pdf_lognormal(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let media = parameters.first(where: { $0.name_short == "media_n" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza_n" })!.value.float(),
       let x = xStr.float(),
       let pdf: Float = try? SSProbDist.LogNormal.pdf(x: x, mean: media, variance: varianza) {
        if varianza > 0.0 && x > 0 {
            return String(pdf)
        }
        else if varianza > 0 && x <= 0 {
            return String(0.0)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func cdf_lognormal(parameters: [Parameter], xStr: NumbersOnly) -> [String: String] {
    if let media = parameters.first(where: { $0.name_short == "media_n" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza_n" })!.value.float(),
       let x = xStr.float(),
       let left: Float = try? SSProbDist.LogNormal.cdf(x: x, mean: media, variance: varianza) {
        if varianza > 0 && x > 0 {
            return ["left": String(left),  "right": String(1.0 - left)]
        }
        else  if varianza > 0 && x <= 0 {
            return ["left": String(0.0),  "right": String(1.0)]
        }
        else {
            return ["left": "",  "right": ""]
        }
    }
    else {
        return ["left": "", "right": ""]
    }
}

func ipdf_lognormal(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func icdf_lognormal(parameters: [Parameter], pStr: NumbersOnly) -> String {
    if let media = parameters.first(where: { $0.name_short == "media_n" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza_n" })!.value.float(),
       let p = pStr.float(),
       let icdf = try? SSProbDist.LogNormal.quantile(p: p, mean: media, variance: varianza) {
        if varianza > 0.0 && p < 1.0 && p > 0.0 {
            return String(icdf)
        }
        else if varianza > 0.0 && p == 1.0 {
            return "∞"
        }
        else if  varianza > 0.0 && p == 0.0 {
            return String(0.0)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func mean_lognormal(parameters: [Parameter]) -> String {
    if let media = parameters.first(where: { $0.name_short == "media_n" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza_n" })!.value.float() {
        if varianza > 0.0 {
            return String(exp(media + varianza / 2))
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func variance_lognormal(parameters: [Parameter]) -> String {
    if let media = parameters.first(where: { $0.name_short == "media_n" })!.value.float(),
       let varianza = parameters.first(where: { $0.name_short == "varianza_n" })!.value.float() {
        if varianza > 0.0 {
            return String((exp(varianza) - 1) * exp(2 * media + varianza))
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

var lognormal = Distribution(
    name: "Lognormal",
    direct: true,
    parameters: [
        Parameter(name_short: "media_n", name_long: "Media (normal)", value: NumbersOnly(value: "")),
        Parameter(name_short: "varianza_n", name_long: "Varianza (normal)", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: ""),
    p: NumbersOnly(value: ""),
    pdf: pdf_lognormal,
    cdf: cdf_lognormal,
    ipdf: ipdf_lognormal,
    icdf: icdf_lognormal,
    mean: mean_lognormal,
    variance: variance_lognormal
)

