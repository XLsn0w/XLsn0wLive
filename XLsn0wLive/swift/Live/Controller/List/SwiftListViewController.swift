
import UIKit
import MJRefresh
private let kCellID = "kCellID"

class SwiftListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var homeVM : XJHomeViewModel = XJHomeViewModel()
    static var isDirectionUp : Bool = false
    fileprivate var lastOffsetY : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //声明tableView的位置 添加下面代码
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
        }
        setupUI()
        refreshData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SwiftListViewController.isDirectionUp = false
    }
}

extension SwiftListViewController {
    fileprivate func setupUI() {
        
        tableView.register(UINib(nibName: "XJListTableViewCell", bundle: nil), forCellReuseIdentifier: kCellID)
        XLsn0wAnimationKit.shared.showAnimation(view: self.view)
    }
}

extension SwiftListViewController {
    
    fileprivate func refreshData() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadHomeData))
        tableView.mj_header.beginRefreshing()
    }
    
    
    @objc fileprivate func loadHomeData() {
        homeVM.loadData {
            XLsn0wAnimationKit.shared.dismissAnimation({
                self.tableView.mj_header.endRefreshing()
                self.tableView.reloadData()
            })
        }
    }
}

extension SwiftListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  homeVM.homeModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellID, for: indexPath) as! XJListTableViewCell
        cell.anchorModel = homeVM.homeModelArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85 + UIScreen.main.bounds.width
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.removeAllAnimations()
        cell.layer.transform = CATransform3DMakeScale(0.3, 0.3, 1)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }, completion: { (_) in
            let anim = CATransition()
            anim.type = "rippleEffect"
            anim.duration = 1
            cell.layer.add(anim, forKey: "11")
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = homeVM.homeModelArray[indexPath.row]
        DispatchQueue.main.async {
            let vc = LiveViewController()
            vc.anchorModel = model
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension SwiftListViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        SwiftListViewController.isDirectionUp = (lastOffsetY - currentOffsetY) < 0 ? true : false
        lastOffsetY = currentOffsetY
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            SwiftListViewController.isDirectionUp = true
        }else if velocity.y < 0 {
            SwiftListViewController.isDirectionUp = false
        }
        beginAnim()
    }
    
    fileprivate func beginAnim() {
        if SwiftListViewController.isDirectionUp {
            hiddenTopViewAnim()
        }else {
            showTopViewAnim()
        }
    }
    
    fileprivate func hiddenTopViewAnim() {
        UIView.animate(withDuration: 2.5, animations: {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }, completion: { (_) in
            self.tableView.mj_header.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        })
    }
    
    fileprivate func showTopViewAnim() {
        UIView.animate(withDuration: 2.5, animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }, completion: { (_) in
            self.tabBarController?.tabBar.isHidden = true
            self.tableView.mj_header.isHidden = false
        })
    }
}


