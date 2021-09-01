public class XkcdComicsKit {
    private var totalComicsNumber: Int?
    private var currentComicNumber: Int?
    
    private let comicsFetcher = XkcdComicsFetcher()
    
    public static let `default` = XkcdComicsKit()
    
    private init() {
        comicsFetcher.getComicsNumber { [unowned self] in
            self.totalComicsNumber = $0
        }
    }
    
    public func fetchCurrentComic(completion: @escaping (XkcdComic?, Error?) -> Void) {
        fetchComic(number: currentComicNumber, completion: completion)
    }
    
    public func fetchFirstComic(completion: @escaping (XkcdComic?, Error?) -> Void) {
        fetchComic(number: 1, completion: completion)
    }
    
    public func fetchPreviousComic(completion: @escaping (XkcdComic?, Error?) -> Void) {
        guard let currentComicNumber = self.currentComicNumber else {
            completion(nil, XkcdComicError.currentComicMissing)
            
            return
        }
        
        guard currentComicNumber > 1 else {
            completion(nil,  XkcdComicError.noPreviousComic)
            
            return
        }
        
        fetchComic(number: currentComicNumber - 1, completion: completion)
    }
    
    public func fetchNextComic(completion: @escaping (XkcdComic?, Error?) -> Void) {
        guard let currentComicNumber = self.currentComicNumber else {
            completion(nil, XkcdComicError.currentComicMissing)
            
            return
        }
        
        fetchComic(number: currentComicNumber + 1, completion: completion)
    }
    
    public func fetchLatestComic(completion: @escaping (XkcdComic?, Error?) -> Void) {
        guard let totalComicsNumber = self.totalComicsNumber else {
            completion(nil, XkcdComicError.totalComicsNumberUnknown)
            
            return
        }
        
        fetchComic(number: totalComicsNumber, completion: completion)
    }
    
    private func fetchComic(number: Int? = nil, completion: @escaping (XkcdComic?, Error?) -> Void) {
        comicsFetcher.fetchComic(number: number) { [unowned self] in
            if let comicNumber = $0?.number {
                self.currentComicNumber = comicNumber
            }
            
            completion($0, $1)
        }
    }
}
