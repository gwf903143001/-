//
//  DataTool.h
//  语奇cell2
//
//  Created by lanou3g on 14-12-5.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义block
typedef void (^DataBlock) (NSData *data);

@interface DataToolHandler : NSObject

/**
 * @brief 网络请求数据类方法
 */
+(void)solveDataFromUrlStrig:(NSString *)urlString dataBlock:(DataBlock)dataBlock;

@end
