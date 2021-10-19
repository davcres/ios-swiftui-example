//
//  GetMainScreenItemsUseCase.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 7/10/21.
//

import Foundation
import Combine

final class GetMainScreenItemsUseCase {
    // MARK: - Properties
    private let entityGateway: MainScreenGateway
    private var handler: Handler<[MainScreenItemViewModel]>
    private var cancellable: AnyCancellable?

    // MARK: - Init
    init(entityGateway: MainScreenGateway,
         handler: @escaping Handler<[MainScreenItemViewModel]>) {
        self.entityGateway = entityGateway
        self.handler = handler
    }
}

extension GetMainScreenItemsUseCase: UseCase {
    func execute() {
        cancellable = entityGateway.getMainScreenPosts().sink { [weak self] completion in
            if case .failure = completion {
                self?.handler(.failure(DomainError.persistence))
            }
        } receiveValue: { [weak self] posts in
            let responses = posts
            self?.handler(.success(responses))
        }
    }
}
