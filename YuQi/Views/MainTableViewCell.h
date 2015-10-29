//
//  MainTableViewCell.h
//  语奇Cell
//
//  Created by lanou3g on 14-12-4.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell

//发布者和发布地址
@property (nonatomic, retain) UILabel *nameTitleLabel;

//题目
@property (nonatomic, retain) UILabel *titlesLabel;

//发布时间
@property (nonatomic, retain) UILabel *datesLabel;

//评论个数
@property (nonatomic, retain) UILabel *commentCountLabel;

//标题图片
@property (nonatomic, retain) UIImageView *thumbsImageView;

//评论(图片)
@property (nonatomic, retain) UIImageView *commentCountImageView;

@end
