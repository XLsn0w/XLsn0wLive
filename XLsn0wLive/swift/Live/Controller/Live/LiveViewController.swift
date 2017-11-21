
import UIKit
import IJKMediaFramework

class LiveViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    var anchorModel : HomeModel!
    var ijkLivePlay : IJKFFMoviePlayerController!
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
        XJAnimationTool.shared.showAnimation(view: self.view)
        

        
         NotificationCenter.default.addObserver(self, selector: #selector(playbackStateDidChange(noti:)), name: Notification.Name.IJKMPMoviePlayerLoadStateDidChange, object: nil)
        self.ijkLivePlay.prepareToPlay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        XJAnimationTool.shared.dismissAnimation({})
        XJAnimationTool.shared.removeCycleTimer()
        
        /* 释放 */
        if	ijkLivePlay != nil {
            ijkLivePlay.pause()
            ijkLivePlay.stop()
            ijkLivePlay.shutdown()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        XJAnimationTool.shared.animationForHeart()
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
        ijkLivePlay = IJKFFMoviePlayerController(contentURL: requestUrl, with: options!)
        
        // 1.设置frame为整个屏幕
        ijkLivePlay.view.frame = view.bounds
        
        // 2.设置适配横竖屏幕(设置四边固定，长度灵活)
        ijkLivePlay.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 3.设置播放视图的缩放模式
        ijkLivePlay.scalingMode = .aspectFill
        
        // 4.设置自动播放
        ijkLivePlay.shouldAutoplay = true
        
        // 5.自动更新子视图的大小
        self.view.autoresizesSubviews = true
        
        self.view.addSubview(self.ijkLivePlay.view)
        ijkLivePlay.view.addSubview(topView)
        topView.frame = ijkLivePlay.view.bounds
        topView.anchors = anchorModel
        topView.backBtn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        
        // 加载不出来时候，关闭从新加载
        XJAnimationTool.shared.myBlock = { [unowned self] () -> () in
            self.backClick()
        }
        
        XJAnimationTool.shared.addCycleTimer()
    }
}

extension LiveViewController {
    @IBAction func backClick() {
       dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func playbackStateDidChange(noti : Notification) {
        
        switch (self.ijkLivePlay.playbackState) {
        case .stopped:
            print("停止")
        case .playing:
            print("正在播放")
            XJAnimationTool.shared.dismissAnimation({
                self.ijkLivePlay.play()
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
