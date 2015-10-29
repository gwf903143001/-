//
//  MenuTableView.m
//  YuQi
//
//  Created by Conan on 14-12-5.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "MenuTableView.h"

@implementation MenuTableView

-(void)dealloc
{
    NSLog(@"---------菜单视图tableview dealloc-----------");

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

@end
