//
//  VideoViewController.h
//  VoidDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoModel;

@interface VideoPlayViewController : UIViewController
//接收到的视频地址
@property(nonatomic,copy)NSString *VideoUrl;
//视频题目
@property(nonatomic,copy)NSString *title;
//顶(button)
@property(nonatomic,copy)NSString *stringLove;
//踩(button)
@property(nonatomic,copy)NSString *stringHate;
//数据模型
@property(nonatomic,retain)VideoModel *vm;


@end
