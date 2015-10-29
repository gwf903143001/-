//
//  ImageMenuViewController.h
//  YuQi
//
//  Created by Conan on 14-12-16.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "XHYScrollingNavBarViewController.h"
@class HMSideMenu;
@interface ImageMenuViewController : XHYScrollingNavBarViewController

@property(nonatomic, retain)NSString *string;
@property (nonatomic, assign) BOOL menuIsVisible;
@property (nonatomic, strong) HMSideMenu *sideMenu;
@property(nonatomic, retain)NSDictionary *collectionImageDict;

@end
