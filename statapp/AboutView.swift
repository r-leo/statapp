//
//  AcercaDe.swift
//  statapp
//
//  Created by Rodrigo Leo on 05/07/2021.
//

import SwiftUI

let privacyPolicy: String = """
    Rodrigo Leo ha desarrollado la aplicación "StatApp" (en adelante "el Servicio") como una aplicación gratuita. Este Servicio es provisto sin ningún costo y está diseñado para usarse como tal. Esta política tiene como objetivo informar lo relacionado a la recolección, uso y distribución de información personal de quienes usen el Servicio.
    
    Si decide emplear el Servicio, está de acuerdo en la recolección y uso de información en relación a esta política. La información personal recolectada se usa únicamente para proveer y mejorar el Servicio.

    1. RECOLECCIÓN Y USO DE INFORMACIÓN PERSONAL .Para usar el Servicio no se requiere proporcionar niguna información personal.
    
    2. REGISTRO DE DATOS ("LOG DATA"). En caso de un error en el Servicio, la aplicación recolecta datos e información denominados "Log Data". Esta puede incluir información como la dirección IP de su dispositivo, modelo del dispositivo y versión del sistema operativo, entre otros.
    
    3. COOKIES. Se denominan Cookies a archivos que contienen información empleada comúnmente como identificadores anónimos únicos. Estos se envían a través de su navegador web a sitios web que visita y se almacenan en la memoria interna de su dispositivo. Este servicio no emplea Cookies.
    
    4. CAMBIOS A ESTA POLÍTICA DE PRIVACIDAD. Esta política puede sufrir cambios en cualquier momento. Se le invita a revisarla periódicamente para verificarlo. Cualquier cambio se le notificará mediante la publicación de una versión actualizada de esta política.
    
    Si tiene alguna duda o sugerencia respecto al Servicio o a la presente política, puede dirigirla al correo electrónico rodrigoleopa@gmail.com.
    """

let notaTecnica:String = """
    Para el cálculo de las distribuciones de probabilidad se usa, siempre que sea posible, las expresiones analíticas cerradas de cada distribución. Para los casos en que dichas expresiones no existen o su implementación resulta computacionalmente inviable, se utilizan las aproximaciones provistas por la librería SwiftyStats.
    """

struct AboutView: View {
    var body: some View {
        HStack {
            
            VStack {
                
                // Encabezado
                VStack {
                    /*Text(Image(systemName: "info.circle"))
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()*/
                    Text("StatApp")
                        .font(.title)
                        .padding(.top)
                    Text("v. 1.0")
                        .foregroundColor(.gray)
                }
                
                // Contenido
                ScrollView {
                    VStack(alignment: .leading) {
                        //Divider()
                        
                        Text("Comentarios, incidentes o sugerencias:")
                            .padding(.top)
                        Link("rodrigoleopa@gmail.com",
                              destination: URL(string: "mailto:rodrigoleopa@gmail.com")!)
                            .padding(.bottom)
                        Text("©2021, Rodrigo Leo")
                            .padding(.bottom)
                            .foregroundColor(.gray)
                        
                        Divider()
                        
                        Text("Nota técnica")
                            .font(.title2)
                            .padding(.vertical)
                        Text(notaTecnica)
                            .padding(.bottom)
                        
                        Divider()
                        
                        Text("Política de privacidad")
                            .font(.title2)
                            .padding(.vertical)
                        Text(privacyPolicy)
                            .padding(.bottom)
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .font(.body)
        .padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
