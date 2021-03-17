//
//  MovieSection.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 17. 3. 2021..
//

import Foundation

enum MovieSection: SectionType {
	case movies(moviesRows: [MovieRow])

	var rows: [MovieRow] {
		switch self {
		case let .movies(rows):
			return rows
		}
	}
}
