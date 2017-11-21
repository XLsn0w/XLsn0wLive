//
//  XJTabBarController.swift
//  XJDomainLive
//
//  Created by 李胜兵 on 2016/12/8.
//  Copyright © 2016年 付公司. All rights reserved.
//

import UIKit

class LiveTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(XJLiveListViewController(), imageName: "liveList", title: "swift")
        addChildViewController(CommendViewController(), imageName: "liveList", title: "objc")
    }
}

///添加方法
extension LiveTabBarController {
    fileprivate func addChildViewController(_ childController: UIViewController, imageName : String, title : String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.title = title
        
        let nav = SwiftLiveNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
}
