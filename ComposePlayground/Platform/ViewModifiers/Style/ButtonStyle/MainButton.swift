//
//  MainButton.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 7/10/21.
//

import SwiftUI

struct MainButton: View {

    @Environment(\.colorScheme) var colorScheme
    
    let label: String
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: {
                self.action()
            }, label: {
                Text(self.label)
                    .font(.system(size: 14))
                    .foregroundColor(colorScheme == ColorScheme.dark ? Color.black : Color.white)
            })
                .buttonStyle(MainButtonStyle(color: colorScheme == ColorScheme.dark ? Color.purple_200 : Color.purple_500))
        }
    }
}
