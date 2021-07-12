//
//  Plotter.swift
//  statapp
//
//  Created by Rodrigo Leo on 08/07/2021.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Plotter: View {
    var body: some View {
        VStack {
            Triangle()
            Spacer()
            Text("Hola")
        }
    }
}

struct Plotter_Previews: PreviewProvider {
    static var previews: some View {
        Plotter()
    }
}
