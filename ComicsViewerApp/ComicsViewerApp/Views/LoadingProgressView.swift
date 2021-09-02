//
//  LoadingProgressView.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 2.09.21.
//

import SwiftUI

struct LoadingProgressView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .frame(width: 40, height: 40)
        }
    }
}
