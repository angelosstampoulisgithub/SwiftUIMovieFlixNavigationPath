//
//  NavigationManager.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 10/4/25.
//

import Foundation
import SwiftUI
class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ routPathView: AppRoute) {
        path.append(routPathView)
    }
    
    func pop() {
        path.removeLast()
    }
}
