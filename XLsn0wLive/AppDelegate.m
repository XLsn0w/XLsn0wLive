
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

@end
