//
//  ParaDefine.h
//  YuQi
//
//  Created by Conan on 14-12-3.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#ifndef YuQi_ParaDefine_h
#define YuQi_ParaDefine_h

//------------系统相关宏定义-------------------------------
//屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define StatusHeight [UIApplication sharedApplication].statusBarFrame.size.height

//---------------主页tableview相关宏定义-------------------
//主cellid
#define MainCellId @"mainCellId"

//导航栏frame
#define NavBarFrame self.navigationController.navigationBar.frame

//主cell和tableView以及导航栏共用颜色
#define MainCellAndTableViewColor [UIColor colorWithWhite:0.312 alpha:1.000]

//主标题文字
#define MainTitle @"兮八趣事"

//主标题颜色
#define MainTitleTextColor [UIColor whiteColor]

//---------------左菜单tableview相关宏定义-------------------
//cell分割线颜色
#define MenuTableViewSeparatorColor [UIColor colorWithWhite:0.243 alpha:1.000]

//菜单cellid
#define MenuCellId @"menuCellId"

//菜单cell文字颜色
#define MenuCellTextColor [UIColor whiteColor]

//选择菜单的cell被选中是cell颜色
#define SelectedMenuCellColor [UIColor colorWithWhite:0.214 alpha:1.000]

//改变字体通知
#define ChangeFont @"changeFont"

//设置版本信息
#define XiBaVersion @"版本1.0"

#endif
