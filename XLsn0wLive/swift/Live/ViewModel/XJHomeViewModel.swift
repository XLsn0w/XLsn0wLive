
import UIKit
import SwiftyJSON

class XJHomeViewModel {
    lazy var anchors : [HomeModel] = [HomeModel]()
}

extension XJHomeViewModel {
    func loadData(_ finishedCallBack : @escaping() -> ()) {
        
        XJNetworkTool.requestData(.get, urlString: kApiHomeList) { (result, isSuccess) in
            let json = JSON(result)
            let dataArray = json["lives"]
            
            for dict in dataArray {
                if let dict = dict.1.dictionaryObject {
                    let model = HomeModel(dict: dict)
                    self.anchors.append(model)
                }
            }
            finishedCallBack()
        }
    }
}
