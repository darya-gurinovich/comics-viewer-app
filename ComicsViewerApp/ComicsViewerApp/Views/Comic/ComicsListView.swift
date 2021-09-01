//
//  ContentView.swift
//  ComicsViewerApp
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import SwiftUI
import XkcdComicsKit

struct ComicsListView: View {
    @State var comicData: XkcdComic?
    @State var error: Error?
    
    var body: some View {
        let hasError = Binding<Bool>(get: { error != nil },
                                     set: { if !$0 { error = nil } })
        
        VStack {
            ComicView(comic: $comicData)
                .frame(maxHeight: .infinity, alignment: .center)
            
            Spacer()
            
            self.buttonsPanel
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .onAppear {
            XkcdComicsKit.default.fetchCurrentComic(completion: updateData)
        }
        .alert(isPresented: hasError, content: {
            Alert(title: Text("Error"), message: Text(error?.localizedDescription ?? ""))
        })
        .navigationBarHidden(true)
    }
    
    private var buttonsPanel: some View {
        HStack {
            PanelButton(systemImageName: "backward.end.fill", imageWeight: .thin) {
                XkcdComicsKit.default.fetchFirstComic(completion: updateData)
            }
            
            PanelButton(systemImageName: "chevron.backward") {
                XkcdComicsKit.default.fetchPreviousComic(completion: updateData)
            }
            
            Spacer()
            
            PanelButton(systemImageName: "chevron.forward") {
                XkcdComicsKit.default.fetchNextComic(completion: updateData)
            }
            
            PanelButton(systemImageName: "forward.end.fill", imageWeight: .thin) {
                XkcdComicsKit.default.fetchLatestComic(completion: updateData)
            }
        }
    }
    
    private func updateData(comicData: XkcdComic?, error: Error?) {
        if comicData?.imageData != nil {
            self.comicData = comicData
        }
        
        self.error = error
    }
}
