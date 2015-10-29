//
//  VoidTableViewCell.m
//  VoidDemo
//
//  Created by lanou3g on 14-12-10.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import "VideoTableViewCell.h"
//引入控件类
#import "VideoModel.h"

#import "UIImageView+WebCache.h"

@implementation VideoTableViewCell

-(void)dealloc
{
    NSLog(@"-------------视频cell dealloc------------");
    _videoM = nil;
    _vUrl = nil;
    _Love = nil;
    _Hate = nil;
    _create_time = nil;
    _playCount = nil;
    _playCountText = nil;
    _image_s = nil;
    _controllerView = nil;
    _title = nil;
    _videolove = nil;
    _videohate = nil;
    _shareVideo = nil;
    _collect = nil;
    
    [_videoM release];
    [_vUrl release];
    [_Love release];
    [_Hate release];
    [_create_time release];
    [_playCount release];
    [_playCountText release];
    [_image_s release];
    [_controllerView release];
    [_title release];
    [_videolove release];
    [_videohate release];
    [_shareVideo release];
    [_collect release];
    
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //添加视图
        [self addAllViews];
    }
    return self;
}

//标签赋值
-(void)writeCellMessage:(VideoModel *)sender
{
    self.vUrl = sender.videouri;
    self.title.text = sender.text;
    self.create_time.text = sender.created_at;
    self.playCount.text = sender.playcount;
    
    //此处用第三方网络图片解析
    [self.image_s sd_setImageWithURL:[NSURL URLWithString:sender.image_small]];
    
}

-(void)addAllViews
{
    //显示控件
    self.controllerView = [[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 300)] autorelease];
    //    self.controllerView.backgroundColor = [UIColor whiteColor];
    
    //标题
    self.title = [[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)]autorelease];
    self.title.font = [UIFont systemFontOfSize: 15];
    
    //创建时间
    self.create_time = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.title.frame), CGRectGetMaxY(self.title.frame) + 5, 150, 15)]autorelease];
    self.create_time.font = [UIFont systemFontOfSize: 10];
    
    //播放次数
    self.playCountText = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.create_time.frame),CGRectGetMinY(self.create_time.frame), CGRectGetWidth(self.create_time.frame) / 3, CGRectGetHeight(self.create_time.frame))]autorelease];
    self.playCountText.text = @"播放次数:";
    self.playCountText.font = [UIFont systemFontOfSize: 10];
    
    self.playCount = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.playCountText.frame), CGRectGetMinY(self.playCountText.frame), CGRectGetWidth(self.playCountText.frame) * 2, CGRectGetHeight(self.playCountText.frame))]autorelease];
    self.playCount.font = [UIFont systemFontOfSize: 10];
    
    //将视频添加到的view,初始化并设背景色.
    self.image_s = [[[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.create_time.frame) + 5, 300, 240)]autorelease];
    //    self.image_s.backgroundColor = [UIColor grayColor];
    
    //添加至Cell
    [self.contentView addSubview:self.controllerView];
    [self.controllerView addSubview:self.title];
    [self.controllerView addSubview:self.create_time];
    [self.controllerView addSubview:self.playCount];
    [self.controllerView addSubview:self.playCountText];
    [self.controllerView addSubview:self.image_s];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
