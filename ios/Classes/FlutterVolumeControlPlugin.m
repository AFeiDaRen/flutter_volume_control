#import "FlutterVolumeControlPlugin.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation FlutterVolumeControlPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_volume_control"
            binaryMessenger:[registrar messenger]];
  FlutterVolumeControlPlugin* instance = [[FlutterVolumeControlPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

static UISlider *volumeSlider;

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getVolume" isEqualToString:call.method]) {
      result([NSString stringWithFormat:@"%f",[self getVolume]]);
  } else if ([@"setVolumeLarge" isEqualToString:call.method]) {
     result([NSString stringWithFormat:@"%f",[self setVolumeLarge]]);
  } else if ([@"setVolumeSmall" isEqualToString:call.method]) {
      result([NSString stringWithFormat:@"%f",[self setVolumeSmall]]);
  }
}

- (UISlider*) loadVolumeSlide{
    if(volumeSlider==nil||volumeSlider==NULL||[volumeSlider isEqual:[NSNull null]]){
        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
        for (UIView* newView in volumeView.subviews) {
            if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
                volumeSlider = (UISlider*)newView;
                break;
            }
        }
    }
    return volumeSlider;
}

- (float) getVolume{
    if(volumeSlider==nil||volumeSlider==NULL||[volumeSlider isEqual:[NSNull null]]){
        [self loadVolumeSlide];
    }
    return [volumeSlider value];
}

- (float) setVolumeLarge{
    if(volumeSlider==nil||volumeSlider==NULL||[volumeSlider isEqual:[NSNull null]]){
        [self loadVolumeSlide];
    }
    float newValue=volumeSlider.value+0.1;
    [volumeSlider setValue:newValue];
    return volumeSlider.value;
}

- (float) setVolumeSmall{
    if(volumeSlider==nil||volumeSlider==NULL||[volumeSlider isEqual:[NSNull null]]){
        [self loadVolumeSlide];
    }
    float newValue=volumeSlider.value-0.1;
    [volumeSlider setValue:newValue];
    return volumeSlider.value;
}

@end
