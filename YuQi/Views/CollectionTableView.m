//
//  CollectionTableView.m
//  YuQi
//
//  Created by Conan on 14-12-16.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "CollectionTableView.h"

@implementation CollectionTableView

-(void)dealloc
{
    NSLog(@"收藏视图dealloc--------->");
    _collectionView = nil;
    
    [_collectionView release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews
{
    
    //1.创建UICollectionViewFlowLayout
    //对cell进行布局控制
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    
    //设置列间距(注意如果给定的间距,无法满足屏幕宽度,设置无效)
    flowLayout.minimumInteritemSpacing = 1;
    
    //设置行间距
    flowLayout.minimumLineSpacing = 1;
    
    //设置大小
    flowLayout.itemSize = CGSizeMake(159, 159);
    
    //设置方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建集合视图
    self.collectionView = [[[UICollectionView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y , self.bounds.size.width, self.bounds.size.height ) collectionViewLayout:flowLayout] autorelease];
    
    //设置背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //添加到view上
    [self addSubview:self.collectionView];
    
}

@end
