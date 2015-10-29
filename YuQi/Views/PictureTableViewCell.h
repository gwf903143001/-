//
//  PictureTableViewCell.h
//  YuQiWaterFlowDemo
//
//  Created by lanou3g on 14-12-15.
//  Copyright (c) 2014年 刘雨奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureTableViewCell : UITableViewCell
//详情图片
@property(nonatomic,retain)UIImageView *pictureImageView;
//标题
@property(nonatomic,retain)UILabel *pictureLabel;
//图片id
@property(nonatomic,retain)NSString *picture_id;
@end
