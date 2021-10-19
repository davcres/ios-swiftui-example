//
//  MainScreenUseCaseFactoryTest.swift
//  ComposePlaygroundTests
//
//  Created by Miguel Sánchez Rueda on 13/10/21.
//

import XCTest
@testable import ComposePlayground

class MainScreenUseCaseFactoryTest: XCTestCase {

    // MARK: - Test variables
    var sut: MainScreenUseCaseFactory!
    var entityGateway: MainScreenGateway!

    // MARK: - Set up and tear down
    override func setUpWithError() throws {
        entityGateway = MainScreenGatewayTestDummy()
        sut = MainScreenUseCaseFactory(entityGateway: entityGateway)
    }

    override func tearDownWithError() throws {
        entityGateway = nil
        sut = nil
    }

    // MARK: - Basic test
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }

    func testGeneratePdfDataForDDUseCase() {
        let useCase = sut.getMainScreenPosts(handler: {_ in})

        XCTAssertNotNil(useCase as? GetMainScreenItemsUseCase)
    }
}
