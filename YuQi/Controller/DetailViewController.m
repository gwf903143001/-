//
//  DetailViewController.m
//  YuQi
//
//  Created by Conan on 14-12-13.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "DetailViewController.h"
#import "CellDescriptModel.h"
#import "DetailModel.h"
#import "ShareWebAnalysis.h"
//第三方读取进度条
#import "MBProgressHUD.h"
#import "NICAppDelegate.h"

//网络解析数据存放数组
#define kDetailArray @"detailArray"

@interface DetailViewController ()<UIWebViewDelegate>

//放文章的webview
@property (nonatomic, retain) UIWebView *detailWebView;

@end

@implementation DetailViewController

-(void)dealloc
{
    NSLog(@"---------文章内容dealloc--------");
    _receivedId = nil;
    _receivedTitle = nil;
    _detailModel = nil;
    _detailWebView = nil;
    
    [_detailWebView stopLoading];
    [_detailWebView removeFromSuperview];
        
    //解决webview缓存问题
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_receivedId release];
    [_receivedTitle release];
    [_detailModel release];
    [_detailWebView release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //初始化webview
        self.detailWebView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)] autorelease];
        
    }
    return self;
}

#pragma mark 添加视图
-(void)loadView
{
    self.view = self.detailWebView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //webview自适应开启
    self.detailWebView.scalesPageToFit = YES;
    
    //设置代理
    self.detailWebView.delegate = self;
    
    //设置观察者
    [[ShareWebAnalysis shareModel] addObserver:self forKeyPath:kDetailArray options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    //实现第三方导航滚动
    [self followRollingScrollView:self.detailWebView];

}

#pragma mark 观察方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:kDetailArray]) {
        
        //用数组存放缺点是容易越界，这里一个元素也用数组因为怕数据更换
        DetailModel *detail = [ShareWebAnalysis shareModel].detailArray[0];
        
        //获得文章内容
        NSString *htmlText = [detail.post valueForKey:@"content"];
        
        NICAppDelegate *tempMainDelegate = [[UIApplication sharedApplication] delegate];
        
        //默认字体大小
        float fontSize = 40.f;
        
        if(tempMainDelegate.globleFontSize != 0){
            
            fontSize = tempMainDelegate.globleFontSize;
        }

        //常用字体：宋体、黑体、微软雅黑、Arial, Helvetica, sans-serif
        //给文章内容添加格式
        NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                              "<head> \n"
                              "<style type=\"text/css\"> \n"
                              "body {font-size: %f; font-family: \"%@\"; color: %@;}\n"
                              "</style> \n"
                              "</head> \n"
                              "<body>%@</body> \n"
                              "</html>", fontSize, @"Arial", @"black", htmlText];
        
        //解析到webview上
        [self.detailWebView loadHTMLString:jsString baseURL:nil];
        
        [[ShareWebAnalysis shareModel] removeObserver:self forKeyPath:kDetailArray];
        
    }
}

#pragma mark webview将要解析执行方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //第三方缓存数据进度条
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.detailWebView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    
    return YES;

}

#pragma mark 完成解析执行方法
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    //第三方缓存数据进度条
    [MBProgressHUD hideHUDForView:self.detailWebView animated:NO];
    
}

#pragma mark 载入错误执行方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //第三方缓存数据进度条
    [MBProgressHUD hideHUDForView:self.detailWebView animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"----------------------------------------------");
    NSLog(@"内存已满");
    NSLog(@"----------------------------------------------");
    
    
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
