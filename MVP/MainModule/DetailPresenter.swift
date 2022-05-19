//
//  DetailPresenter.swift
//  MVP
//
//  Created by Denis Yaremenko on 30.06.2020.
//  Copyright © 2020 Denis Yaremenko. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class {
    func setComment(comment: Comment?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?)
    func setComment()
    func tap()
}


class DetailPresenter: DetailViewPresenterProtocol {
    var comment: Comment?
    
    weak var view: DetailViewProtocol?
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?) {
        self.view = view
        self.comment = comment
        self.networkService = networkService
        self.router = router
    }
    
    func setComment() {
        self.view?.setComment(comment: comment)
    }
    
    func tap() {
        router?.popToRoot()
    }
}
