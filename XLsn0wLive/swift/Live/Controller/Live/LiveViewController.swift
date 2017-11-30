
import UIKit
import IJKMediaFramework

class LiveViewController: UIViewController {

    var anchorModel : HomeModel!
    var ijkPlayer : IJKFFMoviePlayerController!
    fileprivate lazy var topView : LiveTopView = LiveTopView.topView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func
        viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.white
        self.topView.isHidden = true
        XLsn0wAnimationKit.shared.showAnimation(view: self.view)
        

        
         NotificationCenter.default.addObserver(self,
                                                selector: #selector(playbackStateDidChange(noti:)),
                                                name: Notification.Name.IJKMPMoviePlayerLoadStateDidChange,
                                                object: nil)
        ijkPlayer.prepareToPlay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        XLsn0wAnimationKit.shared.dismissAnimation({})
        XLsn0wAnimationKit.shared.removeCycleTimer()
        
        /* 释放 */
        if	ijkPlayer != nil {
            ijkPlayer.pause()
            ijkPlayer.stop()
            ijkPlayer.shutdown()
        }
    }

}

extension LiveViewController {
    
    fileprivate func setupUI() {
        self.view.backgroundColor = UIColor.clear
        let requestUrl = URL(string: self.anchorModel.stream_addr ?? "")
        
        // 00设置不报告日志
        //IJKFFMoviePlayerController.setLogReport(false)
        //IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO)
        
        // 01默认选项配置
        let options = IJKFFOptions.byDefault()
        
        // 0.创建播放控制器
        ijkPlayer = IJKFFMoviePlayerController(contentURL: requestUrl, with: options!)
        
        // 1.设置frame为整个屏幕
        ijkPlayer.view.frame = view.bounds
        
        // 2.设置适配横竖屏幕(设置四边固定，长度灵活)
        ijkPlayer.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 3.设置播放视图的缩放模式
        ijkPlayer.scalingMode = .aspectFill
        
        // 4.设置自动播放
        ijkPlayer.shouldAutoplay = true
        
        // 5.自动更新子视图的大小
        self.view.autoresizesSubviews = true
        
        self.view.addSubview(ijkPlayer.view)
        ijkPlayer.view.addSubview(topView)
        topView.frame = ijkPlayer.view.bounds
        topView.anchors = anchorModel
        topView.backBtn.addTarget(self, action: #selector(backClick), for: .touchUpInside)

        // 加载不出来时候，关闭从新加载
        XLsn0wAnimationKit.shared.myBlock = { [unowned self] () -> () in
            self.backClick()
        }
        
        XLsn0wAnimationKit.shared.addCycleTimer()
    }
}

extension LiveViewController {
    
    open func backClick() {
       dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func playbackStateDidChange(noti : Notification) {
        
        switch (self.ijkPlayer.playbackState) {
        case .stopped:
            print("停止")
        case .playing:
            print("正在播放")
            XLsn0wAnimationKit.shared.dismissAnimation({
                self.ijkPlayer.play()///此处必须是self.
                self.topView.isHidden = false
            })
        case .paused:
            print("暂停")
        case .interrupted:
            print("打断")
        case .seekingForward:
            print("快进")
        case .seekingBackward:
            print("快退")
        }
    }
}
