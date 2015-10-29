//
//  EnterTableViewCell.m
//  XIBA
//
//  Created by lanou3g on 14-12-17.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "EnterTableViewCell.h"
@implementation EnterTableViewCell

-(void)dealloc
{
    NSLog(@"登录tableviewcell dealloc------->");
    _userNameText = nil;
    _mailInfoText = nil;
    
    [_userNameText release];
    [_mailInfoText release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor grayColor];
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{
    
    //用户名文本框
    self.userNameText=[[UITextField alloc]init];
    self.userNameText.frame=CGRectMake(15, 2, 200, 20);
    
    //透明度
    self.userNameText.layer.shadowOpacity=0.5;
    
    //水印提示
    self.userNameText.placeholder = @"昵称";
    
    self.userNameText.font=[UIFont fontWithName:@"Arial" size:14];
    self.userNameText.tag = 102;
        
    //边框
    CALayer *layer1=[self.userNameText layer];
    //边框颜色
    layer1.borderColor=[UIColor blackColor].CGColor;
    //边框粗细
    layer1.borderWidth=0.3f;
    //圆角
    layer1.cornerRadius=5;
    layer1.masksToBounds=YES;
    //响应事件
    self.userNameText.userInteractionEnabled = YES;
    [self addSubview:self.userNameText];
    
    
    self.mailInfoText=[[UITextField alloc]init];
    self.mailInfoText.frame=CGRectMake(CGRectGetMinX(self.userNameText.frame), CGRectGetMaxY(self.userNameText.frame), CGRectGetWidth(self.userNameText.frame), CGRectGetHeight(self.userNameText.frame));
    self.mailInfoText.layer.shadowOpacity=0.5;
    
    self.mailInfoText.placeholder = @"邮箱";
    self.mailInfoText.font=[UIFont fontWithName:@"Arial" size:14];
    self.mailInfoText.tag = 103;
    //边框
    CALayer *layer2=[self.mailInfoText layer];
    layer2.borderColor=[UIColor blackColor].CGColor;
    layer2.borderWidth=0.3f;
    //圆角
    layer2.cornerRadius=5;
    layer2.masksToBounds=YES;
    //响应事件
    self.mailInfoText.userInteractionEnabled = YES;
    [self addSubview:self.mailInfoText];
    
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
