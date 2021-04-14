//
//  MovieView.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import UIKit
import SnapKit
import Kingfisher

final class MovieView: UIView {
    private let movieImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let descriptionTextView: UITextView = {
        let label = UITextView(frame: .zero)
        label.textColor = .red
        return label
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Klikni me!", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        return button
    }()
    
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
}

extension MovieView {
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(movieImageView)
        addSubview(descriptionTextView)
        addSubview(ratingLabel)
        addSubview(alertButton)
        
    }
    
    private func constrainUI() {
        movieImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(movieImageView.snp.width).multipliedBy(0.8)
        }
        ratingLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-32)
        }
        descriptionTextView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(ratingLabel.snp.top).offset(-20)
            $0.top.equalTo(movieImageView.snp.bottom).offset(20)
        }
        alertButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.bottom.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
    }
    
    func configureWith(imagePath: String?, description: String?, rating: Double?) {
        if let imagePath = imagePath, let url = URL(string: imagePath) {
            movieImageView.kf.setImage(with: url)
        }
        descriptionTextView.text = description
        ratingLabel.text = "Rating: \(rating ?? 0)"
    }
}
