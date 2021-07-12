//
//  MainView.swift
//  statapp
//
//  Created by Rodrigo Leo on 02/07/2021.
//

import SwiftUI

struct MainView: View {
    
    var distribuciones_continuas: [Distribution]
    var distribuciones_discretas: [Distribution]
    @State private var about: Bool = false
    
    var body: some View {
        
        List {
            
            Section(header: Text("Continuas")) {
                ForEach (distribuciones_continuas) { dist in
                    NavigationLink(destination: DistributionView(dist: dist, isDiscrete: false)) {
                        Text(dist.name)
                    }
                }
            }
            
            Section(header: Text("Discretas")) {
                ForEach (distribuciones_discretas) { dist in
                    NavigationLink(destination: DistributionView(dist: dist, isDiscrete: true)) {
                        Text(dist.name)
                    }
                }
            }
            
                
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Distribuciones")
        .navigationBarItems(trailing: Button(action: { about.toggle() }) { Label("Acerca de", systemImage: "info.circle").font(.body) }.sheet(isPresented: $about) { AboutView() })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView(
                distribuciones_continuas: [exponencial, normal],
                distribuciones_discretas: [binomial]
            )
        }
    }
}

