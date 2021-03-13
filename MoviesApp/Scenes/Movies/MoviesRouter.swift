//
//  MoviesRouter.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import Foundation

protocol MoviesRoutingLogic {
	var viewController: MoviesViewController? { get }
	func navigateToMovie(at indexPath: IndexPath)

}

final class MoviesRouter {
	weak var viewController: MoviesViewController?

	init(with viewController: MoviesViewController) {
		self.viewController = viewController
	}
}

extension MoviesRouter: MoviesRoutingLogic {
	func navigateToMovie(at indexPath: IndexPath) {
		if let movies = viewController?.interactor?.movies, indexPath.row < movies.count {

			let movieViewController = MovieViewController()
			movieViewController.movie = movies[indexPath.row]
			viewController?.navigationController?.pushViewController(movieViewController, animated: true)
		}

	}
}
