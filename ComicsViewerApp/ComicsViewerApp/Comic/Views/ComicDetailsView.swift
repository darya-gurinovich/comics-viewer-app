//
//  ComicDetailsView.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import SwiftUI

struct ComicDetailsView: View {
    let comic: Binding<Comic>
    
    @State private var chosenSheetOption: SheetOption?
    
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
        .navigationBarItems(trailing: shareButton)
        .navigationBarTitle("", displayMode: .inline)
        .sheet(item: $chosenSheetOption) {
            switch $0 {
            case .activity(let image):
                ActivityViewController(activityItems: [image])

            case .safari(let url):
                SafariView(url: url)
            }
        }
    }
    
    private var shareButton: some View {
        Button(action: {
            if let image = UIImage(data: comic.wrappedValue.imageData) {
                self.chosenSheetOption = .activity(image: image)
            }
        }) {
            Image(systemName: "square.and.arrow.up")
        }
    }
    
    private var buttonsPanel: some View {
        HStack {
            PanelButton(systemImageName: "info.circle.fill") {
                if let url = URL(string: comic.wrappedValue.explainationUrlString) {
                    self.chosenSheetOption = .safari(url: url)
                }
            }
            
            Spacer()
            
            PanelButton(systemImageName: comic.wrappedValue.isFavourite ? "heart.fill" : "heart") {
                comic.wrappedValue.isFavourite.toggle()
            }
        }
    }
    
    enum SheetOption: Identifiable {
        case activity(image: UIImage)
        case safari(url: URL)
        
        public var id: Int {
            switch self {
            case .activity(let image):
                return image.hashValue

            case .safari(let url):
                return url.hashValue
            }
        }
    }
}
