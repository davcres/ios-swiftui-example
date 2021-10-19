//
//  AddPostButtonView.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 11/10/21.
//

import SwiftUI

struct AddPostButtonView: View {
    private let narrowPadding: CGFloat = 16
    private let smallPadding: CGFloat = 4

    let label: String
    let action: () -> Void

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()

                Button(action: {
                    self.action()
                }, label: {
                    HStack {
                    Image(systemName: "plus")
                        .padding(.leading, narrowPadding)
                        .padding(.trailing, smallPadding)
                        .foregroundColor(Color.black)

                    Text(self.label)
                        .font(.system(size: 14))
                        .foregroundColor(Color.black)
                        .padding(.trailing, narrowPadding)
                    }
                })
                    .padding([.bottom, .trailing], narrowPadding)
                    .buttonStyle(AddPostButtonStyle())
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
