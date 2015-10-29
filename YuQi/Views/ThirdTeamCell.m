//
//  thirdleTableViewCell.m
//  ceshi
//
//  Created by lanou3g on 14-12-20.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import "ThirdTeamCell.h"

@implementation ThirdTeamCell

-(void)dealloc
{
    NSLog(@"--------------->设置第三组cell，dealloc");

    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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
