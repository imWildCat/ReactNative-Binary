// Copyright © 2022 WildCat.io. All rights reserved.

import React
import UIKit

public class MainViewController: UIViewController {
  private enum Constants {
    static let moduleName = "ExampleApp"
  }

  private lazy var rootView: UIView = RCTAppSetupDefaultRootView(
    self.bridge, Constants.moduleName,
    [
      "name": "initial props from native",
    ]
  )
  private lazy var bridge = RCTBridge(delegate: self, launchOptions: [:])

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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

extension MainViewController: RCTBridgeDelegate {
  public func sourceURL(for _: RCTBridge!) -> URL! {
    let u = Bundle(for: Self.self).url(forResource: "index", withExtension: "jsbundle")
    return u!
  }
}
