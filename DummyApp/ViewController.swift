// 

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    Task {
      print("foo")
      
      let bar = await backgroundReturn()
      
      print(bar)
    }
  }


  func backgroundReturn() async -> Int {
    await withCheckedContinuation { continuation in
      DispatchQueue.global(qos: .background).async {
        continuation.resume(returning: 23)
      }
    }
  }
}

