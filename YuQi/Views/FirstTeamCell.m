//
//  setTableViewCell.m
//  ceshi
//
//  Created by lanou3g on 14-12-20.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import "FirstTeamCell.h"
#import "NICAppDelegate.h"

@implementation FirstTeamCell

-(void)dealloc
{
    NSLog(@"--------------->设置第一组cell，dealloc");
    _setF = nil;
    
    [_setF release];
    
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
    NICAppDelegate *tempMainDelegate = [[UIApplication sharedApplication] delegate];

    NSArray *array = @[@"小",@"中",@"大"];
    
    self.setF = [[[UISegmentedControl alloc] initWithItems:array] autorelease];
    self.setF.frame = CGRectMake(220, 7, 90, 30);
    
    //全局字体按钮选择索引
    self.setF.selectedSegmentIndex = tempMainDelegate.globleSegSelectIndex;

    [self.contentView addSubview:self.setF];
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
