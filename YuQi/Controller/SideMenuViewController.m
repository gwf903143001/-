//
//  SideMenuViewController.m
//  YuQi
//
//  Created by Conan on 14-12-4.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MenuTableView.h"
#import "MainViewController.h"
//第三方
#import "CircleMenuViewController.h"
#import "Constants.h"
#import "DDMenuController.h"
//应用代理
#import "NICAppDelegate.h"
#import "MenuTableViewCell.h"
#import "VideoViewController.h"
#import "RadioViewController.h"
#import "SetViewController.h"
#import "FilesHandler.h"
//下拉菜单cell
#import "EnterTableViewCell.h"
#import "CollectController.h"

#define MenuCellId @"menuCellId"

@interface SideMenuViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
{
    //应用代理实例变量
    NICAppDelegate *_tempMainDelegate;
}

//菜单tableview
@property (retain,nonatomic) MenuTableView *menuTableView;

//下拉菜单的属性设置
@property(nonatomic,assign)BOOL isOpen;

//选择索引
@property(nonatomic,retain)NSIndexPath *selectIndex;

//扩展tableview
@property(nonatomic,retain)UITableView *expansionTableView;

@end

@implementation SideMenuViewController

-(void)dealloc
{
    NSLog(@"---------菜单控制器dealloc---------");
    _menuTableView = nil;
    _menuArray = nil;
    _expansionTableView = nil;
    
    [_menuTableView release];
    [_menuArray release];
    [_expansionTableView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //用于遮盖状态栏的视图
        UIView *statusBarView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, StatusHeight)] autorelease];
        
        //状态栏颜色，与tableview颜色统一
        statusBarView.backgroundColor = MainCellAndTableViewColor;
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [self.view addSubview:statusBarView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置头标题高度，脚标题高度
    self.expansionTableView.sectionFooterHeight = 0;
    self.expansionTableView.sectionHeaderHeight = 0;
    
    //开启状态初始为no
    self.isOpen = NO;
    
    //菜单列表
    NSArray *arr = @[@"个性签名",
                     @"兮八趣事",
                     @"兮八图库",
                     @"兮八趣视",
                     @"兮八电台",
                     @"收藏",
                     @"设置"];
    
    self.menuArray  = [NSMutableArray arrayWithArray:arr];
    
    //初始化视图
    [self initView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 初始化视图
-(void)initView
{
    
    //初始化tableview
    self.menuTableView = [[[MenuTableView alloc] initWithFrame:CGRectMake(0, StatusHeight, self.view.frame.size.width, self.view.frame.size.height - StatusHeight)] autorelease];
    
    //设置颜色
    self.menuTableView.backgroundColor = MainCellAndTableViewColor;
    
    //不显示多余的行数
    self.menuTableView.tableFooterView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    
    //设置代理
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    
    //设置分割线颜色
    self.menuTableView.separatorColor = MenuTableViewSeparatorColor;
    
    //添加到视图
    [self.view addSubview:self.menuTableView];
    
    //注册cell
    [self.menuTableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:MenuCellId];
    
    //指向应用代理
    _tempMainDelegate = [[UIApplication sharedApplication] delegate];
    
}

#pragma mark 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //下拉开启改变行数
    if (self.isOpen) {
        
        return 8;
    }
    
    return self.menuArray.count;
}

#pragma mark cell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第一行初始化
    if(indexPath.row == 0) {
        
        [[FilesHandler shareWriteFile] userInfoGet];
        
        NSString *userName = @"个性签名";
        
        if(!(_tempMainDelegate.globleUserName == nil)){
            
            userName = _tempMainDelegate.globleUserName;
        }
        
        [self.menuArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@",userName]];
        
    }
    
    //登录开启状态初始化cell
    if(self.isOpen && (indexPath.row == 1)){
        
        EnterTableViewCell *cell=[[[EnterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"] autorelease];
        
        //文本框代理
        cell.userNameText.delegate = self;
        cell.mailInfoText.delegate = self;
        
        cell.backgroundColor = MainCellAndTableViewColor;
        
        //文本框赋值
        cell.userNameText.text = _tempMainDelegate.globleUserName;
        cell.mailInfoText.text = _tempMainDelegate.globleUserMail;
        
        return  cell;
        
    }else{
        
        //初始化cell
        MenuTableViewCell *menuCell = [[[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: MenuCellId] autorelease];
        
        //设置cell颜色与tableview相同
        menuCell.backgroundColor = MainCellAndTableViewColor;
        
        //设置cell文字颜色
        menuCell.textLabel.textColor = MenuCellTextColor;
        
        //选择cell时cell颜色
        menuCell.selectedBackgroundView = [[[UIView alloc] initWithFrame:menuCell.frame] autorelease];
        menuCell.selectedBackgroundView.backgroundColor = SelectedMenuCellColor;
        
        //cell选择样式
        menuCell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        //侧边栏命名
        menuCell.textLabel.text = self.menuArray[indexPath.row];
        
        return menuCell;
    }
}

//return键改变用户信息
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self changeUserInfo];
    
    return YES;
    
}

//将要结束编辑改变用户信息
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{

    [self changeUserInfo];
    
    return YES;
    
}

//完成编辑改变用户信息
-(void)textFieldDidEndEditing :(UITextField *)textField
{
    [self changeUserInfo];
    
}

#pragma mark 写入用户数据
-(void)changeUserInfo
{
    //获得用户名文本框
    UITextField *userNameTextField = (UITextField *)[self.menuTableView viewWithTag:102];
    
    //获得邮箱文本框
    UITextField *mailTextField = (UITextField *)[self.menuTableView viewWithTag:103];
    
    //用户名为空则不写入
    if(![userNameTextField.text isEqualToString:@""]){
        
        //输入信息替换cell标题
        [self.menuArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@",userNameTextField.text]];
        
        NSArray *userInfoArray=@[userNameTextField.text,mailTextField.text];
        
        //写入文件
        [userInfoArray writeToFile:[[FilesHandler shareWriteFile] userInfoPathGet] atomically:YES];
        
    }
    
    //信息录入后关闭下拉
    self.isOpen = NO;
    
    [self.menuTableView reloadData];
}

#pragma mark 菜单选择
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获得菜单控制器
    DDMenuController *menuController = (DDMenuController*)((NICAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    
    NSIndexPath * indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:0];
    
    NSArray * arr = @[indexPathToInsert];
    
    //第一行
    if (indexPath.row == 0) {
        
        //没打开，打开
        if (self.isOpen == NO){
            
            self.isOpen = YES;
            
            //插入行
            [tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationTop];
            [self.expansionTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        }else{
            
            self.isOpen = NO;
            
            //关闭时，删除插入行
            [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationTop];
        }
        
    }else{
        
        if (self.isOpen){
            
            self.isOpen = NO;
            
            [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationTop];
            NSIndexPath * path = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
            
            indexPath = path;
            
        }
        
        if(indexPath.row == 1) {
            
            //主页面控制器为根控制器
            MainViewController *mainController = [[[MainViewController alloc] init] autorelease];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainController];
            
            [menuController setRootController:navigationController animated:YES];
            
        }else if (indexPath.row == 2){
            
#warning 导航控制器释放会有问题
            UINavigationController * navigationController = [UINavigationController alloc];
            
            //图片库分类按钮
            CircleMenuViewController * circleMenuViewController;
            circleMenuViewController = [CircleMenuViewController alloc];
            
            //按钮控制器设为根控制器
            [navigationController initWithRootViewController:circleMenuViewController];
            [navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
            
            //按钮设置
            [circleMenuViewController initWithButtonCount:kKYCCircleMenuButtonsCount
                                                 menuSize:kKYCircleMenuSize
                                               buttonSize:kKYCircleMenuButtonSize
                                    buttonImageNameFormat:kKYICircleMenuButtonImageNameFormat
                                         centerButtonSize:kKYCircleMenuCenterButtonSize
                                    centerButtonImageName:kKYICircleMenuCenterButton
                          centerButtonBackgroundImageName:kKYICircleMenuCenterButtonBackground];
            
            [circleMenuViewController release];
            
            [menuController setRootController:navigationController animated:YES];
            
        }else if (indexPath.row == 3){
            
            //视频控制器为根控制器
            VideoViewController *videoViewController = [[VideoViewController alloc] init];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:videoViewController];
            
            [menuController setRootController:navigationController animated:YES];
            
        }else if (indexPath.row == 4){
            
            //电台控制器
            RadioViewController *radioViewController = [[[RadioViewController alloc] init] autorelease];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:radioViewController];
            
            [menuController setRootController:navigationController animated:YES];
            
        }else if (indexPath.row == 5){
            
            //收藏控制器
            CollectController *collectiongController = [[[CollectController alloc] init] autorelease];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:collectiongController];
            
            [menuController setRootController:navigationController animated:YES];
            
        }else if (indexPath.row == 6){
            
            //设置控制器
            SetViewController *setViewController = [[SetViewController alloc] init];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:setViewController];
            
            [menuController setRootController:navigationController animated:YES];
            
        }
    }
    
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
