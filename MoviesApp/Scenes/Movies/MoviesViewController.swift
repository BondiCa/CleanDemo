//
//  ViewController.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import UIKit

protocol MoviesDisplayLogic: AnyObject {
	func displayMovies(_ movies: [MovieViewModel])
	func displayError(with title: String, message: String?)
}

final class MoviesViewController: UIViewController {

	let contentView = MoviesView()
	let dataSource = MoviesDataSource()
	var interactor: MoviesBusinessLogic?
	var router: MoviesRoutingLogic?

	init(moviesRouterDelegate: MoviesRouterDelegate? = nil) {
		super.init(nibName: nil, bundle: nil)
		let presenter = MoviesPresenter()
		presenter.viewController = self
		let interactor = MoviesInteractor()
		interactor.presenter = presenter
		let router = MoviesRouter()
		router.viewController = self
		router.delegate = moviesRouterDelegate
		self.interactor = interactor
		self.router = router
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		contentView.delegate = self
		contentView.dataSource = dataSource
		view = contentView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		fetchMovies()
	}

	private func fetchMovies() {
		interactor?.fetchMovies()
	}
}

extension MoviesViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		router?.navigateToMovie()
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		150
	}
}

extension MoviesViewController: MoviesDisplayLogic {

	func displayMovies(_ movies: [MovieViewModel]) {
		dataSource.updateMovies(movies)
		contentView.reloadTable()
	}

	func displayError(with title: String, message: String?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		self.present(alert, animated: true, completion: nil)
	}
}

extension MoviesViewController: MoviesViewDelegate {

	func didRefresh() {
		fetchMovies()
	}
}
