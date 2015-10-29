//
//  VideoView.m
//  VoidDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import "VideoView.h"

@implementation VideoView

-(void)dealloc
{
    NSLog(@"---------视频视图dealloc-----------");
    _endButon = nil;
    _titleLabel = nil;
    _view = nil;
    _labelLove = nil;
    _labelHate = nil;
    _videoLove = nil;
    _videoHate = nil;
    _shareVideo = nil;
    
    [_endButon release];
    [_titleLabel release];
    [_view release];
    [_labelLove release];
    [_labelHate release];
    [_videoLove release];
    [_videoHate release];
    [_shareVideo release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //添加视图
        [self addviews];
    }
    return self;
}

-(void)addviews{
    
    //自定义view
    self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 200)] autorelease];
    
    //顶-标签
    self.labelLove = [[[UILabel alloc] init] autorelease];
    self.labelLove.frame = CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMaxY(self.view.frame), 50, 40);
    self.labelLove.textColor = [UIColor whiteColor];
    self.labelLove.text = @"顶:";
    
    //顶
    self.videoLove = [UIButton buttonWithType:UIButtonTypeSystem];
    self.videoLove.frame = CGRectMake(CGRectGetMaxX(self.labelLove.frame), CGRectGetMinY(self.labelLove.frame), CGRectGetWidth(self.labelLove.frame)+20, CGRectGetHeight(self.labelLove.frame));
    
    //button文字位置设置
    [self.videoLove setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    //设置字体颜色
    [self.videoLove setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.videoLove.titleLabel.font = [UIFont systemFontOfSize: 18];
    
    //踩-标签
    self.labelHate = [[[UILabel alloc]init]autorelease];
    self.labelHate.frame = CGRectMake(CGRectGetMaxX(self.videoLove.frame), CGRectGetMinY(self.videoLove.frame), CGRectGetWidth(self.labelLove.frame), CGRectGetHeight(self.labelLove.frame));
    self.labelHate.textColor = [UIColor whiteColor];
    self.labelHate.text = @"踩:";
    
    //踩
    self.videoHate = [UIButton buttonWithType:UIButtonTypeSystem];
    self.videoHate.frame = CGRectMake(CGRectGetMaxX(self.labelHate.frame), CGRectGetMinY(self.labelHate.frame), CGRectGetWidth(self.videoLove.frame), CGRectGetHeight(self.videoLove.frame));
    
    //设置字体位置
    [self.videoHate setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    //设置字体颜色
    [self.videoHate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.videoHate.titleLabel.font = [UIFont systemFontOfSize:18];
    
    //分享
    self.shareVideo = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shareVideo.frame = CGRectMake(CGRectGetMaxX(self.videoHate.frame)+30, CGRectGetMinY(self.videoHate.frame), 50, CGRectGetHeight(self.videoHate.frame));
    
    //设置字体颜色
    [self.shareVideo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareVideo.titleLabel.font = [UIFont systemFontOfSize:18];
    
    //返回键
    self.endButon = [UIButton buttonWithType:UIButtonTypeSystem];
    self.endButon.frame = CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMaxY(self.view.frame) + 45, CGRectGetWidth(self.view.frame), 30);
    [self.endButon setTitle:@"兮八,在看点别的~" forState:UIControlStateNormal];
    
    //添加控件
    [self addSubview:self.titleLabel];
    [self addSubview:self.labelLove];
    [self addSubview:self.videoLove];
    [self addSubview:self.labelHate];
    [self addSubview:self.shareVideo];
    [self addSubview:self.videoHate];
    [self addSubview:self.view];
    [self addSubview:self.endButon];
    
}

@end
