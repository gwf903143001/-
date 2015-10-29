//
//  DetailModel.m
//  语奇cell2
//
//  Created by lanou3g on 14-12-6.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

-(void)dealloc
{
    NSLog(@"--------------文章dealloc----------");

    _post = nil;
    
    [_post release];
    
    [super dealloc];
}

//未使用的值
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
