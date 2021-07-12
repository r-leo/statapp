//
//  erfinv.swift
//  statapp
//
//  Created by Rodrigo Leo on 05/07/2021.
//

import Foundation
import SwiftUI

func erfinv(y: Double) -> Double {
     let center = 0.7
     let a = [ 0.886226899, -1.645349621,  0.914624893, -0.140543331]
         let b = [-2.118377725,  1.442710462, -0.329097515,  0.012229801]
     let c = [-1.970840454, -1.624906493,  3.429567803,  1.641345311]
     let d = [ 3.543889200,  1.637067800]
     if abs(y) <= center {
         let z = pow(y,2)
         let num = (((a[3]*z + a[2])*z + a[1])*z) + a[0]
         let den = ((((b[3]*z + b[2])*z + b[1])*z + b[0])*z + 1.0)
         var x = y*num/den
        x = x - (erf(x) - y)/(2.0/sqrt(.pi)*exp(-x*x))
        x = x - (erf(x) - y)/(2.0/sqrt(.pi)*exp(-x*x))
         return x
     }
     else if abs(y) > center && abs(y) < 1.0 {
         let z = pow(-log((1.0-abs(y))/2),0.5)
         let num = ((c[3]*z + c[2])*z + c[1])*z + c[0]
         let den = (d[1]*z + d[0])*z + 1
         // should use the sign function instead of pow(pow(y,2),0.5)
             var x = y/pow(pow(y,2),0.5)*num/den
        x = x - (erf(x) - y)/(2.0/sqrt(.pi)*exp(-x*x))
        x = x - (erf(x) - y)/(2.0/sqrt(.pi)*exp(-x*x))
         return x
     }
     else {
         // this should throw an error instead
         return Double(-Int.max)
     }
 }

func comb(n: Float, k: Float) -> Float {
    if k == 0.0 {
        return 1.0
    }
    else if n == 0 {
        return 0.0
    }
    else {
        return comb(n: n - 1.0, k: k - 1.0) * n / k
    }
}

var FontMath = Font.custom("Times New Roman Italic", size: 20, relativeTo: .body)
