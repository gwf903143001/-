//
//  WaterFlowLayout.m
//  YuQiWaterFlowDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 刘雨奇. All rights reserved.
//

#import "WaterFlowLayout.h"

//延展
@interface WaterFlowLayout()
//item的数量
@property(nonatomic,assign)NSUInteger numberOfItems;
//每一列的高度
@property(nonatomic,strong)NSMutableArray *columnHeights;
//每一个item的属性信息(位置,大小等等)
@property(nonatomic,strong)NSMutableArray *itemAttributes;

//方法
//获取高度最大列的索引
-(NSInteger)p_indexForLongestColumn;
//获取高度最小的索引
-(NSInteger)p_indexForShortestColumn;

@end
@implementation WaterFlowLayout

#pragma mark 懒加载
//
-(NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights=[NSMutableArray array];
    }
    return _columnHeights;
}

-(NSMutableArray *)itemAttributes{
    if (!_itemAttributes) {
        self.itemAttributes=[NSMutableArray array];
    }
    return _itemAttributes;
}

//获取最长列的索引
-(NSInteger)p_indexForLongestColumn{
    
    //初始值
    NSInteger longestIndex=0;
    CGFloat longestHeight=0;
    
    for (NSInteger i=0; i<self.numberOfColum; i++) {
        CGFloat currentHeight=[self.columnHeights[i] floatValue];
        if (currentHeight>longestHeight) {
            longestHeight=currentHeight;
            longestIndex=i;
        }
    }
    return longestIndex;
}

//求最短的
-(NSInteger)p_indexForShortestColumn{
    NSInteger shortestIndex=0;
    CGFloat shortestHeight=MAXFLOAT;
    for (NSInteger i=0; i<self.numberOfColum; i++) {
        CGFloat currentHeight=[self.columnHeights[i] floatValue];
        if (currentHeight<shortestHeight) {
            shortestHeight=currentHeight;
            shortestIndex=i;
        }
    }
    return shortestIndex;
}


#pragma mark 重写三个方法

//准备
//精华
-(void)prepareLayout{
    [super prepareLayout];
    //给所有的列高度设置初值
    
    for (int i=0; i<self.numberOfColum; i++) {
        self.columnHeights[i]=@(self.sectionInsets.top);
        
    }
    
    //获取item的总数量
    self.numberOfItems=[self.collectionView numberOfItemsInSection:0];
    //设置所有item的位置
    for (int i=0; i<self.numberOfItems; i++) {
        //找最短列的索引
        NSInteger shortestColumnIndex=[self p_indexForShortestColumn];
        CGFloat shortestColumnHeight=[self.columnHeights[shortestColumnIndex] floatValue];
        
        //计算x,y坐标
        //x坐标
        CGFloat detalX=self.sectionInsets.left+(self.itemSize.width+self.insertItemSpacing)*shortestColumnIndex;
        
        //y坐标
        CGFloat detalY=shortestColumnHeight+self.insertItemSpacing+13;
        
        //indexPath
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:i inSection:0];
        
        //设置属性
        UICollectionViewLayoutAttributes *la=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGFloat itemHeight=0;
        if (_delegate && [_delegate respondsToSelector:@selector(heightForItemAtIndexPath:)]) {
            itemHeight=[_delegate heightForItemAtIndexPath:indexPath];
        }
        la.frame=CGRectMake(detalX, detalY, self.itemSize.width, itemHeight);
        //装入数组
        [self.itemAttributes addObject:la];
        
        //记录当前新高度
        self.columnHeights[shortestColumnIndex]=@(detalY+itemHeight);
        
        
    }
}

//返回collection的尺寸
-(CGSize)collectionViewContentSize{
    //获取高度最大的列的索引
    NSInteger longestColumnIndex=[self p_indexForShortestColumn];
    //获取最大列的值
    CGFloat longestColumnHeight=[self.columnHeights[longestColumnIndex] floatValue];
    //计算:最大高度+bottom
    
    CGSize contentSize=self.collectionView.frame.size;
    contentSize.height=longestColumnHeight+self.sectionInsets.bottom;
    return contentSize;
    
}

//返回所有item的属性

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.itemAttributes;
    
}

@end
