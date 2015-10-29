//
//  MenuTableViewCell.m
//  YuQi
//
//  Created by Conan on 14-12-10.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

-(void)dealloc
{
    NSLog(@"---------菜单视图tableviewcell dealloc-----------");

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
