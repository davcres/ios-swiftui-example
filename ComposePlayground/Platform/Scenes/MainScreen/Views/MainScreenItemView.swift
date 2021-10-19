//
//  MainScreenItemView.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 8/10/21.
//

import SwiftUI

struct MainScreenItemView: View {
    
    // MARK: - Properties
    private let profileImageAspectRatio: CGFloat = 800/533
    private let profileImageHeight: CGFloat = 40
    private let postImageAspectRatio: CGFloat = 1024/683
    private let smallIconsAspectRatio: CGFloat = 15/15
    private let smallIconsHeight: CGFloat = 15
    private let smallPadding: CGFloat = 8
    private let generalPadding: CGFloat = 16
    private let iconsPadding: CGFloat = 20
    private let bigPadding: CGFloat = 24
    private let imageHeightCrop: CGFloat = 300
    private let imageWidthCrop: CGFloat = UIScreen.main.bounds.size.width

    @State var isChecked: Bool = false
    let item: MainScreenItemViewModel

    var body: some View {
        VStack {
            // MARK: - Header: Pic, name and more
            HStack {
                /*
                 Un Image mostrará la imagen que pasemos por parámetro, pudiendo ser esta de sistema.
                 En algunos casos aparte de la relación de aspecto, habrá que...
                 */
                Image(item.profileImage)
                //... permitir que se redimensione explicitamente, o no lo hará correctamente.
                    .resizable()
                    .aspectRatio(profileImageAspectRatio, contentMode: .fill)
                    .frame(width: profileImageHeight, height: profileImageHeight)
                // Podemos recortar un círculo aplicando unas esquinas de radio = alturaImg/2.
                    .cornerRadius(profileImageHeight/2)
                    .padding(.leading, smallPadding)

                Text(item.name)

                Spacer()

                Button(action: {},
                       label: {
                    Image(systemName: "ellipsis")
                        .aspectRatio(smallIconsAspectRatio, contentMode: .fit)
                        .frame(width: smallIconsHeight, height: smallIconsHeight)
                        .padding(.trailing, bigPadding)
                })
                    .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, smallPadding)

            // MARK: - Post image
            VStack{
                Image(item.postImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageWidthCrop,
                           height: imageHeightCrop, alignment: .center)
                    .clipped()
                    .padding(.bottom, smallPadding)
            }

            // MARK: - Actions
            HStack{
                Button(action: {
                    isChecked = !isChecked
                },
                       label: {
                    Image(systemName: isChecked ? "heart.fill" : "heart")
                        .aspectRatio(smallIconsAspectRatio, contentMode: .fit)
                        .frame(width: smallIconsHeight, height: smallIconsHeight)
                        .foregroundColor(isChecked ? Color.red : Color.primary)
                })
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, iconsPadding)

                Button(action: {},
                       label: {
                    Image(systemName: "envelope")
                        .aspectRatio(smallIconsAspectRatio, contentMode: .fit)
                        .frame(width: smallIconsHeight, height: smallIconsHeight)
                })
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, iconsPadding)

                Button(action: {},
                       label: {
                    Image(systemName: "square.and.arrow.up")
                        .aspectRatio(smallIconsAspectRatio, contentMode: .fit)
                        .frame(width: smallIconsHeight, height: smallIconsHeight)
                })
                    .buttonStyle(PlainButtonStyle())

                Spacer()
                Button(action: {},
                       label: {
                    Image(systemName: "bookmark")
                        .aspectRatio(smallIconsAspectRatio, contentMode: .fit)
                        .frame(width: smallIconsHeight, height: smallIconsHeight)
                })
                    .buttonStyle(PlainButtonStyle())
            }
            .padding([.horizontal, .bottom], generalPadding)
        }
    }
}

// MARK: - Preview
#if DEBUG

struct MainScreenItemView_Previews: PreviewProvider {

    static let item = PreviewMainScreenItemViewModel.postCarla

    static var previews: some View {
        
        MainScreenItemView(isChecked: true, item: item)
            .colorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}

#endif
