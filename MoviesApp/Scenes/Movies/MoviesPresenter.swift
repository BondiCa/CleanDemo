//
//  MoviesPresenter.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import Foundation

protocol MoviesPresentationLogic: AnyObject {
	func presentMovies(_ movies: [Movie])
	func presentError(_ error: Error)
}

final class MoviesPresenter {
	weak var viewController: MoviesDisplayLogic?
}

extension MoviesPresenter: MoviesPresentationLogic {

	func presentMovies(_ movies: [Movie]) {
        let viewModels = movies.map { MovieViewModel(title: $0.title, imageURL: $0.imagePath, rating: $0.rating) }
		viewController?.displayMovies(viewModels)
	}

	func presentError(_ error: Error) {
		viewController?.displayError(with: "Failed to get movies", message: error.localizedDescription)
	}
    
    func presentAlert() {
        
    }
  
}
