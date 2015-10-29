//
//  RootView.h
//  UILesson7
//
//  Created by lanou3g on 14-11-4.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ImageMenuView : UIView

@property(nonatomic,retain)UIImageView *imv;


//滚动视图
@property(nonatomic,retain)UIScrollView *scrollV;

//接受图片的方法
-(void )with:(NSString*)string;

//分页控制器
//@property(nonatomic,retain)UIPageControl *page;

@end
