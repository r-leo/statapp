//
//  MainView.swift
//  statapp
//
//  Created by Rodrigo Leo on 02/07/2021.
//

import SwiftUI

struct MainView: View {
    
    var distribuciones: [Distribution]
    @State private var about: Bool = false
    
    var body: some View {
        
        List {
            ForEach (distribuciones) { dist in
                NavigationLink(destination: DistributionView(dist: dist)) {
                    Text(dist.name)
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
            MainView(distribuciones: [exponencial, normal])
        }
    }
}

