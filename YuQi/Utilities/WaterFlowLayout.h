//
//  WaterFlowLayout.h
//  YuQiWaterFlowDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 刘雨奇. All rights reserved.
//

#import <Foundation/Foundation.h>

//自定义协议
@protocol WaterFlowDelegate <NSObject>
//根据indexPath得到对应的item的高度
-(CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterFlowLayout : UICollectionViewLayout
//8
//多少列
@property(nonatomic,assign)NSUInteger numberOfColum;
//一个item的size
@property(nonatomic,assign)CGSize itemSize;
//一个分组的内边距
@property(nonatomic,assign)UIEdgeInsets sectionInsets;
//item的间距
@property(nonatomic,assign)CGFloat insertItemSpacing;
//一个代理
@property(nonatomic,weak)id<WaterFlowDelegate> delegate;

@end
