//
//  File.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 12. 3. 2021..
//

import Foundation

final class MoviesWorker {

	struct MoviesWrapper: Codable {
		let results: [Movie]
	}

	let networkClient: Network
	init(with network: Network = Network(with: "https://api.themoviedb.org/3/")) {
		self.networkClient = network
	}

	func fetchMovies(for page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
		let params = [URLQueryItem(name: "page", value: "\(page)")]
		networkClient.sendRequest(method: .get, path: Endpoint.getPopularMovies.path, queryParams: params, body: nil) { (result: Result<MoviesWrapper, Error> )in
			completion(result.map({$0.results}))
		}
	}
}
