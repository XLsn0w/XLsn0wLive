
import UIKit

class SwiftLiveTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        objc_addChildViewController(ObjcListViewController(), imageName: "liveList", title: "objc")
        swift_addChildViewController(SwiftListViewController(), imageName: "liveList", title: "swift")
    }
}

/// 添加方法
extension SwiftLiveTabBarController {
    fileprivate func swift_addChildViewController(_ childController: UIViewController, imageName : String, title : String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.title = title
        
        let nav = SwiftLiveNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    
    fileprivate func objc_addChildViewController(_ childController: UIViewController, imageName : String, title : String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.title = title
        
        let nav = LiveNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
}
