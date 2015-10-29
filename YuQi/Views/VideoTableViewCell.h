//
//  VoidTableViewCell.h
//  VoidDemo
//
//  Created by lanou3g on 14-12-10.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import <UIKit/UIKit.h>
//引入控件类
@class VideoModel;

@interface VideoTableViewCell : UITableViewCell

//将控件类设为属性
@property(nonatomic,retain)VideoModel *videoM;

@property(nonatomic,copy)NSString *vUrl;
@property(nonatomic,copy)NSString *Love;
@property(nonatomic,copy)NSString *Hate;

//设置需要添加的控件
@property(nonatomic,retain)UIView *controllerView;
@property(nonatomic,retain)UILabel *title;            //标题
@property(nonatomic,retain)UILabel *create_time;      //视频创建时间
@property(nonatomic,retain)UILabel *playCount;        //播放次数
@property(nonatomic,retain)UILabel *playCountText;
@property(nonatomic,retain)UIImageView *image_s;  //图片

//无发送功能,只接收数据
@property(nonatomic,retain)UIButton *videolove;        //顶
@property(nonatomic,retain)UIButton *videohate;        //踩

//未实现功能预留接口,已布置位置
@property(nonatomic,retain)UIButton *shareVideo;       //分享
@property(nonatomic,retain)UIButton *collect;          //收藏

//接收数据
-(void)writeCellMessage:(VideoModel *)sender;


@end
