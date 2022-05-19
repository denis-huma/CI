//
//  RouterTest.swift
//  MVPTests
//
//  Created by Denis Yaremenko on 02.07.2020.
//  Copyright © 2020 Denis Yaremenko. All rights reserved.
//

import XCTest
@testable import MVP

class MockNavigationCtrl: UINavigationController {
    var presenterVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presenterVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navCtrl = MockNavigationCtrl()
    let assembly = AssemblyBuilder()

    override func setUp() {
        router = Router(navigationController: navCtrl, assemblyBuilder: assembly)
    }
    
    override func tearDown() {
        router = nil
    }
    
    func testRoute() {
        router.showDetail(comment: nil)
        let detailVC = navCtrl.presenterVC
        XCTAssertTrue(detailVC is DetailView)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
