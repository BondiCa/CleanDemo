//
//  MoviesInteractor.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import UIKit

protocol MoviesBusinessLogic {
	func fetchMovies()
}

final class MoviesInteractor {

	private let worker: MoviesWorker
	var presenter: MoviesPresentationLogic?

	init(movieWorker: MoviesWorker = MoviesWorker()) {
		self.worker = movieWorker
	}
}

extension MoviesInteractor: MoviesBusinessLogic {
	func fetchMovies() {
		worker.fetchMovies(for: 1) { [weak self] result in
			guard let self = self else {
				return
			}
			switch result {
			case .success(let movies):
				self.presenter?.presentMovies(movies)
			case .failure(let error):
				self.presenter?.presentError(error)
			}
		}
	}
}
