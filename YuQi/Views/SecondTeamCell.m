//
//  secondTableViewCell.m
//  ceshi
//
//  Created by lanou3g on 14-12-20.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import "SecondTeamCell.h"

@implementation SecondTeamCell

-(void)dealloc
{
    NSLog(@"--------------->设置第二组cell，dealloc");

    _memoryLabel = nil;
    
    [_memoryLabel release];
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

-(void)addAllViews
{
    self.textLabel.text = @"清除缓存";
    
    //初始化
    self.memoryLabel = [[[UILabel alloc]init]autorelease];
    //尺寸及位置
    self.memoryLabel.frame = CGRectMake(220, 7, 90, 30);
    
    self.memoryLabel.textColor = [UIColor grayColor];
    
    [self addSubview:self.memoryLabel];
    
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
