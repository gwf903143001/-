//
//  NICAppDelegate.m
//  YuQi
//
//  Created by Conan on 14-12-3.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "NICAppDelegate.h"

//主页面控制器
#import "MainViewController.h"

//第三方抽屉
#import "DDMenuController.h"

//抽屉菜单控制器
#import "SideMenuViewController.h"

//网络监听
#import "NetListenner.h"

//分享功能头文件
#import "MobClick.h"
#import "UMSocial.h"

@interface NICAppDelegate()


@end

@implementation NICAppDelegate

-(void)dealloc
{
    NSLog(@"--------应用代理dealloc--------");
    _window = nil;
    _menuController = nil;
    _globleUserName = nil;
    _globleUserMail = nil;
    
    [_globleUserName release];
    [_globleUserMail release];
    [_window release];
    [_menuController release];
    
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //窗体初始化
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    //带抽屉的主视图控制器添加到window上
    self.window.rootViewController = [self addControllers];
    
    //开启网络监听
    [[NetListenner shareNetListenner] netWorkListenHost];
    
    //-------------------------------------------------------------------------------
    //友盟log开启
    [MobClick setLogEnabled:NO];
    //加入友盟统计
    //第一个参数,是在友盟开发平台注册的本App的appid
    //第二个参数,是数据发送机制,枚举值
    //第三个参数,是推广平台,@""默认为app store
    [MobClick startWithAppkey:@"537bfc9456240b066602f82b" reportPolicy:BATCH channelId:@""];
    [MobClick updateOnlineConfig];
    //获取app版本
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"version:%@",version);
    [MobClick setAppVersion:version];
    //-------------------------------------------------------------------------------
    [UMSocialData setAppKey:@"537bfc9456240b066602f82b"];
    //打开新浪微博的SSO开关
    [UMSocialConfig setSupportSinaSSO:YES appRedirectUrl:@"http://sns.whalecloud.com/sina2/callback"];
    //-------------------------------------------------------------------------------

    //窗体背景色为白色
    self.window.backgroundColor = [UIColor whiteColor];
    //窗体可见
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark 返回根数组
- (DDMenuController *)addControllers
{
    
#warning 这里释放控制器会有问题
    //主页面控制器初始化
    MainViewController *mainViewController = [[MainViewController alloc] init];
    
    //主控制器添加到导航控制器
    UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    //第三方抽屉初始化
    DDMenuController *rootController = [[[DDMenuController alloc] initWithRootViewController:navigationController] autorelease];
    
    //暂时存放根控制器
    _menuController = rootController;
    
    //左菜单控制器初始化与添加
    SideMenuViewController *leftMenuController = [[SideMenuViewController alloc] init];
    rootController.leftViewController = leftMenuController;
    
    [mainViewController release];
    
    return rootController;
}


#pragma make 锁定屏幕旋转
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark 应用将要不活跃执行方法
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

#pragma mark应用进入后台执行方法
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

#pragma mark 应用将要进入前台执行方法
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

#pragma mark 应用活跃后执行方法
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //缓存清空
//    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
//    [urlCache removeAllCachedResponses];
}

#pragma mark 应用程序将要终止执行方法
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //缓存清空
//    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
//    [urlCache removeAllCachedResponses];
}

@end
