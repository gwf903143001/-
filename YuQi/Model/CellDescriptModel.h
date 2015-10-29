//
//  CellDescriptModel.h
//  语奇Cell
//
//  Created by lanou3g on 14-12-4.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellDescriptModel : NSObject

//题目
@property (nonatomic, copy) NSString *title;

//发布时间
@property (nonatomic, copy) NSString *date;

//评论个数
@property (nonatomic, assign) NSInteger comment_count;

//标题图片
@property (nonatomic, copy) NSString *thumb_s;

//发布者和发布地址
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSDictionary *author;

//
@property (nonatomic, retain) NSDictionary *custom_fields;

//tags
@property (nonatomic, retain) NSArray *tags;


//id
@property (nonatomic, assign) NSInteger id;

//@property (nonatomic, retain) NSDictionary *content;

//评论(图片)(自定义)
//@property (nonatomic, copy) NSString *Comment_CountImageView;

@end
