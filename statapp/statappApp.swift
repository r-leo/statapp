//
//  statappApp.swift
//  statapp
//
//  Created by Rodrigo Leo on 02/07/2021.
//

import SwiftUI

@main
struct statappApp: App {
    
    @State var distribuciones = [
        exponencial,
        //chi_cuadrada,
        lognormal,
        normal,
        normal_estandar,
        t,
        triangular,
        uniforme,
    ]
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView(distribuciones: distribuciones)
            }
        }
    }
}
