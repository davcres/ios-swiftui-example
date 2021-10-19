//
//  ExampleView.swift
//  ComposePlayground
//
//  Created by Gonzalo  on 19/10/21.
//

import SwiftUI

struct ExampleView: View {
    
    let names = ["Yania", "Jorge", "Miguel", "Juan", "Raquel", "Pepe", "Ramon"]
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer(minLength: 20.0)
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
                
                Spacer()
                
                Text("Saludos")
                    .font(Font.title)
                    .bold()
                
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
                Spacer(minLength: 20.0)
            }
            
            
            List {
                ForEach (names, id: \.self) { name in
                    VStack {
                        Text("Hola, \(name)!")
                            .font(Font.title)
                            .foregroundColor(Color.white)
                        Text("Esto es SwiftUI")
                            .font(Font.footnote)
                            .foregroundColor(Color.white)
                    }.listRowBackground(Color.green)
                }
            }
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
