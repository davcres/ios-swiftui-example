//
//  MainScreenGateway.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 8/10/21.
//

import Combine
import Foundation

enum MainScreenGatewayError: Error {
    case empty
}

protocol MainScreenGateway {
    func getMainScreenPosts() -> AnyPublisher<[MainScreenItemViewModel], MainScreenGatewayError>
}
