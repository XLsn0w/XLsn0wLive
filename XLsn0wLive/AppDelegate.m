
#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    SwiftLiveNavigationController *liveNavC =  [[SwiftLiveNavigationController alloc] initWithRootViewController:[LiveTabBarController new]];
    self.window.rootViewController = liveNavC;
    return YES;
}

@end
