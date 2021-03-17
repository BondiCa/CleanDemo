//
//  MoviesView.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import UIKit
import SnapKit

protocol MoviesViewDelegate: class {
	func didRefresh()
}

final class MoviesView: UIView {

	private let tableView: UITableView = {
		let view = UITableView(frame: .zero)
		view.separatorStyle = .singleLine
		view.separatorColor = .red
		view.showsVerticalScrollIndicator = false
		view.rowHeight = UITableView.automaticDimension
		view.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
		return view
	}()

	private let refreshControl = UIRefreshControl()

	var delegate: (MoviesViewDelegate & UITableViewDelegate)? {
		didSet {
			tableView.delegate = delegate
		}
	}

	var dataSource: UITableViewDataSource? {
		didSet {
			tableView.dataSource = dataSource
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		constrainUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
		constrainUI()
	}

	@objc private func refresh() {
		delegate?.didRefresh()
	}

	func reloadTable() {
		tableView.reloadData()
	}

	func endRefreshing() {
		refreshControl.endRefreshing()
	}
}

extension MoviesView {

	private func setupUI() {
		addSubview(tableView)
		tableView.insertSubview(refreshControl, at: 0)
		refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
	}

	private func constrainUI() {
		tableView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
}
