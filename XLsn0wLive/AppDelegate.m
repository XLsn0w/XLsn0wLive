
#import "AppDelegate.h"
#import "LiveNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    LiveNavigationController *liveNavC =  [[LiveNavigationController alloc] initWithRootViewController:[SwiftLiveTabBarController new]];
    self.window.rootViewController = liveNavC;
    return YES;
}
///Objc 中发送消息是用中括号（[]）把接收者和消息括起来，而直到运行时才会把消息与方法实现绑定。
@end


/*
 
 
 - 初始化UIApplication单例对象
 - 初始化AppDelegate对象，并设为UIApplication对象的代理
 - 检查Info.plist设置的xib文件是否有效，如果有则解冻Nib文件并设置outlets，创建显示key window、rootViewController、与rootViewController关联的根view（没有关联则看rootViewController同名的xib），否则launch之后由程序员手动加载。
 - 建立一个主事件循环，其中包含UIApplication的Runloop来开始处理事件。
 
 
 
 
 UIApplication：
 1、通过window管理视图；
 2、发送Runloop封装好的control消息给target；
 3、处理URL，应用图标警告，联网状态，状态栏，远程事件等。
 
 AppDelegate：
 管理UIApplication生命周期和应用的五种状态
 (notRunning/inactive/active/background/suspend)。
 
 Key Window：
 1、显示view；
 2、管理rootViewcontroller生命周期；
 3、发送UIApplication传来的事件消息给view。
 
 
 rootViewController：
 1、管理view（view生命周期；view的数据源/代理；view与superView之间事件响应nextResponder的“备胎”）;
 2、界面跳转与传值；
 3、状态栏，屏幕旋转。
 
 
 view：
 1、通过作为CALayer的代理，管理layer的渲染（顺序大概是先更新约束，再layout再display）和动画（默认layer的属性可动画，view默认禁止，在UIView的block分类方法里才打开动画）。layer是RGBA纹理，通过和mask位图（含alpha属性）关联将合成后的layer纹理填充在像素点内，GPU每1/60秒将计算出的纹理display在像素点中。
 2、布局子控件（屏幕旋转或者子视图布局变动时，view会重新布局）。
 3、事件响应：event和guesture。
 插播控制器生命周期

 
 runloop:
 1、（要让马儿跑）通过do-while死循环让程序持续运行：接收用户输入，调度处理事件时间。
 2、（要让马儿少吃草）通过mach_msg()让runloop没事时进入trap状态，节省CPU资源。
 
 a 主线程的runloop自动创建，子线程的runloop默认不创建（在子线程中调用NSRunLoop *runloop = [NSRunLoop currentRunLoop];
 获取RunLoop对象的时候，就会创建RunLoop）；
 
 b runloop退出的条件：app退出；线程关闭；设置最大时间到期；modeItem为空；
 
 c 同一时间一个runloop只能在一个mode，切换mode只能退出runloop，再重进指定mode（隔离modeItems使之互不干扰）；
 
 d 一个item可以加到不同mode；一个mode被标记到commonModes里（这样runloop不用切换mode）。
 

 // 添加mode
 CFRunLoopAddCommonMode(CFRunLoopRef runloop, CFStringRef modeName);
 类型：
 1. kCFRunLoopDefaultMode: 默认 mode，通常主线程在这个 Mode 下运行。
 2. UITrackingRunLoopMode: 追踪mode，保证Scrollview滑动顺畅不受其他 mode 影响。-->CommonMode 保证滑动Scrollview时候
 3. UIInitializationRunLoopMode: 启动程序后的过渡mode，启动完成后就不再使用。
 4: GSEventReceiveRunLoopMode: Graphic相关事件的mode，通常用不到。
 5: kCFRunLoopCommonModes: 占位mode，作为标记DefaultMode和CommonMode用。

 
 
 
 Runloop本质：mach port和mach_msg()
 
 
 Mach是XNU的内核，进程、线程和虚拟内存等对象通过端口发消息进行通信，Runloop通过mach_msg()函数发送消息，如果没有port 消息，内核会将线程置于等待状态 mach_msg_trap() 。如果有消息，判断消息类型处理事件，并通过modeItem的callback回调(处理事件的具体执行是在DoBlock里还是在回调里目前我还不太明白？？？)。
 
 Runloop有两个关键判断点，一个是通过msg决定Runloop是否等待，一个是通过判断退出条件来决定Runloop是否循环。
 

 
 
 

























*/
