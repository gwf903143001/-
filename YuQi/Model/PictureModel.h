//
//  PictureModel.h
//  YuQiWaterFlowDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 刘雨奇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject
//图片id
@property(nonatomic,retain)NSString *picture_id;
//图片标题
//@property(nonatomic,retain)NSString *description;
@property(nonatomic,retain)NSString *group_id;
//图片(中)属性
////图片(中)地址
@property(nonatomic,copy)NSString *middle_url;
//图片(中)宽
@property(nonatomic,assign)CGFloat middle_width;
//图片(中)高
@property(nonatomic,assign)CGFloat middle_height;
//
//@property(nonatomic,retain)NSString *picture_image;
//图片(大)地址
@property(nonatomic,copy)NSString *large_url;
//图片(大)宽
@property(nonatomic,assign)CGFloat large_width;
//图片(大)高
@property(nonatomic,assign)CGFloat large_height;
//第二个页面图片高度
@property(nonatomic,assign)CGFloat a_height;
//存储
@property(nonatomic,retain)NSMutableArray *collectionViewModelArray;
//属性传值
//@property(nonatomic,retain)NSMutableArray *pictureArray;
@end
