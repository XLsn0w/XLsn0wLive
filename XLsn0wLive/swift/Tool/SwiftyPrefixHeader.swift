
import UIKit

let kApiHomeList = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"

// MARK: - 定义一些常量
let kScreenW  = UIScreen.main.bounds.size.width
let kScreenH  = UIScreen.main.bounds.size.height
let kNavBarH : CGFloat = 64
let kTabBarH : CGFloat = 44

// 随即色
let kColorRandom : UIColor = UIColor(red: (CGFloat(arc4random_uniform(255)) / 255.0), green: (CGFloat(arc4random_uniform(255)) / 255.0), blue: (CGFloat(arc4random_uniform(255)) / 255.0), alpha: 1)
