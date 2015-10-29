//
//  VideoView.h
//  VoidDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoView : UIView

@property(nonatomic,strong)UIView *view;               //视频播放控件

@property(nonatomic,retain)UIButton *endButon;         //结束按键

@property(nonatomic,retain)UILabel *titleLabel;        //标题

@property(nonatomic,retain)UILabel *labelLove;         //顶-标签
@property(nonatomic,retain)UILabel *labelHate;         //踩-标签

@property(nonatomic,retain)UIButton *videoLove;        //顶
@property(nonatomic,retain)UIButton *videoHate;        //踩

@property(nonatomic,retain)UIButton *shareVideo;       //分享

@end
