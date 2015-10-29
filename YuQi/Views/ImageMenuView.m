//
//  RootView.m
//  UILesson7
//
//  Created by lanou3g on 14-11-4.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "ImageMenuView.h"
#import "UIImage+ImageDown.h"

@implementation ImageMenuView

-(void)dealloc
{
    NSLog(@"-------动漫大图dealloc------");
    
    _scrollV = nil;
    _imv = nil;
    
    [_scrollV release];
    [_imv release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addAllViews];
        
    }
    return self;
}

#pragma mark 添加视图
-(void)addAllViews
{
    self.imv = [[[UIImageView alloc] init] autorelease];
    self.imv.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    //滚动视图
    self.scrollV = [[[UIScrollView alloc] init]autorelease];
    self.scrollV.frame = [UIScreen mainScreen].bounds;
    
    //内容尺寸
    [self addSubview:self.scrollV];
    
    //没有弹动
    self.scrollV.bounces = NO;
    self.scrollV.contentSize = self.imv.image.size;
    
}

-(void )with:(NSString*)string
{
    __block typeof(self) blockSelf = self;
    
    self.imv.image = [UIImage imageDownWithUtlString:[NSString stringWithFormat:@"http://tupian.nikankan.com%@",string] imageBlock:^(UIImage *img) {
        
                blockSelf.imv.image = img;
        
                //重新给imageView 和 Scrollv赋frame
               blockSelf.imv.frame = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.height * blockSelf.imv.image.size.width )/ blockSelf.imv.image.size.height, [UIScreen mainScreen].bounds.size.height);
                blockSelf.scrollV.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.height * blockSelf.imv.image.size.width / blockSelf.imv.image.size.height, [UIScreen mainScreen].bounds.size.height);
        }];
    
    [self.scrollV addSubview:self.imv];
    
}

@end
