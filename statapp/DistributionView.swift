//
//  ContentView.swift
//  statapp
//
//  Created by Rodrigo Leo on 02/07/2021.
//

import SwiftUI
import Combine

struct DistributionView: View {
    
    @StateObject var dist: Distribution
    var isDiscrete: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            
            // Imagen de la distribución
            // ?
            
            
            // Forma principal
            Form {
                // Entrada de parámetros
                if dist.parameters.count > 0 {
                    Section(header: Text("Parámetros de la distribución")) {
                        ForEach(dist.parameters.indices) { ind in
                            HStack {
                                Text(dist.parameters[ind].name_long)
                                TextField(dist.parameters[ind].name_long, text: $dist.parameters[ind].value.value)
                                    //.keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                if !dist.parameters[ind].value.value.isEmpty {
                                    Button(action: {
                                        self.dist.objectWillChange.send()
                                        dist.parameters[ind].value.value = ""
                                        
                                    })
                                    {
                                        Image(systemName: "delete.left")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Entrada de cálculo
                Section(header: Text("Cálculo a realizar")) {
                    
                    if !isDiscrete {
                        Picker(selection: $dist.direct, label: Text("Tipo de cálculo")) {
                            Text("PDF / CDF").tag(true)
                            Text("CDF inversa").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    if dist.direct {
                        HStack {
                            Label {
                                Text("Valor de ") + Text("x").font(FontMath)
                            } icon: { Image(systemName: "x.square").foregroundColor(.green) }
                            TextField("Valor de x", text: $dist.x.value)
                                //.keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                            if !dist.x.value.isEmpty {
                                Button(action: {
                                    self.dist.objectWillChange.send()
                                    dist.x.value = ""
                                    
                                })
                                {
                                    Image(systemName: "delete.left")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    else {
                        HStack {
                            Label { Text("Probabilidad") } icon: { Image(systemName: "p.square").foregroundColor(.green) }
                            TextField("Probabilidad", text: $dist.p.value)
                                //.keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                            if !dist.p.value.isEmpty {
                                Button(action: {
                                    self.dist.objectWillChange.send()
                                    dist.p.value = ""
                                    
                                })
                                {
                                    Image(systemName: "delete.left")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                
                // Salida
                Section(header: Text("Resultados")) {
                    
                    // Probabilidad directa
                    if dist.direct {
                        HStack {
                            
                            // Variable discreta
                            if isDiscrete {
                                if !dist.x.value.isEmpty {
                                    Label { Text("PMF: Pr(") + Text("X").font(FontMath) + Text(" = \(dist.x.value))") }
                                        icon: { Image(systemName: "p.square") }
                                }
                                else {
                                    Label { Text("PMF: Pr(") + Text("X").font(FontMath) + Text(" = \(Image(systemName: "square.dashed")))") }
                                        icon: { Image(systemName: "p.square") }
                                }
                            }
                            
                            // Variable continua
                            else {
                                if !dist.x.value.isEmpty {
                                    Label { Text("PDF en ") + Text("x").font(FontMath) + Text(" = \(dist.x.value)") }
                                        icon: { Image(systemName: "p.square") }
                                }
                                else {
                                    Label { Text("PDF en ") + Text("x").font(FontMath) + Text(" = \(Image(systemName: "square.dashed"))") }
                                        icon: { Image(systemName: "p.square") }
                                }
                            }
                            
                            Spacer()
                            Text(dist.pdf(dist.parameters, dist.x))
                        }
                        
                        HStack {
                            if !dist.x.value.isEmpty {
                                Label { Text("CDF: Pr(") + Text("X").font(FontMath) + Text(" ≤ \(dist.x.value))") }
                                    icon: { Image(systemName: "p.square.fill") }
                            }
                            else {
                                Label { Text("CDF: Pr(") + Text("X").font(FontMath) + Text(" ≤ \(Image(systemName: "square.dashed")))") }
                                    icon: { Image(systemName: "p.square.fill") }
                            }
                            Spacer()
                            Text(dist.cdf(dist.parameters, dist.x)["left"]!)
                        }
                        
                        HStack {
                            
                            // Variable discreta
                            if isDiscrete {
                                if !dist.x.value.isEmpty {
                                    Label { Text("CDF: Pr(") + Text("X").font(FontMath) + Text(" > \(dist.x.value))") }
                                        icon: { Image(systemName: "p.square.fill") }
                                }
                                else {
                                    Label { Text("CDF: Pr(") + Text("X").font(FontMath) + Text(" > \(Image(systemName: "square.dashed")))") }
                                        icon: { Image(systemName: "p.square.fill") }
                                }
                            }
                            
                            // Variable continua
                            else {
                                if !dist.x.value.isEmpty {
                                    Label { Text("CDF: Pr(") + Text("X").font(FontMath) + Text(" ≥ \(dist.x.value))") }
                                        icon: { Image(systemName: "p.square.fill") }
                                }
                                else {
                                    Label { Text("CDF: Pr(") + Text("X").font(FontMath) + Text(" ≥ \(Image(systemName: "square.dashed")))") }
                                        icon: { Image(systemName: "p.square.fill") }
                                }
                            }
                            
                            Spacer()
                            Text(dist.cdf(dist.parameters, dist.x)["right"]!)
                        }
                        HStack {
                            Label("Media", systemImage: "arrow.triangle.merge")
                            Spacer()
                            Text(dist.mean(dist.parameters))
                        }
                        HStack {
                            Label("Varianza", systemImage: "arrow.triangle.branch")
                            Spacer()
                            Text(dist.variance(dist.parameters))
                        }
                    }
                    
                    // Probabilidad inversa
                    else {
                        /*HStack {
                            Label("PDF inversa", systemImage: "x.square")
                            Spacer()
                            Text(dist.ipdf(dist.parameters, dist.p))
                        }*/
                        HStack {
                            Label("CDF inversa", systemImage: "x.square.fill")
                            Spacer()
                            Text(dist.icdf(dist.parameters, dist.p))
                        }
                        HStack {
                            Label("Media", systemImage: "arrow.triangle.merge")
                            Spacer()
                            Text(dist.mean(dist.parameters))
                        }
                        HStack {
                            Label("Varianza", systemImage: "arrow.triangle.branch")
                            Spacer()
                            Text(dist.variance(dist.parameters))
                        }
                    }
                }
            }
        }
        .navigationTitle(dist.name)
    }
}

struct DistributionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DistributionView(dist: exponencial, isDiscrete: true)
        }
    }
}
