
#import "AppDelegate.h"
#import "LiveNavigationController.h"
#import "CommendViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    LiveNavigationController *salesNav =  [[LiveNavigationController alloc] initWithRootViewController:[CommendViewController new]];
    self.window.rootViewController = salesNav;
    
    return YES;
}

@end
