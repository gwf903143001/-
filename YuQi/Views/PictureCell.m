//
//  PictureCell.m
//  YuQiWaterFlowDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 刘雨奇. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell
-(void)dealloc{
    
    NSLog(@"搞笑图片cell dealloc---------->");
    _imageName = nil;
    _imageView = nil;
    
    [_imageName release];
    [_imageView release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{
    
    self.imageName = [[[UILabel alloc] init] autorelease];
    self.imageName.backgroundColor = [UIColor whiteColor];
    self.imageName.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 13);

    self.imageName.font = [UIFont systemFontOfSize: 13];
    [self addSubview:_imageName];
    
    self.imageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    self.backgroundColor = [UIColor blackColor];
    
    //添加边框
    CALayer *layer = [self.imageView layer];
    layer.borderColor = [[UIColor grayColor]CGColor];
    layer.borderWidth = 1.0f;
    
    //添加四个边阴影
    //阴影颜色
    self.imageView.layer.shadowColor = [UIColor grayColor].CGColor;
    //偏移距离
    self.imageView.layer.shadowOffset = CGSizeMake(4, -4);
    //不透明度
    self.imageView.layer.shadowOpacity = 0.9;
    //半径
    self.imageView.layer.shadowRadius = 3.0;
    
    [self addSubview:_imageView];

}

-(void)layoutSubviews{
    self.imageView.frame = self.bounds;
    self.imageName.frame = CGRectMake(CGRectGetMinX(self.imageView.frame),CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.imageView.frame), 13);
}

@end
