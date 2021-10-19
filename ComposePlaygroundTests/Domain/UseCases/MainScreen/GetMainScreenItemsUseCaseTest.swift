//
//  GetMainScreenItemsUseCaseTest.swift
//  ComposePlaygroundTests
//
//  Created by Miguel Sánchez Rueda on 13/10/21.
//

import XCTest
import Combine
@testable import ComposePlayground

class GetMainScreenItemsUseCaseTest: XCTestCase {

    // MARK: - Test variables
    var sut: GetMainScreenItemsUseCase!
    var entityGateway: MainScreenGatewayMock!

    var posts: [MainScreenItemViewModel]?
    var error: DomainError?

    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        entityGateway = MainScreenGatewayMock()

        sut = GetMainScreenItemsUseCase(entityGateway: entityGateway,
                                        handler: { [weak self] result in
            switch result {
            case let .success(posts):
                self?.posts = posts
            case let .failure(error):
                self?.error = error
            }
        })
    }

    override func tearDownWithError() throws {
        sut = nil
        entityGateway = nil
    }

    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testRepoWithNilDataGeneratesErrorResponse() {
        let expectedResult = PreviewMainScreenItemViewModel.initialPosts
        
        sut.execute()

        XCTAssertEqual(posts, expectedResult)
    }

    func testReportsErrorFromVerifierGateway() {
        entityGateway.error = MainScreenGatewayError.empty
        var isError = false

        sut.execute()

        switch error {
        case .persistence:
            isError = true
        default:
            isError = false
        }
        XCTAssertTrue(isError)
    }

    // MARK: - Test Doubles
    class MainScreenGatewayMock: MainScreenGatewayTestDummy {
        var error: MainScreenGatewayError?

        override func getMainScreenPosts() -> AnyPublisher<[MainScreenItemViewModel], MainScreenGatewayError> {
            if error != nil {
                return Fail(error: MainScreenGatewayError.empty).eraseToAnyPublisher()
            }
            return Just(PreviewMainScreenItemViewModel.initialPosts)
                .setFailureType(to: MainScreenGatewayError.self).eraseToAnyPublisher()
        }
    }
}
