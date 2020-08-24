# PhotoSearch

Use Flickr API to get searching results by user input.

## Function

✅ The user must enter something in both **keyword** and **per_page** text fields (the number of photos per page), or the Send-button is disabled.

✅ Tapping `➕` button at the top-right corner of each photo can add it to Favorite collection. The photo(s) collected in Favorite are persistent.

✅ Pull-down the page can refresh the results and render from the first page.

✅ Pull-up to reach to the bottom of the page will get the next page of results if it's available.

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

### M-V-VM

#### Model

1. For data model, which is decoded from server response data.

2. Other models unrelated to View and any UI works, e.g. Error cases, `ApiManager` and `LocalStore`.

#### View (ViewController)

1. For UI component, including `UICollectionViewCell`, custom `UIButton` and `UITextField`...etc.
2. In ideal situation, it will not contains any logic.
3. Only configured by view-model.
(which means could not communicate with any Model directly)

#### ViewModel

1. Compared with data model, this model is for View.

2. It separate as much logic as possible from View, including
  * what to render
  * whether to show or hide, and
  * retrieve data

### Concept


#### ▶ owned ; ➡ data stream direction

```
                      |           |
                   ▶️▶️▶️      ▶️▶️▶️
ViewController(View)  | ViewModel |  Model
                   ⬅️⬅️⬅️      ⬅️⬅️⬅️
                      |           |
```

## CocoaPods

For 3rd party frameworks management.

#### Reactive

* RxSwift
* RxCocoa

#### Image

* Kingfisher

## Reference

* [Flickr API Spec](​https://www.flickr.com/services/api/flickr.photos.search.html)
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [Kingfisher](https://github.com/onevcat/Kingfisher)
