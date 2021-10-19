//
//  MainScreenViewModelTest.swift
//  ComposePlaygroundTests
//
//  Created by Miguel Sánchez Rueda on 13/10/21.
//

import XCTest
@testable import ComposePlayground

class MainScreenViewModelTest: XCTestCase {

    // MARK: - Test variables
    var sut: MainScreenViewModel!
    var useCaseFactory: UseCaseFactoryMock!

    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        super.setUp()
        let entityGateway = MainScreenRepository()
        useCaseFactory = UseCaseFactoryMock(entityGateway: entityGateway)
        sut = MainScreenViewModel(useCaseFactory: useCaseFactory)
    }

    override func tearDownWithError() throws {
        sut = nil
        useCaseFactory = nil
        super.tearDown()
    }

    // MARK: - Basic test
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }

    // MARK: - View Model
    func testViewReadyInvokesImageUseCase() {
        sut.fillPosts()

        useCaseFactory.useCase.verifyExecuteInvoked()
    }

    // MARK: - Test doubles
    class UseCaseFactoryMock: MainScreenUseCaseFactory {
        var useCase: UseCaseMock!

        override func getMainScreenPosts(handler: @escaping Handler<[MainScreenItemViewModel]>) -> UseCase {
            useCase = UseCaseMock(handler: handler)
            return useCase
        }
    }

    class UseCaseMock: UseCase {
        private var executeWasInvoked = 0
        private var handler: Handler<[MainScreenItemViewModel]>

        init(handler: @escaping Handler<[MainScreenItemViewModel]>) {
            self.handler = handler
        }

        func execute() {
            executeWasInvoked += 1
            handler(.success(PreviewMainScreenItemViewModel.initialPosts))
        }

        func verifyExecuteInvoked(file: StaticString = #filePath, line: UInt = #line) {
            XCTAssertEqual(1, executeWasInvoked, "execute() invoked", file: file, line: line)
        }
    }
}
