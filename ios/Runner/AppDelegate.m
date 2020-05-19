#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
// Added by komnataDeveloper
#import <Flutter/Flutter.h>
// End of Added by komnataDeveloper


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  // added by komnataDeveloper
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

  FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"course.flutter.dev/battery"
                                          binaryMessenger:controller.binaryMessenger];

  __weak typeof(self) weakSelf = self;

  [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    // Note: this method is invoked on the UI thread.

    // COPY PASTE IF BLOCK FOR HANDLING INVOKED METHOD--------------------
    if ([@"getBatteryLevel" isEqualToString:call.method]) {
      int batteryLevel = [weakSelf getBatteryLevel];

      if (batteryLevel == -1) {
        result([FlutterError errorWithCode:@"UNAVAILABLE"
                                  message:@"Battery info unavailable"
                                  details:nil]);
      } else {
        result(@(batteryLevel));
      }
    } else {
      result(FlutterMethodNotImplemented);
    }
    // End of COPY PASTE IF BLOCK FOR HANDLING INVOKED METHOD--------------------
    // TODO
  }];
   // end of added by komnataDeveloper

  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (int)getBatteryLevel {
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}

@end
