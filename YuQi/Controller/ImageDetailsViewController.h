//
//  ImageDetailsViewController.h
//  YuQi
//
//  Created by Conan on 14-12-16.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "XHYScrollingNavBarViewController.h"

@class ImageModel;
@interface ImageDetailsViewController : XHYScrollingNavBarViewController

@property (nonatomic, retain) ImageModel *imageM;

@property (nonatomic, assign) NSInteger detailsId;

@end
