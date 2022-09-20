# Comics Viewer App

This app is a brand new viewer for [xkcd comics](https://xkcd.com/). 

## App Features
- Browse through the comics.
- See the comic details (name, description, publication date).
- Get the comic explanation.
- Favorite the comics, which would be available offline too.
- Send comics to others.

## Implementation
The project is separated into two parts: ***XkcdComicsKit*** and ***ComicsViewerApp***.

### XkcdComicsKit
*XkcdComicsKit* is a Swift Package created to work with the *xkcd API* to load the comics. 

The package uses [*Alamofire*](https://github.com/Alamofire/Alamofire) to simplify the work with the network and objects decoding. ***XkcdComicsFetcher*** is responsible for fetching the comics with the API.
***XkcdComicData*** is used to decode the received from the API object and is immediately mapped to ***XkcdComic*** that is the main comic entity in the package. 

***XkcdComicsKit*** class is the package entry point, it contains the package public functions and properties. It gets the data with the ***XkcdComicsFetcher*** and returns it to the caller.

The package is covered with the ***Unit Tests***.

### ComicsViewerApp
*ComicsViewerApp* is the main application project. It uses the *XkcdComicsKit* and [*Realm*](http://realm.io/) to fetch comics and *SwiftUI* to render UI.

The architecture used for the project is ***MVVM***. The ***Comic*** struct is the model that represents a comic throught the project. The project is covered with the ***Unit Tests***.

#### ComicsSource
The project has a protocol for the comics source called ***ComicsSource***. There are two comics source in the app now: ***ComicsStorageSource*** and ***ComicsXkcdSource***.

- ***ComicsStorageSource*** gets the comics from the app storage through ***StorageManager***. ***StorageManager*** uses *Realm* to store data in the local database.
***Comic*** is mapped to **RealmComic** with ***RealmObjectMappable*** protocol to work with the *Realm*.
- ***ComicsXkcdSource*** uses *XkcdComicsKit* to get the comics. It maps ***XkcdComic*** to ***Comic***.

#### Comics UI

There are two screens in the project: ***ComicsListView*** and ***ComicDetailsView***. 

***ComicsListView*** allows to browse through the comics loaded from some ***ComicsSource***. ***ComicsListView*** is initialized with ***ComicsViewModel*** with such parameters as *comicsSource*,
*navigationBarTitle*, *showsNavigationBarButtons*. This ***ComicsViewModel*** works closely with the ***ComicsSource*** and updates ***ComicsListView*** when the data is updated.
The ***ComicsSource*** allows ***ComicsListView*** to show the comics independently from their source. So ***ComicsListView*** shows both comics loaded from the network 
and the favourite comics saved to the local database.

***ComicDetailsView*** shows the comic details. Details include such data as its title, image, description, publication date. There's also a share button in the top right
to share the comic image. The comic explaination is shown in the *SafariView* on the left bottom button click. The comic can be added or removed as a favourite on the
right bottom button click (it's either saved to or deleted from the local database).

## What's next
There's a list of improvements that can be implemented:
- Handle the network connectivity status.
- Add a search for a comic by its number or text.
- Add UI tests.
- Add notifications when a new comic is published.
- Add an iPad support.
