
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
