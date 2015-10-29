//
//  UIImage+ImageDown.h
//  解析图片和添加图片
//
//  Created by lanou3g on 14-11-18.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

typedef void (^ImageBlock)(UIImage *img);

#import <UIKit/UIKit.h>

@interface UIImage (ImageDown)

//获得一个url的字符串(图片)
//block块是用来将解析出来的image进行第二次赋值
+(UIImage *)imageDownWithUtlString:(NSString*)urlString imageBlock:(ImageBlock)ib;

@end
