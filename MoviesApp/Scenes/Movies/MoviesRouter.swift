//
//  MoviesRouter.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import Foundation

protocol MoviesRoutingLogic {
	func navigateToMovie()
}

protocol MoviesRouterDelegate: AnyObject {
	func didNavigateToMovie()
}

final class MoviesRouter {
	weak var viewController: MoviesViewController?
	weak var delegate: MoviesRouterDelegate?
}

extension MoviesRouter: MoviesRoutingLogic {

	func navigateToMovie() {
	}
}
