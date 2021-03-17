//
//  SectionType.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 17. 3. 2021..
//

import Foundation

protocol SectionType {
	associatedtype Row: RowType
	var rows: [Row] { get }
}

extension SectionType {
	func row(at index: Int) -> Row? {
		return index < rows.count ? rows[index] : nil
	}
}
