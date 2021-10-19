//
//  AddPostButtonStyle.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 11/10/21.
//

import SwiftUI

struct AddPostButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        AddPostButtonStyleView(configuration: configuration)
    }
}

private extension AddPostButtonStyle {

    struct AddPostButtonStyleView: View {
        let configuration: AddPostButtonStyle.Configuration

        private let aspectRatio: CGFloat = 175/48
        private let width: CGFloat = 175
        private let height: CGFloat = 48

        var body: some View {
            return configuration.label
                .frame(minWidth: width, idealWidth: width, maxWidth: width,
                       minHeight: height, idealHeight: height, maxHeight: height)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .background(Color.teal_200)
                .cornerRadius(height/2)
        }
    }
}
