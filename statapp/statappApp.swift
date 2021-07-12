//
//  statappApp.swift
//  statapp
//
//  Created by Rodrigo Leo on 02/07/2021.
//

import SwiftUI

@main
struct statappApp: App {
    
    @State var distribuciones_continuas = [
        exponencial,
        //chi_cuadrada,
        lognormal,
        normal,
        normal_estandar,
        t,
        triangular,
        uniforme,
    ]
    
    @State var distribuciones_discretas = [
        binomial,
        geom_e,
        geom_f,
        poisson,
    ]
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(distribuciones_continuas: distribuciones_continuas, distribuciones_discretas: distribuciones_discretas)
            }
        }
    }
}
