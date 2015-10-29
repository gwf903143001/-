//
//  CellDescriptModel.m
//  语奇Cell
//
//  Created by lanou3g on 14-12-4.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "CellDescriptModel.h"

@implementation CellDescriptModel

-(void)dealloc
{
    NSLog(@"--------------文章列表dealloc----------");

    _title = nil;
    _date = nil;
    _thumb_s = nil;
    _name = nil;
    _author = nil;
    _tags = nil;
    _custom_fields = nil;
    
    [_title release];
    [_date release];
    [_thumb_s release];
    [_name release];
    [_author release];
    [_tags release];
    [_custom_fields release];
    
    [super dealloc];
}

//未使用的值
-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
