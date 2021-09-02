//
//  ContentView.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import SwiftUI

struct ComicsListView: View {
    @ObservedObject var comicsViewModel: ComicsViewModel
    
    @State private var showsFavourites = false
    
    var body: some View {
        if comicsViewModel.showsNavigationBarButtons {
            mainBody
                .navigationBarItems(trailing: favouritesButton)
        }
        else {
            mainBody
        }
    }
    
    init(comicsViewModel: ComicsViewModel) {
        self.comicsViewModel = comicsViewModel
    }
    
    private var mainBody: some View {
        ZStack {
            let hasError = Binding<Bool>(get: { comicsViewModel.error != nil },
                                         set: { if !$0 { comicsViewModel.error = nil } })
            
            Group {
                if comicsViewModel.comicsNumber == 0 {
                    Text("No comics were found")
                        .font(.system(size: 24, weight: .bold))
                }
                else {
                    VStack {
                        ComicView(comic: $comicsViewModel.comic)
                            .frame(maxHeight: .infinity, alignment: .center)
                        
                        Spacer()
                        
                        self.buttonsPanel
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .onAppear {
                comicsViewModel.refreshData()
                comicsViewModel.fetchCurrentComic()
            }
            .alert(isPresented: hasError, content: {
                Alert(title: Text("Error"), message: Text(comicsViewModel.error?.localizedDescription ?? ""))
            })
            .navigationBarTitle(comicsViewModel.navigationBarTitle, displayMode: .inline)
            
            if comicsViewModel.isLoading {
                LoadingProgressView()
            }
        }
    }
    
    private var favouritesButton: some View {
        Group {
            let comicsViewModel = ComicsViewModel(comicsSource: ComicsStorageSource(),
                                                  navigationBarTitle: "Favourites",
                                                  showsNavigationBarButtons: false)
            
            NavigationLink(destination: ComicsListView(comicsViewModel: comicsViewModel),
                           isActive: $showsFavourites) {
                Button(action: { showsFavourites = true }) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
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
    }
}
