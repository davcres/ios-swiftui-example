//
//  MainScreenConnector.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 8/10/21.
//

import Foundation
import SwiftUI

protocol MainScreenConnectorProtocol {}

extension MainScreenConnectorProtocol {}

final class MainScreenConnector: MainScreenConnectorProtocol {

    // MARK: - Dependency Injection
    func assembleModule() -> some View {
        let entityGateway = MainScreenRepository()
        let useCaseFactory = MainScreenUseCaseFactory(entityGateway: entityGateway)
        let viewModel = MainScreenViewModel(useCaseFactory: useCaseFactory)
        return AnyView(MainScreenView(viewModel: viewModel, connector: self))
    }
}
