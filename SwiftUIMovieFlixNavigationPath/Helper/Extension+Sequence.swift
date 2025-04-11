//
//  Extension+Sequence.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 9/4/25.
//

import Foundation
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var arraySeen: Set<Iterator.Element> = []
        return filter { arraySeen.insert($0).inserted }
    }
}
