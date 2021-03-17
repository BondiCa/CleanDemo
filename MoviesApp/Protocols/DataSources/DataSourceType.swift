//
//  DataSourceType.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 17. 3. 2021..
//

import Foundation

protocol DataSourceType {
	associatedtype Section: SectionType
	var sections: [Section] { get set }
}

extension DataSourceType {
	func section(at index: Int) -> Section? {
		return index < sections.count ? sections[index] : nil
	}

	func numberOfRows(in sectionIndex: Int) -> Int {
		return section(at: sectionIndex)?.rows.count ?? 0
	}

//	func isLastCell(indexPath: IndexPath) -> Bool {
//		return indexPath.section == (sections.count - 1) && indexPath.row == (sections.last?.rows.count ?? 0) - 1
//	}
//
//	func isLastRow(_ rowIndex: Int, in section: Self.Section) -> Bool {
//		return rowIndex == (section.rows.count - 1)
//	}

}
