//
//  MainTableView.m
//  YuQi
//
//  Created by Conan on 14-12-4.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "MainTableView.h"

@implementation MainTableView

-(void)dealloc
{
    NSLog(@"---------主视图tableview dealloc-----------");

    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
