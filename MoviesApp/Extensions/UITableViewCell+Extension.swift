//
//  UITableViewCell+Extension.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 17. 3. 2021..
//

import UIKit

extension UITableViewCell {
	/// Returns cell's reuse identifier
	static var identifier: String {
		return String(describing: self)
	}
}
