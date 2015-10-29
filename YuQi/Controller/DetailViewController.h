//
//  DetailViewController.h
//  YuQi
//
//  Created by Conan on 14-12-13.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "XHYScrollingNavBarViewController.h"

@class CellDescriptModel;
@class DetailModel;

@interface DetailViewController : XHYScrollingNavBarViewController

//接收的id
@property(nonatomic,copy)NSNumber *receivedId;

//接收的标题
@property(nonatomic,copy)NSString *receivedTitle;

@property(nonatomic,strong)DetailModel *detailModel;

@end
