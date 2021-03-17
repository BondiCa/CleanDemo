//
//  MoviesDataSource.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 17. 3. 2021..
//

import UIKit

class MoviesDataSource: NSObject, DataSourceType {

	var sections: [MovieSection] = []
}

// MARK: Public methods
extension MoviesDataSource {

	func updateMovies(_ viewModels: [MovieViewModel]) {
		buildSections(viewModels)
	}
}

// MARK: Private methods
private extension MoviesDataSource {

	func buildSections(_ viewModels: [MovieViewModel]) {
		let moviesRows: [MovieRow] = viewModels.map({.movie(viewModel: $0)})
		sections = [.movies(moviesRows: moviesRows)]
	}
}

extension MoviesDataSource: UITableViewDataSource {

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let row = section(at: indexPath.section)?.row(at: indexPath.row) else {
			return UITableViewCell()
		}

		let cell = tableView.dequeueReusableCell(MovieCell.self, for: indexPath)
		cell.configureWith(imagePath: row.imagePath, title: row.titleText)
		return cell
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		sections.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		numberOfRows(in: section)
	}
}
