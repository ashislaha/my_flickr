# my_flickr

my_flickr is a very basic use-case where the application fetches the data from Flickr web-service and 
showing the images in collection. The images are infinitely scrollable towards down.

## UI components:

### portrait:
![simulator screen shot - iphone x - 2018-09-30 at 20 23 17](https://user-images.githubusercontent.com/10649284/46259046-23b49600-c4f1-11e8-934d-8f15204fe2cb.png)

### landscape:
![simulator screen shot - iphone x - 2018-09-30 at 20 23 37](https://user-images.githubusercontent.com/10649284/46259047-244d2c80-c4f1-11e8-8720-6c13af58da6c.png)

## Architecture:

I tried here "B-VIPER" design pattern to develop the project. Before going into more project details, let's see how B-VIPER works.

### B-VIPER (Builder - View, Interactor, Presenter, Entity, Router):

### Builder:

Builder constructs the VIPER module and the relationship between them and it returns the view. Let's see how the builder looks like in our SearchScreen module

    struct SearchScreenBuilder: SearchScreenBuilderProtocol {
     func buildSearchScreenModule() -> SearchScreenViewController? {
        guard let searchScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchScreenViewController") as? SearchScreenViewController else { return nil }
        // configure the VIPER module
        // View has strong reference of Presenter
        // Presenter has strong reference of Interactor, weak reference of View.
        // Interactor has strong reference of Router, weak reference of Presenter
        // Router has weak reference of View. Builder just builds the initial VIPER module.
        let presenter = SearchScreenPresenter(view: searchScreenVC)
        let router = SearchScreenRouter(viewController: searchScreenVC)
        let interactor = SearchScreenInteractor(router: router, presenter: presenter)
        searchScreenVC.presenter = presenter
        presenter.interactor = interactor
        return searchScreenVC
      }
    }

<img width="512" alt="screen shot 2018-09-28 at 8 27 08 am" src="https://user-images.githubusercontent.com/10649284/46259073-a3426500-c4f1-11e8-8268-3a411f7146d6.png">

### View (ViewController and Views):

Class that has all the code to show the app interface to the user and get their response. Upon receiving the response View alerts the Presenter.

### Presenter:

It holds the view logic. It gets user response from the View and work accordingly. Interactar fetchs data (network calls or local data calls), and give it to presenter and presenter passes the info to view to update the UI.

### Interactor:

Have business logics of an app. Primarily make API calls to fetch data from a source. Responsible for making data calls but not necessarily from itself.

### Router:

Router holds the navigation logic. Moving from One Viper module into another Viper/MVVM/MVC module. Router holds the weak reference of ViewController of the current Viper module. In terms of memory allocations, if you cut this weak reference link the entire Viper module will dealloc.

In my project, Router interacts with Interactor. But sometimes, it can interact with Presenter also to route different view within same Viper module. So it depends on use-cases who will link Router for what purpose.

### Entity:

Contains model structs.

### Services:

It contains data providing services to fetch photos.


## Application flow:

### SearchScreenViewController:

The controller contains a search view controller which is attached with navigation item and a PhotoView which is independent view, can be attached with any module.

### PhotoView:

PhotoView contains a collection of images based on search result. If user scroll down to bottom of the scroll, the app will fetch the next page of data. PhotoView maintains the cache images to reduce the service call.

### Flickr Service API: 

#### To fetch all photos of a particular "search text":

    private let flickrEndPoint = "https://api.flickr.com/services/rest/"
    private let defaultParams: [String: String] = [
        "method": "flickr.photos.search",
        "api_key": "3e7cc266ae2b0e0d78e279ce8e361736",
        "format": "json",
        "safe_search": "1",
        "nojsoncallback": "1"
    ]
 
 <b>variable parameters</b>: 
 
    [ "text": "kittens", "page": "2"]

<b>API example</b>:

    https://api.flickr.com/services/rest/?format=json&api_key=3e7cc266ae2b0e0d78e279ce8e361736&method=flickr.photos.search&safe_search=1&nojsoncallback=1&text=kittens&page=2

<b>API documentation</b>:

        https://www.flickr.com/services/api/explore/flickr.photos.search
        

##### To construct an Image from Response:

        // construct the image url
        // http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
        // example http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg
        
        let imageUrl = "http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"

Photo model will look like:

    struct Photo: Decodable {
          let id: String
          let owner: String
          let secret: String
          let server: String
          let farm: Int
          let title: String
          let isPublic: Int
          let isFriend: Int
          let isFamily: Int

          private enum CodingKeys : String, CodingKey {
              case id, owner, secret, server, farm, title, isPublic = "ispublic", isFriend = "isfriend", isFamily = "isfamily"
          }
    }
    
## Unit testing:

Try to cover some important functionality of the app under unit-testcases.


Thank you :-) 
