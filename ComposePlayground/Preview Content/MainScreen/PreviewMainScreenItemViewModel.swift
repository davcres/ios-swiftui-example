//
//  PreviewMainScreenItemViewModel.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 8/10/21.
//

import Foundation

enum PreviewMainScreenItemViewModel {
    static let postCarla = MainScreenItemViewModel(
        id: "1",
        name: "Carla",
        profileImage: "profile_carla",
        postImage: "post_carla")
    
    static let postSonia = MainScreenItemViewModel(
        id: "2",
        name: "Sonia",
        profileImage: "profile_sonia",
        postImage: "post_sonia")
    
    static let postCarlos = MainScreenItemViewModel(
        id: "3",
        name: "Carlos",
        profileImage: "profile_carlos",
        postImage: "post_carlos")
    
    static let postPaco = MainScreenItemViewModel(
        id: "4",
        name: "Paco",
        profileImage: "profile_paco",
        postImage: "post_paco")
    
    static let postJuan = MainScreenItemViewModel(
        id: "5",
        name: "Juan",
        profileImage: "profile_juan",
        postImage: "post_juan")
    
    static let initialPosts = [
        postCarla,
        postSonia,
        postCarlos,
        postPaco,
        postJuan
    ]
}
