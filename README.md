#  RouteKit

1. Create route
```swift
protocol DetailRoute where Self: RouterProtocol {
  func openDetail(/* some dependencies */)
}

extension DetailRoute {
  func openDetail(/* some dependencies */) {
    let transition = ModalTransition(fromViewController: viewController)
    let controller = DetailViewController<DetailRouter>()
    controller.router = DetailRouter(viewController: controller, fromTransition: transition)
    /* set dependencies */
    transition.open(controller, animated: true, completion: nil)
  }
}
```

2. Create router
```swift
protocol ListRouterProtocol: DetailRoute /* more routes */ {}

class ListRouter: Router, ListRouterProtocol {}
```

3. Use router with your controller
```swift
class ListViewController<Router: ListRouterProtocol>: ViewController<Router> {
  func didTouch() {
    router.openDetail(/* some dependencies */)
  }
}
```
