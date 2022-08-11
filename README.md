# ReactNative-Binary

Pre-built React Native xcframeworks to save the time of humans.

Features:

- iOS and Mac Catalyst are both supported with xcframeworks.
- About 1 minute (on M1) is saved for clean build (each CPU/platform target).
- Easy integration without messy Podfile.

Inspired by <https://github.com/traveloka/ios-rn-prebuilt>.

## Get Started

### Installation

#### CocoaPods

```rb
pod 'ReactNative-Binary', configuration: 'Release'
pod 'ReactNative-Binary-Debug', configuration: 'Debug' # loading debug support
```

#### Swift Package

(working in progress)

### Code Snippet

Full example can be found at the [example](https://github.com/imWildCat/ReactNative-Binary/tree/main/example) folder.

```swift
import React
import UIKit

public class ReactNativeBaseVC: UIViewController {
  private enum Constants {
    static let moduleName = "[ModuleName]"
  }

  private lazy var rootView: UIView = RCTAppSetupDefaultRootView(self.bridge, Constants.moduleName, [:])
  private lazy var bridge = RCTBridge(delegate: self, launchOptions: [:])

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    rootView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(rootView)

    NSLayoutConstraint.activate([
      rootView.topAnchor.constraint(equalTo: view.topAnchor),
      rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      rootView.leftAnchor.constraint(equalTo: view.leftAnchor),
      rootView.rightAnchor.constraint(equalTo: view.rightAnchor),
    ])
  }
}

extension ReactNativeBaseVC: RCTBridgeDelegate {
  public func sourceURL(for _: RCTBridge!) -> URL! {
    URL(string: "http://localhost:8081/index.bundle?platform=ios")! // or your local JavaScript bundle file
  }

  public func extraModules(for _: RCTBridge!) -> [RCTBridgeModule]! {
    [
      RCTDevSettings(),
      RCTAsyncLocalStorage(),
      RCTRedBox(),
    ]
  }
}


```
([example/Targets/ReactNativeBinaryExampleUI/Sources/MainViewController.swift](example/Targets/ReactNativeBinaryExampleUI/Sources/MainViewController.swift))

## Development

## Release Plan

We're using release branches `releases/[react_native_version]` to track the official release of React Native.

(working in progress)


## License

MIT
