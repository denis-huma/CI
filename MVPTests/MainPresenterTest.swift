//
//  MainPresenterTest.swift
//  MVPTests
//
//  Created by Denis Yaremenko on 29.06.2020.
//  Copyright © 2020 Denis Yaremenko. All rights reserved.
//

import XCTest
@testable import MVP

class MockView: MainViewProtocol {
    func success() {}
    func failure(error: Error) {}
}

class MockNetorkService: NetworkServiceProtocol {
    
    var comments: [Comment]!
    
    init() {}
    
    convenience init(comments: [Comment]) {
        self.init()
        self.comments = comments
    }
    
    func getComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments))
        } else {
            let error = NSError(domain: "no comments", code: 666, userInfo: nil)
            completion(.failure(error))
        }
    }
}

class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Comment]()
    
    override func setUp() {
        print("Setup:")
        let nav = UINavigationController()
        let assembly = AssemblyBuilder()
        router = Router(navigationController: nav, assemblyBuilder: assembly)
    }
    
    override func tearDown() {
       print("Tear down:")
        view = nil
        networkService = nil
        presenter = nil
    }

    func testGetSuccessComments() {
        let comment = Comment(postId: 1, id: 2, name: "foo", email: "baz", body: "BAZ")
        comments.append(comment)
        view = MockView()
        networkService = MockNetorkService(comments: comments) // convenience init
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchComments: [Comment]?
        
        networkService.getComments { (result) in
            switch result {
            case .success(let comments):
                catchComments = comments
                
            case .failure(let error):
                print("Error", error.localizedDescription)
            }
        }
        
        XCTAssertNotEqual(catchComments?.count, 0) // never be nil
        XCTAssertEqual(catchComments?.count, 500)
    }
    
    func testGetFailureComments() {
         let comment = Comment(postId: 1, id: 2, name: "foo", email: "baz", body: "BAZ")
         comments.append(comment)
         view = MockView()
         networkService = MockNetorkService()// designated init
         presenter = MainPresenter(view: view, networkService: networkService, router: router)
         
         var catchError: Error?
         
         networkService.getComments { (result) in
             switch result {
             case .success(let results):
                 break
                 
             case .failure(let error):
                catchError = error
                 print("Error", error.localizedDescription)
             }
         }
         
         XCTAssertNotNil(catchError)
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
