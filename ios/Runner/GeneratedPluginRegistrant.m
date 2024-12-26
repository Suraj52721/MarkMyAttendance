//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<detect_fake_location/DetectFakeLocationPlugin.h>)
#import <detect_fake_location/DetectFakeLocationPlugin.h>
#else
@import detect_fake_location;
#endif

#if __has_include(<device_uuid/DeviceUuidPlugin.h>)
#import <device_uuid/DeviceUuidPlugin.h>
#else
@import device_uuid;
#endif

#if __has_include(<geolocator_apple/GeolocatorPlugin.h>)
#import <geolocator_apple/GeolocatorPlugin.h>
#else
@import geolocator_apple;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<qr_code_scanner/FlutterQrPlugin.h>)
#import <qr_code_scanner/FlutterQrPlugin.h>
#else
@import qr_code_scanner;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [DetectFakeLocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"DetectFakeLocationPlugin"]];
  [DeviceUuidPlugin registerWithRegistrar:[registry registrarForPlugin:@"DeviceUuidPlugin"]];
  [GeolocatorPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeolocatorPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [FlutterQrPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterQrPlugin"]];
}

@end
