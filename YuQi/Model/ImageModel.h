//
//  ImageModel.h
//  动漫图
//
//  Created by lanou3g on 14-12-10.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

//图片2
@property (nonatomic, copy) NSString *tag_url;

//名字2
@property (nonatomic, copy) NSString *tag_name;


//图片1
@property (nonatomic, copy) NSString *pic_url;

//名字1
@property (nonatomic, copy) NSString *str_name;

//id
@property (nonatomic, assign) NSInteger id;

//大图
@property (nonatomic, retain) NSString *pic_url_1;

//小图
@property (nonatomic, retain) NSString *pic_url_2;

@end
