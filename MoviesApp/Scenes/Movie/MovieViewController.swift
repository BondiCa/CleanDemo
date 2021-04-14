//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import UIKit

protocol MovieDisplayLogic: AnyObject {
    func didTapButton()
}

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

private extension MovieViewController {
    
    func setupTitle() {
        if let movieTitle = movieViewModel?.title {
            title = movieTitle
        }
    }
    
    func setupView() {
        guard let movieViewModel = movieViewModel else {
            return
        }
        contentView.configureWith(imagePath: movieViewModel.imageURL,
                                  description: movieViewModel.title,
                                  rating: movieViewModel.rating)
        contentView.alertButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        let alert = UIAlertController(title: "OBAVEŠTENJE", message: "Vladimir je car", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Potvrdjujem", style: .default) { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
}




