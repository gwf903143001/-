//
//  UIImage+ImageDown.m
//  解析图片和添加图片
//
//  Created by lanou3g on 14-11-18.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "UIImage+ImageDown.h"

@implementation UIImage (ImageDown)

-(void)dealloc
{
//    NSLog(@"网络图片解析类目dealloc------->");
    
    [super dealloc];
}

//实现这个方法
+(UIImage *)imageDownWithUtlString:(NSString*)urlString imageBlock:(ImageBlock)ib
{

    //使用传进来的url字符串转成NSURL
    NSURL *url = [NSURL URLWithString:urlString];
    
    //准备请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //建立连接(get异步请求数据)
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //解析图片,使用解析好的data转换image
        UIImage *image = [UIImage imageWithData:data];
        
        //第二次赋值是调用block,并将解析好的image座位参数传入
        ib(image);
    }];
    
    //因为异步请求线程慢于主线程,提前返回在一个站位图片
    return [UIImage imageNamed:@"animabackground.jpg"];

}
@end
