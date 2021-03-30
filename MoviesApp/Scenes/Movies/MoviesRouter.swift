//
//  MoviesRouter.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import Foundation
import UIKit


protocol MoviesRoutingLogic {
    func navigateToMovie(movieViewModel: MovieViewModel)
}

protocol MoviesRouterDelegate: AnyObject {
	func didNavigateToMovie()
}

final class MoviesRouter {
	weak var viewController: MoviesViewController?
	weak var delegate: MoviesRouterDelegate?
}

extension MoviesRouter: MoviesRoutingLogic {
    func navigateToMovie(movieViewModel: MovieViewModel) {
        let movieViewController = MovieViewController(movieViewModel: movieViewModel)
        viewController?.navigationController?.pushViewController(movieViewController, animated: true)
	}
}
