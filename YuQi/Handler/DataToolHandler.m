//
//  DataTool.m
//  语奇cell2
//
//  Created by lanou3g on 14-12-5.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "DataToolHandler.h"

@interface DataToolHandler()


@end

@implementation DataToolHandler

-(void)dealloc
{
    NSLog(@"---------------网络请求dealloc------------");

    [super dealloc];
}

#pragma mark   网络请求数据类方法
+(void)solveDataFromUrlStrig:(NSString *)urlString dataBlock:(DataBlock)dataBlock
{    
    //准备 url
    NSURL *url = [NSURL URLWithString:urlString];
    
    //设置请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //异步请求在主队列
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dataBlock(data);
        
    }];
    
    
}

@end
