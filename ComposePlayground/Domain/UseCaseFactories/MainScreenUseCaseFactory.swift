//
//  MainScreenUseCaseFactory.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 7/10/21.
//

import Foundation

class MainScreenUseCaseFactory {

    // MARK: - Properties
    let entityGateway: MainScreenGateway

    // MARK: - Init
    init(entityGateway: MainScreenGateway) {
        self.entityGateway = entityGateway
    }

    // MARK: - Factory methods
    func getMainScreenPosts(handler: @escaping Handler<[MainScreenItemViewModel]>) -> UseCase {
        GetMainScreenItemsUseCase(entityGateway: entityGateway, handler: handler)
    }
}
