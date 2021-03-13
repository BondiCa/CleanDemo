//
//  Endpoints.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import Foundation

enum Endpoint {
	case getPopularMovies

	var path: String {
		switch self {
		case .getPopularMovies:
			return "movie/popular"

		}
	}

}
