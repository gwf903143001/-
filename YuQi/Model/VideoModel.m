//
//  VoidModel.m
//  VoidDemo
//
//  Created by lanou3g on 14-12-10.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

-(void)dealloc
{
    NSLog(@"--------------视频模型dealloc----------");
    _text = nil;
    _videouri = nil;
    _playcount = nil;
    _created_at = nil;
    _image_small = nil;
    _love= nil;
    _hate = nil;
    _height = nil;
    _width = nil;
    
    [_text release];
    [_videouri release];
    [_playcount release];
    [_created_at release];
    [_image_small release];
    [_love release];
    [_hate release];
    [_height release];
    [_width release];
    
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
