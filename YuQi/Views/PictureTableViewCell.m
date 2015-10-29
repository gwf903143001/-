//
//  PictureTableViewCell.m
//  YuQiWaterFlowDemo
//
//  Created by lanou3g on 14-12-15.
//  Copyright (c) 2014年 刘雨奇. All rights reserved.
//

#import "PictureTableViewCell.h"
#import "PictureModel.h"
@implementation PictureTableViewCell

-(void)dealloc
{
    NSLog(@"搞笑图片tableviewcell dealloc------>");
    _pictureImageView = nil;
    _pictureLabel = nil;
    _picture_id = nil;
    
    [_pictureImageView release];
    [_pictureLabel release];
    [_picture_id release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{

    
    //详情标题
    self.pictureLabel = [[[UILabel alloc] init] autorelease];
    self.pictureLabel.frame=CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), 40);
    
    //搞笑图详细标题字体
    self.pictureLabel.font = [UIFont systemFontOfSize:13];
    self.pictureLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.pictureLabel];
    
    //详情图片
    self.pictureImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    self.pictureImageView.frame = CGRectMake(CGRectGetMinX(self.pictureLabel.frame), CGRectGetMaxY(self.pictureLabel.frame), self.bounds.size.width,self.bounds.size.height);
    self.pictureLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.pictureLabel.numberOfLines = 0;
    
    [self addSubview:self.pictureImageView];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
