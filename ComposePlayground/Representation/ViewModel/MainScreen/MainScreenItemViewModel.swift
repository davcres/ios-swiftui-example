//
//  MainScreenItemViewModel.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 8/10/21.
//

import Foundation

struct MainScreenItemViewModel: Equatable, Hashable, Identifiable {
    let id: String
    let name: String
    let profileImage: String
    var postImage: String
}
