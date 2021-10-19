//
//  MainScreenRepository.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 7/10/21.
//

import Foundation
import Combine

final class MainScreenRepository: MainScreenGateway {
    private var posts: [MainScreenItemViewModel] = []
}

extension MainScreenRepository {

    func getMainScreenPosts() -> AnyPublisher<[MainScreenItemViewModel], MainScreenGatewayError> {
        posts = PreviewMainScreenItemViewModel.initialPosts
        
        return Just(posts).setFailureType(to: MainScreenGatewayError.self).eraseToAnyPublisher()
    }
}
