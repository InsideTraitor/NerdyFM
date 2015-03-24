//
// RemoteControls.m
// Now Playing Cordova Plugin
//
// Created by François LASSERRE on 12/05/13.
// Copyright 2013 François LASSERRE. All rights reserved.
// MIT Licensed
//

#import "RemoteControls.h"

@implementation RemoteControls

static RemoteControls *remoteControls = nil;

- (void)pluginInitialize
{
    NSLog(@"RemoteControls plugin init.");
}

- (void)receiveRemoteEvent:(UIEvent *)receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        NSString *subtype = @"other";
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                NSLog(@"playpause clicked.");
                subtype = @"playpause";
                break;
                
            case UIEventSubtypeRemoteControlPlay:
                NSLog(@"play clicked.");
                subtype = @"play";
                break;
                
            case UIEventSubtypeRemoteControlPause:
                NSLog(@"nowplaying pause clicked.");
                subtype = @"pause";
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                //[self previousTrack: nil];
                NSLog(@"prev clicked.");
                subtype = @"prevTrack";
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"next clicked.");
                subtype = @"nextTrack";
                //[self nextTrack: nil];
                break;
                
            default:
                break;
        }
        
        NSDictionary *dict = @{@"subtype": subtype};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options: 0 error: nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *jsStatement = [NSString stringWithFormat:@"if(window.remoteControls)remoteControls.receiveRemoteEvent(%@);", jsonString];
        [self.webView stringByEvaluatingJavaScriptFromString:jsStatement];  

    }
}

+(RemoteControls *)remoteControls
{
    //objects using shard instance are responsible for retain/release count
    //retain count must remain 1 to stay in mem
    
    if (!remoteControls)
    {
        remoteControls = [[RemoteControls alloc] init];
    }
    
    return remoteControls;
}


@end