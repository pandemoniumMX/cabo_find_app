#include "GeneratedPluginRegistrant.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "GoogleMaps/GoogleMaps.h"
#import "AppDelegate.h"
@import Firebase;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [FIRApp configure];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  
  // Override point for customization after application launch.
  
    
  [GMSServices provideAPIKey:@"AIzaSyDJhdbCYd1IWnHdnLf3bmUY8DA2m0Kr9mQ"];
  [[FBSDKApplicationDelegate sharedInstance] application:application
    didFinishLaunchingWithOptions:launchOptions];
    
if ([UNUserNotificationCenter class] != nil) {
  // iOS 10 or later
  // For iOS 10 display notification (sent via APNS)
  [UNUserNotificationCenter currentNotificationCenter].delegate = self;
  UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
      UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
  [[UNUserNotificationCenter currentNotificationCenter]
      requestAuthorizationWithOptions:authOptions
      completionHandler:^(BOOL granted, NSError * _Nullable error) {
        // ...
      }];
} else {
  // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
  
}

[application registerForRemoteNotifications];
    
  return YES;
  //return [super application:application didFinishLaunchingWithOptions:launchOptions];
    
  
    
}






- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

  BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
    openURL:url
    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
    annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
  ];
  // Add any custom logic here.
  return handled;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

  BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
    openURL:url
    sourceApplication:sourceApplication
    annotation:annotation
  ];
  // Add any custom logic here.
  return handled;
}



@end
