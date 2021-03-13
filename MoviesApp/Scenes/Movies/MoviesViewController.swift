//
//  ViewController.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import UIKit

protocol MoviesDisplayLogic {
	var movies: [Movie]? { get }

	func fetchMovies(for page: Int)
}

final class MoviesViewController: UIViewController {

	let contentView = MoviesView()
	var interactor: MoviesDisplayLogic?
	var router: MoviesRoutingLogic?

	var moviesViewModels: [MovieViewModel] = []

	init() {
		super.init(nibName: nil, bundle: nil)
		let router = MoviesRouter(with: self)
		let presenter = MoviesPresenter(output: self)
		let interactor = MoviesInteractor(output: presenter)

		self.interactor = interactor
		self.router = router
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		contentView.delegate = self
		contentView.dataSource = self
		view = contentView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		fetchMovies()
	}

	private func fetchMovies() {
		interactor?.fetchMovies(for: 1)
	}
}

extension MoviesViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		moviesViewModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellView.reuseIdentifier, for: indexPath)

		if let cell = cell as? MovieCellView {
			cell.configureWith(imagePath: moviesViewModels[indexPath.row].imageURL, title: moviesViewModels[indexPath.row].title)
		}
		return cell
	}
}

extension MoviesViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		router?.navigateToMovie(at: indexPath)
	}
}

extension MoviesViewController: MoviesPresentationLogic {
	func displayMovies(_ viewModels: [MovieViewModel]) {
		moviesViewModels = viewModels
		contentView.reloadTable()
		contentView.endRefreshing()
	}

	func displayError() {
		let alert = UIAlertController(title: "Error", message: "Error happened", preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		self.present(alert, animated: true, completion: nil)
	}

}

extension MoviesViewController: MoviesViewDelegate {
	func didRefresh() {
		fetchMovies()
	}

}
