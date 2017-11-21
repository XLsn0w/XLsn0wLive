
import UIKit

class HomeModel: NSObject {

    /// 直播视频流
    var stream_addr : String?
    /* 关注人 */
    var online_users : Int = 0
    /* 城市 */
    var city : String? 
    /* 主播 */
    var creator : [String : Any]? {
        didSet {
            guard let creator = creator else { return }
            userInfo = UserModel(Dict: creator)
        }
    }
    
    // 主播信息
    var userInfo : UserModel?
    
    // 自定义构造函数
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}


class UserModel : NSObject {
    
    var nick:String?/// 主播名
    var portrait:String?/// 主播头像
    
    init(Dict: [String : Any]) {
        super.init()
        setValuesForKeys(Dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
