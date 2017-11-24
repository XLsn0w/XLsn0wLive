
import UIKit
import SwiftyJSON

class XJHomeViewModel {
    lazy var homeModelArray : [HomeModel] = [HomeModel]()
}

extension XJHomeViewModel {

    /// 在Model中 处理View数据解析  --> ViewModel
    func loadData(_ finishedCallBack : @escaping() -> ()) {
        SwiftNetworkRequest.requestData(.get, urlString: kApiHomeList) { (result, isSuccess) in
            let jsonDic = JSON(result)
            let dataArray = jsonDic["lives"]
            print(dataArray)

            for dict in dataArray {
                if let dict = dict.1.dictionaryObject {
                    let model = HomeModel(dict: dict)
                    self.homeModelArray.append(model)
                }
            }
            finishedCallBack()
        }
    }
    
}
