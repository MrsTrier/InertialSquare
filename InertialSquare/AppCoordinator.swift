//
//  AppCoordinator.swift
//  InertialSquare
//
//  Created by Daria Cheremina on 17/11/2024.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func start()
}

final class AppCoordinator: AppCoordinatorProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let inertialSquareVC = InertialSquareViewController()

        navigationController.pushViewController(inertialSquareVC, animated: false)
    }
}
