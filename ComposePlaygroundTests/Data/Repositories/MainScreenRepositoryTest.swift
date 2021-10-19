//
//  MainScreenRepositoryTest.swift
//  ComposePlaygroundTests
//
//  Created by Miguel Sánchez Rueda on 13/10/21.
//

import XCTest
import Combine
@testable import ComposePlayground

class MainScreenRepositoryTest: XCTestCase {

    // MARK: - Test variables
    var sut: MainScreenRepository!
    var entityGateway: MainScreenGatewayMock!

    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        super.setUp()
        entityGateway = MainScreenGatewayMock()
        sut = MainScreenRepository()
    }

    override func tearDownWithError() throws {
        entityGateway = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    // MARK: - Fetch posts return not nil value
    func testFetchNotNilResponse() {
        var returnedResult = PreviewMainScreenItemViewModel.initialPosts

        _ = sut.getMainScreenPosts().sink { _ in
        } receiveValue: { result in
            returnedResult = result
        }

        XCTAssertNotNil(returnedResult)
    }

    // MARK: - Fetch posts return expected result
    func testFetchValidResponse() {
        var returnedResult: [MainScreenItemViewModel] = []
        let expectedResult = PreviewMainScreenItemViewModel.initialPosts

        _ = sut.getMainScreenPosts().sink { _ in
        } receiveValue: { result in
            returnedResult = result
        }

        XCTAssertEqual(returnedResult, expectedResult)
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

