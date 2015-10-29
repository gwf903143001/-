//
//  PicListViewController.m
//  XIBA
//
//  Created by Conan on 14-12-17.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "PicListViewController.h"
#import "PictureViewController.h"
//第三方上下拉刷新
#import "MJRefresh.h"
#import "UIView+MJExtension.h"
//图片model类
#import "PictureModel.h"
//图片UICollectionViewCell类
#import "PictureCell.h"
//第三方图片解析
#import "UIImageView+WebCache.h"
//瀑布流方法
#import "WaterFlowLayout.h"
#import "ShareWebAnalysis.h"

#import "SDImageCache.h"

@interface PicListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowDelegate>

@property(nonatomic,retain)UICollectionView *collectionView;

@end

@implementation PicListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.title=@"兮八趣图";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[ShareWebAnalysis shareModel] requestPicturesData];
    
    //KVO
    [[ShareWebAnalysis shareModel] addObserver:self forKeyPath:@"pictureArray" options:(NSKeyValueObservingOptionNew)|(NSKeyValueObservingOptionOld) context:nil];
    
    //瀑布流第三方初始化
    WaterFlowLayout *layout = [[WaterFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(290.0 / 2,0);
    
    layout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.numberOfColum = 2;
    layout.insertItemSpacing = 10;
    layout.delegate = self;
    
    //初始化collectionView
    self.collectionView = [[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout] autorelease];
    
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //加载到视图
    [self.view addSubview:_collectionView];
    
    //注册cell
    [self.collectionView registerClass:[PictureCell class] forCellWithReuseIdentifier:@"cell"];
    
    //1. 添加头部控件
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //头部自动刷新
    [self.collectionView headerBeginRefreshing];
    
    //此方法暂不明白使用方法，保留
    //    [self.newsTableView addHeaderWithCallback:^{ }];
    
    //2. 添加尾部控件
//    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //此方法暂不明白使用方法，保留
    //    [self.newsTableView addFooterWithCallback:^{ }];
    
    //实现第三方导航滚动
    [self followRollingScrollView:self.collectionView];

}

#pragma mark 上拉刷新方法
-(void)headerRereshing
{
    //加判断是否有数据，没有才请求
    if([ShareWebAnalysis shareModel].pictureArray.count > 0){
        
        [self.collectionView headerEndRefreshing];
        
    }else{
        
        [[ShareWebAnalysis shareModel] requestPicturesData];
    }
    
}
#pragma mark 下拉刷新方法
//这么请求有问题，因为请求方式不是增加，而是加上原有增加
//-(void)footerRereshing
//{
//    //初始页为1
//    static NSInteger imageNum = 10;
//    
//    //每次刷新页数加一
//    imageNum += 10;
//    
//    //将页数传进网络解析
//    [[ShareWebAnalysis shareModel] requestPicturesDataPlus:imageNum];
//    
//    // 刷新表格
//    [self.collectionView reloadData];
//    
//    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//    [self.collectionView footerEndRefreshing];
//    
//}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"pictureArray"]){
        
        [self.collectionView reloadData];
        
        [self.collectionView headerEndRefreshing];
        
        [[ShareWebAnalysis shareModel] removeObserver:self forKeyPath:@"pictureArray"];

    }
}

//必须要实现的两个方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [ShareWebAnalysis shareModel].pictureArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //背景图片
    UIImageView *tempIV = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picwaitbackground.jpg"]] autorelease];
    
    [cell setBackgroundView:tempIV];
    
    //从数组中获取对应的模型的数据
    PictureModel *m =[ShareWebAnalysis shareModel].pictureArray[indexPath.row];
    
    //设置图片
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:m.middle_url]];
    
    //图片标题
//    cell.imageName.text = m.description;
    
    //详细页面图片高度
    m.a_height = (320 * (m.large_height)) / m.large_width;
    
    return cell;
}

-(CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PictureModel *m = [ShareWebAnalysis shareModel].pictureArray[indexPath.row];
    
    //计算高度
    CGFloat itemHeight = (([UIScreen mainScreen].bounds.size.width - 30) /2) *m.middle_height /m.middle_width;
    
    return itemHeight;
    
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PictureViewController *pTV = [[PictureViewController alloc]init];
    
    [self.navigationController pushViewController:pTV animated:YES];
    
    //取出选中模型
    PictureModel *m = [ShareWebAnalysis shareModel].pictureArray[indexPath.row];
    
    pTV.model = m;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
