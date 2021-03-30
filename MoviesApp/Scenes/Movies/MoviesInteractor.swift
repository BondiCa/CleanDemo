//
//  MoviesInteractor.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import UIKit

protocol MoviesBusinessLogic {

	func fetchMovies()
    func prepareMovie(with index: Int)
}

final class MoviesInteractor {

	private let worker: MoviesWorker
	var presenter: MoviesPresentationLogic?
    var results = [Movie]()


	init(movieWorker: MoviesWorker = MoviesWorker()) {
		self.worker = movieWorker
	}
}

extension MoviesInteractor: MoviesBusinessLogic {
    
    func prepareMovie(with index: Int) {
        
        let movie = results[index]
        
    }
    
    
    
    

	func fetchMovies() {
		worker.fetchMovies(for: 1) { [weak self] result in
			guard let self = self else {
				return
			}
			switch result {
			case .success(let movies):
				self.presenter?.presentMovies(movies)
                self.results.append(contentsOf: movies)
			case .failure(let error):
				self.presenter?.presentError(error)
			}
		}
	}
    
    
    
    
}
