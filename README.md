# Coordinator Library

The Coordinator library is a lightweight Swift framework designed to simplify the navigation and coordination of view controllers in your iOS applications. It provides a clean and organized way to manage the flow of your app by abstracting away the navigation stack and reducing the coupling between view controllers.

## Installation

You can easily integrate the Coordinator library into your project using Swift Package Manager (SPM).

### Swift Package Manager

1. Open your Xcode project.
2. Go to "File" > "Swift Packages" > "Add Package Dependency..."
3. Enter the URL of this repository: `https://github.com/lbrdev/Coordinator.git`
4. Specify the version or branch you want to use.
5. Click "Next" and follow the installation prompts.

## Getting Started

To get started with the Coordinator library, follow these steps:

1. Import the Coordinator module in your Swift file:

```swift
   import Coordinator
```
2. Create a coordinator class that inherits to the Coordinator or NavigationCoordinator. This class will be responsible for coordinating the navigation between your view controllers.
```swift
enum MyMeta: CoordinationMeta {
    case login
}

class MyCoordinator: NavigationCoordinator<MyMeta> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: UINavigationController())
    }

    override func start(with meta: MyMeta) {
        super.start(with: meta)
        switch meta {
            case .login:
                showLogin()
        }
    }
}
```

3. Put the start of root coordintor in scene delegate as example:
```swift
    // must be strong reference
    var coordinator: MyCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        guard let window = window else { return }
        coordinator = MyCoordinator(window: window)
        coordinator?.start(with: .login)
    }

```
4. Open controller from coordiator:
```swift
    private func showLogin() {
        let controller = MyViewController()
        navigate(to: .push(controller))
    }
```
5. Or open other `Coordinator` from `MyCoordinator` as example:
```swift
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        add(loginCoordinator) // add this to store strong reference in MyCoordinator
        loginCoordinator.start(with: .firstState)
    }
```
6. `NavigationCoordinator` automaticaly handles refrences for you. When other coordinator will not contains controllers in navigation stack or presentation stack `LoginCoordinator` will be deinited.

### License

Coordinator is available under the MIT license. See the LICENSE file for more information.

### Contributions

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request on GitHub.

### Credits

The Coordinator library is maintained by lbrdev and contributions from the open-source community. We would like to thank all the contributors for their valuable input.
