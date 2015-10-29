//
//  SetViewController.m
//  XIBA
//
//  Created by Conan on 14-12-21.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "SetViewController.h"
#import "FirstTeamCell.h"
#import "SecondTeamCell.h"
#import "ThirdTeamCell.h"
#import "FilesHandler.h"
#import "NICAppDelegate.h"
#import "MBHUDView.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //字体选择按钮索引
    int _segIndex;
}


//引入view
@property(nonatomic,retain)UITableView *setView;

//分组数组
@property(nonatomic,retain)NSMutableArray *groupArray;

//分组题目数组
@property(nonatomic,retain)NSMutableArray *headArray;

@end

@implementation SetViewController

-(void)dealloc
{
    
    NSLog(@"---------------->设置控制器dealloc");
    _setView = nil;
    _groupArray = nil;
    _headArray = nil;
    
    [_setView release];
    [_groupArray release];
    [_headArray release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //初始化tableview
        self.setView = [[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
        
        //设置分组
        NSArray *firstArray = @[@"设置字体"];
        NSArray *secondArray = @[@"清理缓存"];
        NSArray *thirdlyArray = @[@"检查更新",@"关于兮八",@"版本1.0"];
        
        //加入分组数组
        self.groupArray = [NSMutableArray arrayWithObjects:firstArray,secondArray,thirdlyArray, nil];
        
        //设置表头
        self.headArray = [NSMutableArray arrayWithObjects:@"字体设置",@"缓存清理",@"其它", nil];
    }
    return self;
}

-(void)loadView
{
    self.view = self.setView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //主题目
    self.title = @"设置";
    
    //设置代理
    self.setView.dataSource = self;
    self.setView.delegate = self;
    
    //实现第三方导航滚动
    [self followRollingScrollView:self.setView];
    
    //添加手势
    UILongPressGestureRecognizer *verges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    verges.minimumPressDuration = 2.0;
    [self.setView addGestureRecognizer:verges];
    [verges release];
}

#pragma mark 长按cell动作
-(void)longPressToDo : (UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan){
        
        //手势定位cell索引
        CGPoint point = [gesture locationInView:self.setView];
        NSIndexPath *indexPath = [self.setView indexPathForRowAtPoint:point];
        
        //彩蛋
        if(indexPath.section == 2){
            
            if(indexPath.row == 2){
                
                MBAlertView *destruct = [MBAlertView alertWithBody:@"大地雷,吓你一跳!" cancelTitle:nil cancelBlock:nil];
                
                //给弹窗图片（大地雷）
                destruct.imageView.image = [UIImage imageNamed:@"bome.png"];
                
                [destruct addButtonWithText:@"兮八" type:MBAlertViewItemTypeDestructive block:^{
                    
                    NSLog(@"彩蛋block");
                    
                }];
                
                [destruct addToDisplayQueue];
            }
        }
    }
}

#pragma make 设置字体点击事件
-(void)setFontChoose:(UISegmentedControl *)sender
{
    //全局代理
    NICAppDelegate *tempMainDelegate = [[UIApplication sharedApplication] delegate];
    
    //字体选择
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            tempMainDelegate.globleFontSize = 40.f;
            tempMainDelegate.globleSegSelectIndex = 0;
            
        }
            break;
        case 1:
        {
            tempMainDelegate.globleFontSize = 50.f;
            tempMainDelegate.globleSegSelectIndex = 1;
            
        }
            break;
        case 2:
        {
            tempMainDelegate.globleFontSize = 70.f;
            tempMainDelegate.globleSegSelectIndex = 2;
            
        }
            break;
            
    }
    
}

#pragma make 分组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groupArray[section] count];
}

#pragma make 每组个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupArray.count;
}

#pragma make 分组头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.headArray[section];
}

#pragma make 控制header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

#pragma make 初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        //判断为第一组(字体大小)
        FirstTeamCell *firstCell = [[[FirstTeamCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"firstTeamCell"] autorelease];
        
        firstCell.textLabel.text = self.groupArray[indexPath.section][indexPath.row];
        
        //字体cell点击效果取消
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //点击事件
        [firstCell.setF addTarget:self action:@selector(setFontChoose:) forControlEvents:UIControlEventValueChanged];
        
        return firstCell;
        
    }else if (indexPath.section == 1){
        
        //判断为第二组(内存清理)
        SecondTeamCell *secondCell = [[[SecondTeamCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"secondTeamCell"] autorelease];
        
        //返回缓存大小
        float cacheSize = [[FilesHandler shareWriteFile] folderSizeAtPath];
        
        //给标签显示
        secondCell.memoryLabel.text = [NSString stringWithFormat:@"%.3fM",cacheSize];
        
        return secondCell;
        
    }else{
        
        //判断为第三组(其它)
        ThirdTeamCell *thirdleCell = [[[ThirdTeamCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"thirdTeamCell"] autorelease];
        
        thirdleCell.textLabel.text = self.groupArray[indexPath.section][indexPath.row];
        
        return thirdleCell;
    }
    
}

#pragma make cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //缓存清理
    if(indexPath.section == 1){
        
        if(indexPath.row == 0){
            
            [[FilesHandler shareWriteFile] removeWebCache];
            
            [MBHUDView hudWithBody:@"清理成功" type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
            
            //刷新视图
            [self.setView reloadData];
            
        }
    }
    
    //关于
    if(indexPath.section == 2){
        
        switch (indexPath.row) {
                
            case 0:
            {
                //假版本检测
                MBAlertView *aboutUs = [MBAlertView alertWithBody:@"已是最新版本" cancelTitle:nil cancelBlock:nil];
                
                //关于提示窗size
                aboutUs.size = CGSizeMake(ScreenWidth - 100, ScreenHeight - 400);
                
                [aboutUs addButtonWithText:@"确定" type:MBAlertViewItemTypePositive block:^{
                    
                    NSLog(@"版本block块");
                    
                }];
                
                [aboutUs addToDisplayQueue];

            }
                
                break;
                
            case 1:
            {
                MBAlertView *aboutUs = [MBAlertView alertWithBody:@"兮八,这里啥都有\n\n如有意见请发送至邮箱flylee5940770@163.com" cancelTitle:nil cancelBlock:nil];
                
                //关于提示窗size
                aboutUs.size = CGSizeMake(ScreenWidth - 40, ScreenHeight - 300);
                
                [aboutUs addButtonWithText:@"确定" type:MBAlertViewItemTypePositive block:^{
                    
                    NSLog(@"关于block块");
                    
                }];
                
                [aboutUs addToDisplayQueue];
                
            }
                break;
                
            case 2:
            {
                //版本提示窗
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"别点我，我是打酱油的" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                
                [alert show];
                
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                
                [alert release];
                
            }
                
                break;
        }
    }
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
