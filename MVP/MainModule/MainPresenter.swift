//
//  MainPresenter.swift
//  MVP
//
//  Created by Denis Yaremenko on 30.06.2020.
//  Copyright © 2020 Denis Yaremenko. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class { // update UI
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getComments()
    var comments: [Comment]? {get set}
    func tapOnTheComment(comment: Comment?)
}

class MainPresenter: MainViewPresenterProtocol {
    
    var router: RouterProtocol?
    var comments: [Comment]?
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getComments()
    }
    
    func tapOnTheComment(comment: Comment?) {
        router?.showDetail(comment: comment)
    }

    func getComments() {
        networkService.getComments { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                      case .success(let comments):
                          self.comments = comments
                          self.view?.success()
                          
                      case .failure(let error):
                          self.view?.failure(error: error)
                      }
            }
        }
    }
}
