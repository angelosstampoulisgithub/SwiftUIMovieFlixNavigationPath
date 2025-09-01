//
//  NavigationManager.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 1/9/25.
//

import Foundation
import SwiftUI
class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func reset() {
        path = NavigationPath()
    }
}
