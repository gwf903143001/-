//
//  ImageDetailsCollectionViewCell.m
//  动漫图
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "ImageDetailsCollectionViewCell.h"

@implementation ImageDetailsCollectionViewCell

-(void)dealloc
{
    
    NSLog(@"----------图片详细cell dealloc---------");
    _xiBaImageView = nil;
    
    [_xiBaImageView release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self AddAllViews];
    }
    return self;
}

//布局
-(void)AddAllViews
{
    
    self.xiBaImageView = [[[UIImageView alloc] init] autorelease];
    self.xiBaImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    [self.contentView addSubview:self.xiBaImageView];
}

@end
