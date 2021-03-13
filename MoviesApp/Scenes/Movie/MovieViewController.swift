//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import UIKit

protocol MovieDisplayLogic {
}

final class MovieViewController: UIViewController {

	let contentView = MovieView()
	var interactor: MovieDisplayLogic?

	var movie: Movie?
	init() {
		super.init(nibName: nil, bundle: nil)

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = contentView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTitle()
	}
}

extension MovieViewController {

	private func setupTitle() {
		if let movieTitle = movie?.title {
			title = movieTitle
		}
	}
}

extension MovieViewController {

}
