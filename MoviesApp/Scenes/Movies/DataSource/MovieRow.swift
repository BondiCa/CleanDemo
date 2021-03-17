//
//  MovieRaw.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 17. 3. 2021..
//

import Foundation

enum MovieRow: RowType {
	case movie(viewModel: MovieViewModel)

	var titleText: String {
		switch self {
		case let .movie(viewModel):
			return viewModel.title
		}
	}

	var imagePath: String? {
		switch self {
		case let .movie(viewModel):
			return viewModel.imageURL
		}
	}
}
