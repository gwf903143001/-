//
//  ImageModel.m
//  动漫图
//
//  Created by lanou3g on 14-12-10.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

-(void)dealloc
{
    NSLog(@"--------动漫图模型dealloc--------");
    
    _tag_url = nil;
    _tag_name = nil;
    _pic_url = nil;
    _str_name = nil;
    _pic_url_1 = nil;
    _pic_url_2 = nil;
    
    [_tag_url release];
    [_tag_name release];
    [_pic_url release];
    [_str_name release];
    [_pic_url_1 release];
    [_pic_url_2 release];
    
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
