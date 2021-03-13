//
//  MoviesInteractor.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import UIKit

protocol MoviesBusinessLogic {
	func presentMovies(_ movies: [Movie])
	func presentError(_ error: Error)
}

final class MoviesInteractor {

	let worker: MoviesWorker?
	let output: MoviesBusinessLogic

	var movies: [Movie]?

	init(output: MoviesBusinessLogic) {
		self.worker = MoviesWorker()
		self.output = output
	}
}

extension MoviesInteractor: MoviesDisplayLogic {

	func fetchMovies(for page: Int) {
		worker?.fetchMovies(for: page) { [weak self] result in
			guard let self = self else {
				return
			}
			switch result {
			case .success(let movies):
				self.movies = movies
				self.output.presentMovies(movies)
			case .failure(let error):
				self.output.presentError(error)
			}
		}
	}
}
