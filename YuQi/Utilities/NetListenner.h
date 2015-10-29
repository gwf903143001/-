//
//  NetListenner.h
//  YuQi
//
//  Created by Conan on 14-12-16.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetListenner : NSObject

+ (NetListenner *)shareNetListenner;

-(void)netWorkListenHost;

@end
