//
//  RouterProtocol.swift
//  MVP
//
//  Created by Denis Yaremenko on 01.07.2020.
//  Copyright © 2020 Denis Yaremenko. All rights reserved.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: AssemblyBuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMainProtocol {
    func initialViewController()
    func showDetail(comment: Comment?)
    func popToRoot()
}

class Router: RouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationCtrl = navigationController {
            guard let mainVC = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationCtrl.viewControllers = [mainVC]
        }
    }
    
    func showDetail(comment: Comment?) {
        if let navigationCtrl = navigationController {
            guard let detailVC = assemblyBuilder?.createDetailModule(comment: comment, router: self) else { return }
            navigationCtrl.pushViewController(detailVC, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationCtrl = navigationController {
            navigationCtrl.popToRootViewController(animated: true)
        }
    }
}
