//
//  MoviesPresenter.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import Foundation

protocol MoviesPresentationLogic {
	func displayMovies(_ viewModels: [MovieViewModel])
	func displayError()
}

final class MoviesPresenter {
	var output: MoviesPresentationLogic?

	init(output: MoviesPresentationLogic) {
		self.output = output
	}
}

extension MoviesPresenter: MoviesBusinessLogic {
	func presentMovies(_ movies: [Movie]) {
		let viewModels = movies.compactMap { movie -> MovieViewModel in

			return MovieViewModel(title: movie.title, imageURL: movie.imagePath)
		}

		output?.displayMovies(viewModels)
	}

	func presentError(_ error: Error) {
		output?.displayError()
	}
}
