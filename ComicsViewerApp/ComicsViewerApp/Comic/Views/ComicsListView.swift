//
//  ContentView.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import SwiftUI

struct ComicsListView: View {
    @ObservedObject var comicsViewModel = ComicsViewModel()
    
    var body: some View {
        let hasError = Binding<Bool>(get: { comicsViewModel.error != nil },
                                     set: { if !$0 { comicsViewModel.error = nil } })
        
        VStack {
            ComicView(comic: $comicsViewModel.comic)
                .frame(maxHeight: .infinity, alignment: .center)
            
            Spacer()
            
            self.buttonsPanel
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .onAppear {
            comicsViewModel.fetchCurrentComic()
        }
        .alert(isPresented: hasError, content: {
            Alert(title: Text("Error"), message: Text(comicsViewModel.error?.localizedDescription ?? ""))
        })
        .navigationBarHidden(true)
    }
    
    private var buttonsPanel: some View {
        HStack {
            PanelButton(systemImageName: "backward.end.fill", imageWeight: .thin) {
                comicsViewModel.fetchFirstComic()
            }
            
            PanelButton(systemImageName: "chevron.backward") {
                comicsViewModel.fetchPreviousComic()
            }
            
            Spacer()
            
            PanelButton(systemImageName: "chevron.forward") {
                comicsViewModel.fetchNextComic()
            }
            
            PanelButton(systemImageName: "forward.end.fill", imageWeight: .thin) {
                comicsViewModel.fetchLatestComic()
            }
        }
    }
}

private struct ComicView: View {
    @State private var showsComicDetails = false
    
    let comic: Binding<Comic?>
    
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
                
                let comicBinding = Binding<Comic>(get: { comic },
                                                  set: { self.comic.wrappedValue = $0 })
                
                NavigationLink(destination: ComicDetailsView(comic: comicBinding), isActive: $showsComicDetails) {
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
