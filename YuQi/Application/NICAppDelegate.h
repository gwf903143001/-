//
//  NICAppDelegate.h
//  YuQi
//
//  Created by Conan on 14-12-3.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import <UIKit/UIKit.h>

//第三方菜单
@class DDMenuController;

#pragma mark 应用总代理
@interface NICAppDelegate : UIResponder <UIApplicationDelegate>

//窗体
@property (retain, nonatomic) UIWindow *window;

//菜单控制器
@property (retain,nonatomic)DDMenuController *menuController;

//全局字体
@property (assign,nonatomic)float globleFontSize;

//字体按钮全局控制索引
@property (assign,nonatomic)int globleSegSelectIndex;

//全局用户名
@property (copy,nonatomic)NSString *globleUserName;

//全局用户邮箱
@property (copy,nonatomic)NSString *globleUserMail;

@end
