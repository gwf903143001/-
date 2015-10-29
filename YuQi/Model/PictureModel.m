//
//  PictureModel.m
//  YuQiWaterFlowDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 刘雨奇. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel
-(void)dealloc{
    
    NSLog(@"搞笑图片模型dealloc-------->");
#warning xcode6 description这里会有问题，和系统变量重名
    _picture_id = nil;
//    _description = nil;
    _group_id = nil;
    _middle_url = nil;
    _large_url = nil;
    _collectionViewModelArray = nil;
    
    [_picture_id release];
//    [_description release];
    [_group_id release];
    [_middle_url release];
    [_large_url release];
    [_collectionViewModelArray release];
    
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //找不到也不会崩掉
}

-(void)setValue:(id)value forKey:(NSString *)key{
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"width"]) {
        
        self.middle_width=[value floatValue];
        
    }
    if ([key isEqualToString:@"height"]) {
        
        self.middle_height=[value floatValue];
    }
}
@end
