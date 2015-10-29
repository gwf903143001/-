//
//  MainViewController.m
//  YuQi
//
//  Created by Conan on 14-12-3.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "MainViewController.h"
//主tableview
#import "MainTableView.h"
//主tableviewcell
#import "MainTableViewCell.h"
//列表模型
#import "CellDescriptModel.h"
//单例网络解析
#import "ShareWebAnalysis.h"
//第三方网络图片解析
#import "UIImageView+WebCache.h"
//第三方上下拉刷新
#import "MJRefresh.h"
#import "UIView+MJExtension.h"
//新闻内容控制器
#import "DetailViewController.h"
//时间格式化工具
#import "TimeHandler.h"

//cell行高
#define kRowHeight 110
//分区个数
#define kNumSection 1
//网络解析后数据存放的数组
#define kCellDesArray @"cellDescriArray"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

//新鲜事列表tableview
@property (assign, nonatomic) MainTableView *newsTableView;

@end

@implementation MainViewController

-(void)dealloc
{
    NSLog(@"------------主控制器dealloc-----------------");
    _newsTableView = nil;
    
    [_newsTableView release];
    
    //移除观察者(最后才能移除,否则没数据)
    [[ShareWebAnalysis shareModel] removeObserver:self forKeyPath:kCellDesArray];
    
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
    // Do any additional setup after loading the view.
    
    //初始化主tableview
    [self initView];
    
    //注册cell
    [self.newsTableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:MainCellId];
    
    //1. 添加头部控件
    [self.newsTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //头部自动刷新
    [self.newsTableView headerBeginRefreshing];
    
    //此方法暂不明白使用方法，保留
//    [self.newsTableView addHeaderWithCallback:^{ }];
    
    //2. 添加尾部控件
    [self.newsTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //此方法暂不明白使用方法，保留
//    [self.newsTableView addFooterWithCallback:^{ }];
    
}

#pragma mark 上拉刷新方法
-(void)headerRereshing
{
    //加判断是否有数据，没有才请求
    if([ShareWebAnalysis shareModel].cellDescriArray.count > 0){
        
        [self.newsTableView headerEndRefreshing];
        
    }else{
        
        [self dataHandle];
    }
    
}

#pragma mark 下拉刷新方法
-(void)footerRereshing
{
    //初始页为1
    static NSInteger pageNum = 1;
    
    //每次刷新页数加一
    pageNum++;
    
    //将页数传进网络解析
    [[ShareWebAnalysis shareModel] descriptionNetAnalysisPlus:[NSString stringWithFormat:@"%ld",pageNum]];
    
}

#pragma mark 初始化主tableview
-(void)initView
{
    //主页标题
    self.title = MainTitle;
    
    //初始化主tableview
    CGRect frame = CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height);
    self.newsTableView = [[[MainTableView alloc] initWithFrame:frame style:UITableViewStylePlain] autorelease];
    
    //设置代理
    self.newsTableView.delegate =self;
    self.newsTableView.dataSource = self;
    
    //添加到视图
    [self.view addSubview:self.newsTableView];
    
    //实现第三方导航滚动
    [self followRollingScrollView:self.newsTableView];
    
}

#pragma mark 数据处理
-(void)dataHandle
{
    //请求列表数据
    [[ShareWebAnalysis shareModel] descriptionNetAnalysis];
    
    //KVO
    [[ShareWebAnalysis shareModel] addObserver:self forKeyPath:kCellDesArray options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

#pragma mark 观察者方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:kCellDesArray]) {
        
        [self.newsTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.newsTableView headerEndRefreshing];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.newsTableView footerEndRefreshing];
        
    }
}

#pragma mark 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}

#pragma mark 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return kNumSection;
}

#pragma mark 每分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [ShareWebAnalysis shareModel].cellDescriArray.count;
    
}

#pragma mark 添加文章控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //文章内容
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    
    //取出选中模型
    CellDescriptModel *model = [ShareWebAnalysis shareModel].cellDescriArray[indexPath.row];
    
    //标题给导航栏标题
    detailViewController.navigationItem.title = model.title;
    
    NSLog(@"----------------------------------------------");
    NSLog(@"文章标题：%@",model.title);
    NSLog(@"----------------------------------------------");

    //页面id
    NSNumber *tempId = [NSNumber numberWithInteger:model.id];
    
    //文章id
    NSString *articleId = [tempId stringValue];
    
    //网络解析获取文章
    [[ShareWebAnalysis shareModel] detailsNetAnalysis:articleId];
    
    //到文章界面
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark 列表cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化cell
    MainTableViewCell *cell = [[[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MainCellId] autorelease];
    
    //赋值给文章模型
    CellDescriptModel *model = [ShareWebAnalysis shareModel].cellDescriArray[indexPath.row];
        
    //文章标题
    cell.titlesLabel.text = model.title;
    
    //文章发布时间
    NSString *timeInternal = [TimeHandler getUTCFormateDate:model.date];
    cell.datesLabel.text = [NSString stringWithFormat:@"发布于%@",timeInternal];
    
    //没有获取评论此功能暂时搁置
    //评论个数
//    cell.commentCountLabel.text = [NSString stringWithFormat:@"%d",model.comment_count];
//    
//    //评论图标
//    cell.commentCountImageView.image = [UIImage imageNamed:@"comment_icon.png"];
    
    //文章来源(保留)
    //    NSString *tagsTitle = [model.tags[0] valueForKey:@"title"];
    
    //发布者
    NSString *publisher = [model.author valueForKey:@"name"];
    cell.nameTitleLabel.text = [NSString stringWithFormat:@"由 %@ 发布",publisher];
    
    //图片地址
    NSString *picString = [model.custom_fields valueForKey:@"thumb_s"][0];
    
    //图片解析第三方方法
    [cell.thumbsImageView sd_setImageWithURL:[NSURL URLWithString:picString]];
    
    //选择Cell格式(无)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark 内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"----------------------------------------------");
    NSLog(@"内存已满");
    NSLog(@"----------------------------------------------");

    //如果内存满，清空
//    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
//    [urlCache removeAllCachedResponses];
}

@end
