//
//  LoadingView.swift
//  SwiftUIMovieFlixNavigationPath
//
//  Created by Angelos Staboulis on 26/8/25.
//

import SwiftUI

struct LoadingView: View {
    let isLoading: Bool
    let error: NSError?
    let retryAction: (() -> ())?
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error!.localizedDescription).font(.headline)
                        if self.retryAction != nil {
                            Button(action: self.retryAction!) {
                                Text("Retry")
                            }
                            .foregroundColor(Color.blue)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

