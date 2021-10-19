//
//  AppDelegate.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 7/10/21.
//

import SwiftUI

@main
struct AppDelegate: App {
    var body: some Scene {
        WindowGroup {
            MainScreenConnector().assembleModule()
        }
    }
}
