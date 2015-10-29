//
//  MainTableViewCell.m
//  语奇Cell
//
//  Created by lanou3g on 14-12-4.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

-(void)dealloc
{
    NSLog(@"---------主视图tableviewcell dealloc-----------");

    _nameTitleLabel = nil;
    _titlesLabel = nil;
    _datesLabel = nil;
    _commentCountLabel = nil;
    _thumbsImageView = nil;
    _commentCountImageView = nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self addAnyViews];
    }
    return self;
}

//视图布局
-(void)addAnyViews
{

    //标题图片
    self.thumbsImageView = [[[UIImageView alloc] init] autorelease];
//    self.Thumb_sImageView.backgroundColor = [UIColor redColor];
    self.thumbsImageView.frame = CGRectMake(10, 15, 80, 80);
    
    //添加视图
    [self addSubview:self.thumbsImageView];
    
    
    //发布者和发布地址
    self.nameTitleLabel = [[[UILabel alloc] init] autorelease];
//    self.NameAndTitleLabel.backgroundColor = [UIColor greenColor];
    self.nameTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.thumbsImageView.frame) + 20, CGRectGetMinY(self.thumbsImageView.frame), 180, 18);
    //字体颜色
    self.nameTitleLabel.textColor = [UIColor grayColor];
    //字体大小
    self.nameTitleLabel.font = [UIFont boldSystemFontOfSize: 15];
    
    //添加视图
    [self addSubview:self.nameTitleLabel];
    
    
    //题目
    self.titlesLabel = [[[UILabel alloc] init] autorelease];
//    self.TitleLabel.backgroundColor = [UIColor greenColor];
    self.titlesLabel.frame = CGRectMake(CGRectGetMinX(self.nameTitleLabel.frame), CGRectGetMaxY(self.nameTitleLabel.frame) + 5, 180, 40);
    //字体颜色
    self.titlesLabel.textColor = [UIColor redColor];
    //高亮
    self.titlesLabel.highlighted = YES;
    //宽自适应
    self.titlesLabel.adjustsFontSizeToFitWidth = YES;
    //行数
    self.titlesLabel.numberOfLines = 0;
    
    //添加视图
    [self addSubview:self.titlesLabel];
    
    //发布时间
    self.datesLabel = [[[UILabel alloc] init] autorelease];
//    self.DateLabel.backgroundColor = [UIColor greenColor];
    self.datesLabel.frame = CGRectMake(CGRectGetMinX(self.titlesLabel.frame), CGRectGetMaxY(self.titlesLabel.frame) + 8, 100, 18);
    //字体颜色
    self.datesLabel.textColor = [UIColor grayColor];
    //高亮
    self.datesLabel.highlighted = YES;
    //宽自适应
    self.datesLabel.adjustsFontSizeToFitWidth = YES;
    
    [self addSubview:self.datesLabel];
    
    
    //评论(图片)
    self.commentCountImageView = [[[UIImageView alloc] init] autorelease];
//    self.Comment_CountImageView.backgroundColor = [UIColor redColor];
    self.commentCountImageView.frame = CGRectMake(CGRectGetMaxX(self.datesLabel.frame)+50, CGRectGetMinY(self.datesLabel.frame), 20, 18);
    
    [self addSubview:self.commentCountImageView];
    
    
    //评论个数
    self.commentCountLabel = [[[UILabel alloc] init] autorelease];
//    self.Comment_CountLabel.backgroundColor = [UIColor greenColor];
    self.commentCountLabel.frame = CGRectMake(CGRectGetMaxX(self.commentCountImageView.frame)+5, CGRectGetMinY(self.commentCountImageView.frame), 20, 18);
    //字体颜色
    self.commentCountLabel.textColor = [UIColor grayColor];
    //高亮
    self.commentCountLabel.highlighted = YES;
    //宽自适应
    self.commentCountLabel.adjustsFontSizeToFitWidth = YES;
    
    [self addSubview:self.commentCountLabel];
    
}


#pragma mark 系统方法
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
