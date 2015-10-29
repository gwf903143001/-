//
//  ImageCollectionCell.m
//  动漫图
//
//  Created by lanou3g on 14-12-10.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "ImageCollectionCell.h"


@implementation ImageCollectionCell

-(void)dealloc
{
    NSLog(@"--------图片collectioncell dealloc-----------");
    
    _xiBaImageView = nil;
    _xiBaLabel = nil;
    
    [_xiBaImageView release];
    [_xiBaLabel release];
    
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
    
    self.xiBaLabel = [[[UILabel alloc] init] autorelease];
    self.xiBaLabel.frame = CGRectMake(15, CGRectGetMaxY(self.xiBaImageView.frame) - self.contentView.bounds.size.height * 0.2 , self.contentView.bounds.size.width, self.contentView.bounds.size.height*0.2);
    self.xiBaLabel.backgroundColor = [UIColor blackColor];
    self.xiBaLabel.textColor = [UIColor whiteColor];
    self.xiBaLabel.alpha = 0.6;
    
    //边框
    self.xiBaLabel.clipsToBounds = YES;
    self.xiBaLabel.layer.cornerRadius = 30;
    self.contentView.layer.cornerRadius = 50;
    
    //圆角
    //剪切
    self.contentView.clipsToBounds = YES;
    [self.contentView addSubview:self.xiBaLabel];
    
}

@end
