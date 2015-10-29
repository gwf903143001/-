//
//  VideoViewController.m
//  YuQi
//
//  Created by Conan on 14-12-13.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "VideoViewController.h"
//引入自定义cell
#import "VideoTableViewCell.h"
//引入自定义类
#import "VideoModel.h"
//引入单例
#import "ShareWebAnalysis.h"
//引入视频控制器
#import "VideoPlayViewController.h"
//第三方刷新
#import "MJRefresh.h"
//分享第三方
#import "UMSocial.h"

//cell的标示
#define kVideoTableViewCell_id @"VideoTableViewCell_id"

//存放视频数据的数组
#define kVideoMessageArray @"videoMessageArray"

#define kNumSections 1

#define kRowHeight 320

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UMSocialUIDelegate>

//视频列表tableview
@property (retain,nonatomic)UITableView *videoTableView;

//定义Model类
@property(nonatomic,retain)VideoModel *videoM;

//将cell设为属性
@property(nonatomic,retain)VideoTableViewCell *videoCell;

@end

@implementation VideoViewController

-(void)dealloc
{
    NSLog(@"-------视频控制器dealloc-------");
    
    _videoCell = nil;
    _videoTableView = nil;
    _videoM = nil;
    
    [_videoCell release];
    [_videoTableView release];
    [_videoM release];

    [[ShareWebAnalysis shareModel] removeObserver:self forKeyPath:kVideoMessageArray];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化视图
    [self initView];
    
    //导航标题
    self.title = @"兮八趣视";
    
    //KVO
    [[ShareWebAnalysis shareModel] addObserver:self forKeyPath:kVideoMessageArray options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    //注册cell
    [self.videoTableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:kVideoTableViewCell_id];
    
    //1. 添加头部控件
    [self.videoTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //头部自动刷新
    [self.videoTableView headerBeginRefreshing];
    
    //2. 添加尾部控件
    [self.videoTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

#pragma mark 上拉刷新方法
-(void)headerRereshing
{
    //有数据刷新
    if([ShareWebAnalysis shareModel].videoMessageArray.count > 0){
        
        [self.videoTableView headerEndRefreshing];
        
    }else{
        
        [[ShareWebAnalysis shareModel] requestVideoData:@"10"];
        
    }
    
}

#pragma mark 下拉刷新方法
-(void)footerRereshing
{
    //初始视频个数为10
    static NSInteger videoNum = 10;
    
    //每次刷新页数加一
    videoNum += 10;
    
    //获取数据
    [[ShareWebAnalysis shareModel] requestVideoData:[NSString stringWithFormat:@"%ld",videoNum]];
    
}

#pragma mark 初始化视图
-(void)initView
{
    //初始化主tableview
    CGRect frame = CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height);
    self.videoTableView = [[[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain] autorelease];
    
    //设置代理
    self.videoTableView.delegate =self;
    self.videoTableView.dataSource = self;
    
    //添加到视图
    [self.view addSubview:self.videoTableView];
    
    //实现第三方导航滚动
    [self followRollingScrollView:self.videoTableView];
}


//KVO响应事件
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kVideoMessageArray]) {
        
        [self.videoTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.videoTableView headerEndRefreshing];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.videoTableView footerEndRefreshing];
        
    }
}

#pragma mark 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kNumSections;
}

#pragma mark 分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ShareWebAnalysis shareModel].videoMessageArray.count;
}

#pragma mark cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoTableViewCell_id forIndexPath:indexPath];
    
    //将数据传到自定义cell中
    [cell writeCellMessage:[ShareWebAnalysis shareModel].videoMessageArray[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma make 返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}

#pragma make 点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VideoPlayViewController *videoVC = [[[VideoPlayViewController alloc]init] autorelease];
    
    //转换动画
    videoVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //给模型赋值
    self.videoM = [ShareWebAnalysis shareModel].videoMessageArray[indexPath.row];
    
    //视频地址
    videoVC.VideoUrl = self.videoM.videouri;
    
    //视频题目
    videoVC.title = self.videoM.text;
    
    //顶(人数)
    videoVC.stringLove = self.videoM.love;
    
    //踩(人数)
    videoVC.stringHate = self.videoM.hate;
    
    //进入模态
    [self presentViewController:videoVC animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //缓存清空
    //    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    //    [urlCache removeAllCachedResponses];
}

@end
