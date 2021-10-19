//
//  MainScreenGatewayTestDummy.swift
//  ComposePlaygroundTests
//
//  Created by Miguel Sánchez Rueda on 13/10/21.
//

import Combine
import Foundation
@testable import ComposePlayground

class MainScreenGatewayTestDummy: MainScreenGateway {
    func getMainScreenPosts() -> AnyPublisher<[MainScreenItemViewModel], MainScreenGatewayError> {
        Empty().setFailureType(to: MainScreenGatewayError.self).eraseToAnyPublisher()
    }
}
