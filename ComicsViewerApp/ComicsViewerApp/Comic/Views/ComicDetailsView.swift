//
//  ComicDetailsView.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import SwiftUI

struct ComicDetailsView: View {
    let comic: Binding<Comic>
    
    @State private var explainationUrl: URL?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(comic.wrappedValue.title)
                .font(.title)
            
            if let uiImage = UIImage(data: comic.wrappedValue.imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            if let publicationDate = comic.wrappedValue.publicationDate {
                Text("Publication Date: ")
                    .fontWeight(.semibold) +
                    
                Text(publicationDate.getFormattedDate(format: "dd MMMM yyyy"))
            }
            
            Text(comic.wrappedValue.description)
                .font(.body)
            
            Spacer()
            
            self.buttonsPanel
        }
        .multilineTextAlignment(.center)
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .navigationBarTitle("", displayMode: .inline)
        .sheet(item: $explainationUrl) {
            SafariView(url: $0)
        }
    }
    
    private var buttonsPanel: some View {
        HStack {
            PanelButton(systemImageName: "info.circle.fill") {
                if let url = URL(string: comic.wrappedValue.explainationUrlString) {
                    self.explainationUrl = url
                }
            }
            
            Spacer()
            
            PanelButton(systemImageName: comic.wrappedValue.isFavourite ? "heart.fill" : "heart") {
                comic.wrappedValue.isFavourite.toggle()
            }
        }
    }
}
