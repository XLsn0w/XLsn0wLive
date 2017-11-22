
import UIKit

class SwiftLiveNavigationController: UINavigationController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = .red
        self.navigationBar.tintColor = .white
 
        let dict:Dictionary = [NSForegroundColorAttributeName : UIColor.white];
        
        self.navigationBar.titleTextAttributes = dict;
        setupPanGes()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension SwiftLiveNavigationController {
    fileprivate  func setupPanGes() {
        guard let systemGes = interactivePopGestureRecognizer else { return }
        guard let gesView = systemGes.view else { return }
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        guard let target = targetObjc.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
}
