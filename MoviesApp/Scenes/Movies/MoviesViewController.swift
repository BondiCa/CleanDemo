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
        
        // I know that this code shouldn't be here, but I was started to work today, before one hour :) Sorry about that.
        var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }
//        print("This is the screenHeight", screenWidth)
        
        // Screen height.
        var screenHeight: CGFloat {
            return UIScreen.main.bounds.height
        }
//        print("This is the screenHeight", screenHeight)
        
        let screenSize: CGRect = UIScreen.main.bounds
        print(screenSize)
        
        var buttonWidthPossition = screenWidth - 120
        var buttonHeightPossition = screenHeight - 100
        
        let button = UIButton(
            frame: CGRect(x: buttonWidthPossition, y: buttonHeightPossition, width: 70, height: 50)
        )
        
        button.backgroundColor = #colorLiteral(red: 0.1129138246, green: 0.01918309368, blue: 0.3714316487, alpha: 0.8478246572)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(button)
	}

	private func fetchMovies() {
		interactor?.fetchMovies()
	}
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        showAlertAction(
            title: "Matrix is everywhere.",
            message: "*** You tap the CANCEL button, the story ends.. You wake up in your bed and believe whatever you want to believe. \n *** You tap the OK button, you stay in wonderland, and I show you how deep the rabbit hole goes."
        )
    }
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(
            title: "Ok",
            style: UIAlertAction.Style.default,
            handler: {(action:UIAlertAction!
        ) in
            print("Show alert action")
        }))
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: UIAlertAction.Style.default,
            handler: nil)
        )
        self.present(alert, animated: true, completion: nil)
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
