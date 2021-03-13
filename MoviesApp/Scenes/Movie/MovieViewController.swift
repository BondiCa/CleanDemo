//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import UIKit

final class MovieViewController: UIViewController {

	let contentView = MovieView()

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
		setupView()
	}
}

extension MovieViewController {

	private func setupTitle() {
		if let movieTitle = movie?.title {
			title = movieTitle
		}
	}

	private func setupView() {
		guard let movie = movie else {
			return
		}
		contentView.configureWith(imagePath: movie.imagePath, description: movie.overview, rating: movie.rating)
	}
}
