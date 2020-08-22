# PhotoSearch

Use Flickr API to get related photos by user input then show.

## Installation

```bash
$ git clone https://github.com/ariesssyyyang/flickr-photos-search.git
$ cd flickr-photos-search
$ pod install
$ open PhotoSearch.xcworkspace
```

## Environment

* macOS Catalina 10.15.2
* Xcode 11.5
* CocoaPods 1.8.4

## Language

* Swift 5.2

## Architecture

### MVVM

#### Model

For data model, which is decoded from server response data.

It also contains other models unrelated to View and any UI works, e.g. Error cases, API Manager.

#### View (ViewController)

For UI component, including `UICollectionViewCell`, custom `UIButton` and `UITextField`...etc.

Exclude any logic code inside it, and it's only configured by view-model.

#### ViewModel

Compared with data model, this model is for View.

It handles all logic as possible, including what to render, whether to show or hide, and API request to Flickr server.

## Third party framework

* RxSwift
(for reactive UI handling)
* Kingfisher
(for image cache mechanism)

## Reference

* [Flickr API Spec](​https://www.flickr.com/services/api/flickr.photos.search.html)
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [Kingfisher](https://github.com/onevcat/Kingfisher)
