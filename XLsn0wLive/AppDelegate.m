
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
 
 
 
 

 
 
 
 
 
 
 
 
 
*/
