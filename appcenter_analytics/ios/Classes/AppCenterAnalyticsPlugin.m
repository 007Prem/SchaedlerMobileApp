#import "AppCenterAnalyticsPlugin.h"
#if __has_include(<appcenter_analytics/appcenter_analytics-Swift.h>)
#import <appcenter_analytics/appcenter_analytics-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "appcenter_analytics-Swift.h"
#endif

@implementation AppCenterAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppCenterAnalyticsPlugin registerWithRegistrar:registrar];
}
@end
