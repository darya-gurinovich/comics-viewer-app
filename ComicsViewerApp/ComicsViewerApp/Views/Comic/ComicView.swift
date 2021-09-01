//
//  ComicView.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import XkcdComicsKit
import SwiftUI

struct ComicView: View {
    @State private var showsComicDetails = false
    
    let comic: Binding<XkcdComic?>
    
    var body: some View {
        if let comic = self.comic.wrappedValue,
           let uiImage = UIImage(data: comic.imageData) {
            VStack {
                Text(comic.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                NavigationLink(destination: ComicDetailsView(comic: comic), isActive: $showsComicDetails) {
                    Button(action: { self.showsComicDetails = true }) {
                        Text("More")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.blue)
                            .padding(8)
                            .frame(width: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.blue, lineWidth: 2)
                            )
                    }
                }
            }
        }
        else {
            Text("Loading...")
        }
    }
}
