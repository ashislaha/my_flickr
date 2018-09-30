# my_flickr

my_flickr is a very basic use-case where the application fetches the data from Flickr web-service and 
showing the images in collection.The images are infinitely scrollable towards down.

## UI components:

![simulator screen shot - iphone x - 2018-09-30 at 20 23 17](https://user-images.githubusercontent.com/10649284/46258991-3aa6b880-c4f0-11e8-9a1a-f7cfd2823dae.png)
![simulator screen shot - iphone x - 2018-09-30 at 20 23 37](https://user-images.githubusercontent.com/10649284/46258992-3d091280-c4f0-11e8-84c7-3e092eda5cc1.png)

## Architecture:

I tried here "B-VIPER" design pattern to develop the project. Before going into more project details, let's see how B-VIPER works.

### B-VIPER (Builder - View, Interactor, Presenter, Entity, Router):

### Builder:

Builder constructs the VIPER module and the relationship between them and it returns the view. Let's see how the builder looks like in our HomeScreen module

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
