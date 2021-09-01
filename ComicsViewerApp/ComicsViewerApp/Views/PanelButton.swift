//
//  PanelButton.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import SwiftUI

struct PanelButton: View {
    let systemImageName: String
    let imageWeight: Font.Weight
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImageName)
                .foregroundColor(.white)
                .font(.system(size: 24, weight: imageWeight))
                .frame(width: 50, height: 50)
                .background(
                    Color.blue
                        .cornerRadius(8)
                )
        }
    }
    
    init(systemImageName: String,
         imageWeight: Font.Weight = .bold,
         action: @escaping () -> Void) {
        self.systemImageName = systemImageName
        self.imageWeight = imageWeight
        
        self.action = action
    }
}
