//
//  DistGeomF.swift
//  statapp
//
//  Created by Rodrigo Leo on 12/07/2021.
//

import Foundation

func pdf_geom_f(parameters: [Parameter], xStr: NumbersOnly) -> String {
    if let p = parameters.first(where: { $0.name_short == "p" })!.value.float(),
       let x = xStr.float() {
        if p > 0 && p <= 1  && x >= 0 {
            let pdf: Float = pow(1.0 - p, x) * p
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

func cdf_geom_f(parameters: [Parameter], xStr: NumbersOnly) -> [String : String] {
    if let p = parameters.first(where: { $0.name_short == "p" })!.value.float(),
       let x = xStr.float() {
        if p > 0 && p <= 1  && x >= 0 {
            let left: Float = 1.0 - pow(1.0 - p, x + 1.0)
            return ["left": String(left), "right": String(1.0 - left)]
        }
        else {
            return ["left": "",  "right": ""]
        }
    }
    else {
        return ["left": "",  "right": ""]
    }
}

func ipdf_geom_f(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func icdf_geom_f(parameters: [Parameter], pStr: NumbersOnly) -> String {
    return ""
}

func mean_geom_f(parameters: [Parameter]) -> String {
    if let p = parameters.first(where: { $0.name_short == "p" })!.value.float() {
        if p > 0 && p <= 1  {
            return String((1.0 - p) / p)
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

func variance_geom_f(parameters: [Parameter]) -> String {
    if let p = parameters.first(where: { $0.name_short == "p" })!.value.float() {
        if p > 0 && p <= 1  {
            return String((1.0 - p) / pow(p, 2))
        }
        else {
            return ""
        }
    }
    else {
        return ""
    }
}

var geom_f = Distribution(
    name: "Geométrica (fracasos antes de un éxito)",
    direct: true,
    parameters: [
        Parameter(name_short: "p", name_long: "Prob. de éxito", value: NumbersOnly(value: ""))
    ],
    x: NumbersOnly(value: "", isInteger: true),
    p: NumbersOnly(value: ""),
    pdf: pdf_geom_f,
    cdf: cdf_geom_f,
    ipdf: ipdf_geom_f,
    icdf: icdf_geom_f,
    mean: mean_geom_f,
    variance: variance_geom_f
)

