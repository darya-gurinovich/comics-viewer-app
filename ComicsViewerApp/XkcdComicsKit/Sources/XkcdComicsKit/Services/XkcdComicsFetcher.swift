//
//  File.swift
//  
//
//  Created by Dasha Gurinovich on 1.09.21.
//

import Alamofire
import Foundation

struct XkcdComicsFetcher {
    private struct URLs {
        static let currentComic = "https://xkcd.com/info.0.json"
        static let numberedComic = "https://xkcd.com/%d/info.0.json"
        static let explaination = "https://www.explainxkcd.com/wiki/index.php/%d"
    }
    
    func getComicsNumber(completion: @escaping (Int?) -> Void) {
        AF.request(URLs.currentComic).responseDecodable(of: XkcdComicData.self) { response in
            guard let xkcdComicData = response.value else {
                completion(nil)
                
                return
            }
            
            completion(xkcdComicData.number)
        }
    }
    
    // MARK: Comics data fetching
    
    /// Fetches a `XkcdComic`
    ///
    /// - Parameters:
    ///     - number: The comic number to fetch by. If it's `nil` then the `current` day comic will be fetched
    ///     - completion: The completion function that returns either `XkcdComic` or `Error`
    ///
    func fetchComic(number: Int? = nil, completion: @escaping (XkcdComic?, Error?) -> Void) {
        let comicUrl: String
        
        if let number = number {
            comicUrl = String(format: URLs.numberedComic, number)
        }
        else {
            comicUrl = URLs.currentComic
        }
        
        fetchComic(from: comicUrl, completion: completion)
    }
    
    /// Fetches a `XkcdComic` from the URL string
    ///
    /// - Parameters:
    ///     - urlString: The URL string to fetch the `XkcdComic` from
    ///     - completion: The completion function that returns either `XkcdComic` or `Error`
    ///
    private func fetchComic(from urlString: String, completion: @escaping (XkcdComic?, Error?) -> Void) {
        AF.request(urlString).responseDecodable(of: XkcdComicData.self) { response in
            guard let xkcdComicData = response.value else {
                completion(nil, XkcdComicError.dataLoadingFailed)
                
                return
            }
            
            self.fetchComicImage(from: xkcdComicData.imageUrl) {
                guard let comicImageData = $0 else {
                    completion(nil, XkcdComicError.imageLoadingFailed)
                    
                    return
                }
                
                let publicationDate = Date.from(year: xkcdComicData.year, month: xkcdComicData.month, day: xkcdComicData.day)
                let explainationUrlString = String(format: URLs.explaination, xkcdComicData.number)
                
                let xkcdComic = XkcdComic(title: xkcdComicData.title,
                                          description: xkcdComicData.description,
                                          imageData: comicImageData,
                                          number: xkcdComicData.number,
                                          publicationDate: publicationDate,
                                          explainationUrlString: explainationUrlString)
                completion(xkcdComic, nil)
            }
        }
    }
    
    /// Fetches a comic image `Data` from the URL string
    ///
    /// - Parameters:
    ///     - urlString: The URL string to fetch the image  from
    ///     - completion: The completion function
    ///
    private func fetchComicImage(from urlString: String, completion:  @escaping (Data?) -> Void) {
        AF.request(urlString).response { response in
            completion(response.data)
        }
    }
}
