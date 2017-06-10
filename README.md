# Kerabyte

## Table of Contents

* Getting Started
	* Introduction
	* Requirements
	* Installation
	* Usage
* Documentation
* Versioning
* Maintainers
* License

## Getting Started

### Introduction

This module provides a routing solution for deploying path-oriented iOS 
applications written in Swift. It conforms to the Clean VIPER Architecture in
order to simplify application development.

### Requirements

A minimum deployment target of iOS 10.0 is required to integrate this module.

### Installation

- **Integrate as a sub-project**

	Drag the . xcodeproj file into your workspace.

### Usage

To configure your application, you must register an instance of `KBRouter` with 
a given `KBRoute`.

```swift
import UIKit
import Kerabyte

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
        let router = KBRouter(IndexRoute())

        Kerabyte.register(router)

        return true
    }
}
```

In this scenario, `IndexRoute` subclasses `KBRoute` to act as a wildcard route.

```swift
import Foundation
import Kerabyte

public class IndexRoute: KBRoute {

    public init() {
        super.init(
            nil,
            match: false,
            subRoutes: [
                AboutRoute(),
                PrivacyPolicyRoute(),
                TermsOfUseRoute()
            ])
    }

    public override func generateComponent() -> KBComponent {
        return IndexComponent()
    }

}
```

`IndexComponent` subclasses `KBComponent` to act as the delegate between 
all business logic and the user-facing interface. It supplies a template 
(UIResponder) via the `generateTemplate` function for runtime-based interfaces.

```swift
import Foundation
import Kerabyte

public class IndexComponent: KBComponent {

    public override func generateTemplate() -> UIResponder {
        return IndexTemplate()
    }

    public func onRouteAbout() {
        Kerabyte.dispatch(URL(string: "/about")!)
    }

    public func onRoutePrivacyPolicy() {
        Kerabyte.dispatch(URL(string: "/privacy-policy")!)
    }

    public func onRouteTermsOfUse() {
        Kerabyte.dispatch(URL(string: "/terms-of-use")!)
    }

}
```

The power of templates lies in the ability to delegate logic to their respective
components, which in turn can transition to different routes without 
compromising performance or memory usage.

```swift
import Foundation
import UIKit

public class IndexTemplate: UIViewController {

    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var termsOfUseButton: UIButton!

    @IBAction func onTapPublic(_ sender: UIButton) {
        guard let responder = self.component as? IndexComponent else {
            return
        }

        switch sender {
        case self.aboutButton:
            responder.onRouteAbout()
            break
        case self.privacyPolicyButton:
            responder.onRoutePrivacyPolicy()
            break
        case self.termsOfUseButton:
            responder.onRouteTermsOfUse()
            break
        default:
            break
        }
    }

}
```

An example is included in this repository for convenience.

## Documentation

### Kerabyte

#### Static Functions

* `register(_ router: KBRouter, url: URL)` - Registers a router for path resolution, redirection, etc.
    * Parameter `router`: The router which manages this application.
    * Parameter `url`: The initial URL that should be resolved (defaults to "/").
* `dispatch(_ url: URL)` - Dispatches a route signal for the given url.
    * Parameter `url`: The URL that should be resolved.

### KBRouter

#### Initializers

* `init(_ route: KBRoute, domains: [String])`
    * Parameter `route`: The base route.
    * Parameter `domains`: The domains that should be handled (defaults to []).

### KBRoute

#### Initializers

* `init(_ path: String, match: Bool, subRoutes: [KBRoute])`
    * Parameter `path`: Route path (defaults to nil).
    * Parameter `match`: Specifies the matching scheme (defaults to true).
    * Parameter `subRoutes`: Child routes available under this route (defaults to []).

#### Instance Functions

* `generateComponent() -> KBComponent` - Creates a component object linked to this route.
    * Returns: A `KBComponent` to link with this route.

### KBComponent

#### Instance Functions

* `generateTemplate() -> UIResponder` - Creates an interface object linked to this component.
    * Returns: A `UIResponder` to link with this component.

#### Lifecycle Hooks

* `onInit()` - Post-initialization function to avoid constructor logic.
* `onDestroy()` - Pre-destruction function to cleanup resources.

## Versioning

This module uses [semantic versioning](http://semver.org/). For the versions available, see the [tags on this repository](https://github.com/oscarafuentes/Kerabyte/tags). 

## Maintainers

* **Oscar Fuentes** - *Initial work* - [oscarafuentes](https://github.com/oscarafuentes)
	
## License

This project is licensed under the [MIT License](LICENSE.md)
