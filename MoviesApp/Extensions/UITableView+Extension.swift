//
//  UITableView+Extension.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 17. 3. 2021..
//

import UIKit

extension UITableView {
	/// Dequeue reusable cell
	func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
			return T()
		}
		return cell
	}
}
