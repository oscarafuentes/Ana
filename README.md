# Kerabyte

## Table of Contents

* Getting Started
	* Introduction
	* Requirements
	* Installation
	* Usage
* Versioning
* Maintainers
* License

## Getting Started

### Introduction

This module provides a routing solution for deploying path-oriented iOS applications written in Swift.

### Requirements

A minimum deployment target of iOS 10.0 is required to integrate this module.

### Installation

- **Integrate as a sub-project**

	Drag the . xcodeproj file into your workspace.

### Usage

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

## Versioning

This module uses [semantic versioning](http://semver.org/). For the versions available, see the [tags on this repository](https://github.com/oscarafuentes/Kerabyte/tags). 

## Maintainers

* **Oscar Fuentes** - *Initial work* - [oscarafuentes](https://github.com/oscarafuentes)
	
## License

This project is licensed under the [MIT License](LICENSE.md)
