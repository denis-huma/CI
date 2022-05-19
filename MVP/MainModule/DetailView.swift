//
//  DetailView.swift
//  MVP
//
//  Created by Denis Yaremenko on 30.06.2020.
//  Copyright © 2020 Denis Yaremenko. All rights reserved.
//

import UIKit

class DetailView: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func tapAction(_ sender: Any) {
        presenter.tap()
    }
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setComment()
    }
}

extension DetailView: DetailViewProtocol {
    func setComment(comment: Comment?) {
        titleLabel.text = comment?.body
    }
}
