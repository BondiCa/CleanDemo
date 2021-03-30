//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import UIKit

final class MovieViewController: UIViewController {

	let contentView = MovieView()
	var movieViewModel: MovieViewModel?

    init(movieViewModel: MovieViewModel) {
		super.init(nibName: nil, bundle: nil)
        self.movieViewModel = movieViewModel
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
        if let movieTitle = movieViewModel?.title {
			title = movieTitle
		}
	}

	private func setupView() {
		guard let movieViewModel = movieViewModel else {
			return
		}
        contentView.configureWith(imagePath: movieViewModel.imageURL,
                                  description: movieViewModel.title,
                                  rating: movieViewModel.rating)
	}
}
