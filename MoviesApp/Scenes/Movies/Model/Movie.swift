//
//  Movie.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import Foundation
// swiftlint:disable identifier_name
struct Movie: Codable {

	let id: Int
	let title: String
	let overview: String?
	let posterPath: String?
	let rating: Double?

	var imagePath: String? {
		guard let posterPath = posterPath else {
			return nil
		}
		return "https://image.tmdb.org/t/p/original/" + posterPath
	}

	private enum CodingKeys: String, CodingKey {
		case id, title, overview
		case posterPath = "poster_path"
		case rating = "vote_average"
	}
}
