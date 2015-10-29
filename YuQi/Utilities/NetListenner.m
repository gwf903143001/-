//
//  NetListenner.m
//  YuQi
//
//  Created by Conan on 14-12-16.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "NetListenner.h"
#import "Reachability.h"

@interface NetListenner()

-(void)reachabilityChanged:(NSNotification*)note;


@end

@implementation NetListenner

-(void)dealloc
{
    NSLog(@"网络监听dealloc");
    
    [super dealloc];
}

+ (NetListenner *)shareNetListenner
{
    static NetListenner *shareNetListenner = nil;
    static dispatch_once_t tocken;
    
    dispatch_once(&tocken, ^{
        shareNetListenner = [[NetListenner alloc] init];
    });
    
    return shareNetListenner;
}


-(void)netWorkListenHost
{
    
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    //网络监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    BOOL listenStatus = [reach startNotifier];
    
    if(listenStatus){
        NSLog(@"-----------网络监听状态开启--------------");
    }else{
        NSLog(@"-----------网络监听状态异常--------------");
    }
    
}

- (void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        NSLog(@"网络可用");
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络畅通" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //        [alert show];
        //        [alert dismissWithClickedButtonIndex:0 animated:YES];
        //        [alert release];
    }
    else
    {
        NSLog(@"网络不可用");
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"兮八，网络便秘" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        [alert show];
//        [alert dismissWithClickedButtonIndex:0 animated:YES];
//        [alert release];
    }
    
    if([reach isReachableViaWiFi]){
        NSLog(@"WiFi开启状态");
    }else{
        NSLog(@"WiFi关闭状态");
    }
    
    if([reach isReachableViaWWAN]){
        NSLog(@"流量开启状态");
    }else{
        NSLog(@"流量关闭状态");
    }
    
}

@end
