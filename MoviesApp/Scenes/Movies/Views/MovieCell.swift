//
//  MovieCellView.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 11. 3. 2021..
//

import UIKit
import SnapKit
import Kingfisher

final class MovieCell: UITableViewCell {

	private let movieImageView: UIImageView = {
		let view = UIImageView(frame: .zero)
		return view
	}()

	private let titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.textColor = .red
		label.numberOfLines = 0
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		constrainUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
		constrainUI()
	}

	func setupUI() {
		contentView.backgroundColor = .clear
		contentView.addSubview(movieImageView)
		contentView.addSubview(titleLabel)
	}

	func constrainUI() {
		movieImageView.snp.makeConstraints {
			$0.leading.top.bottom.equalToSuperview()
			$0.width.equalToSuperview().multipliedBy(0.5)
		}

		titleLabel.snp.makeConstraints {
			$0.centerY.equalTo(movieImageView)
			$0.leading.equalTo(movieImageView.snp.trailing).offset(30)
			$0.trailing.equalToSuperview().offset(-24)
		}
	}

	func configureWith(imagePath: String?, title: String) {
		if let imagePath = imagePath, let url = URL(string: imagePath) {
			movieImageView.kf.setImage(with: url)
		}
		titleLabel.text = title
	}
}
