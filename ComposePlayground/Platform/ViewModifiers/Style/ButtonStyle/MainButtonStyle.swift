//
//  MainButtonStyle.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 7/10/21.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Self.Configuration) -> some View {
        MainButtonStyleView(configuration: configuration, color: color)
    }
}

private extension MainButtonStyle {

    struct MainButtonStyleView: View {
        let configuration: MainButtonStyle.Configuration
        let color: Color

        private let aspectRatio: CGFloat = 184/36
        private let radius: CGFloat = 4

        var body: some View {
            return configuration.label
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .background(color)
                .cornerRadius(radius)
        }
    }
}
