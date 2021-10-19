//
//  MainScreenViewModel.swift
//  ComposePlayground
//
//  Created by Miguel Sánchez Rueda on 7/10/21.
//

import Combine
import Foundation

protocol MainScreenViewModelOutput: ObservableObject {
    var posts: [MainScreenItemViewModel] { get }
}

protocol MainScreenViewModelInput: ObservableObject {
    func emptyPosts()
    func fillPosts()
}

protocol MainScreenViewModelProtocol: MainScreenViewModelOutput, MainScreenViewModelInput {}

class MainScreenViewModel: MainScreenViewModelProtocol {

    // MARK: - Properties
    @Published var posts: [MainScreenItemViewModel] = []
    
    private let useCaseFactory: MainScreenUseCaseFactory
    private var useCase: UseCase?

    // MARK: - Init
    init(useCaseFactory: MainScreenUseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    func emptyPosts() {
        posts = []
    }

    func fillPosts() {
        useCase = useCaseFactory.getMainScreenPosts() { [weak self] result in
            if case let Result.success(posts) = result {
                self?.posts = posts
                self?.useCase = nil
            }
        }
        useCase?.execute()
    }
}
