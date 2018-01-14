#import "Umiuni2dPlatformPathPlugin.h"
#import <umiuni2d_platform_path/umiuni2d_platform_path-Swift.h>

@implementation Umiuni2dPlatformPathPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUmiuni2dPlatformPathPlugin registerWithRegistrar:registrar];
}
@end
