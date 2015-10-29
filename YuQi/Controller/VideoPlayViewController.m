//
//  VideoViewController.m
//  VoidDemo
//
//  Created by lanou3g on 14-12-11.
//  Copyright (c) 2014年 郭冲. All rights reserved.
//

#import "VideoPlayViewController.h"
//引入框架(用于视频播放)
#import <MediaPlayer/MediaPlayer.h>
//引入自定义类
#import "VideoView.h"
//分享第三方
#import "UMSocial.h"
#import "MobClick.h"

@interface VideoPlayViewController ()<UMSocialUIDelegate>

//定义视频视图
@property(nonatomic,retain)VideoView *videoView;

//定义一个播放器控制器属性
@property(nonatomic,retain)MPMoviePlayerController *movie;

@property(nonatomic,assign)BOOL flag;


@end

@implementation VideoPlayViewController

-(void)dealloc
{
    NSLog(@"----------视频播放控制器dealloc--------------");
    _VideoUrl = nil;
    _movie = nil;
    _vm = nil;
    _videoView = nil;
    _stringHate = nil;
    _stringLove = nil;
    
    [_VideoUrl release];
    [_movie release];
    [_vm release];
    [_videoView release];
    [_stringHate release];
    [_stringLove release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //视频视图初始化
        self.videoView = [[[VideoView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
        
        self.videoView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(void)loadView
{
    self.view = self.videoView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //接收数据
    [self playMovie:self.VideoUrl];
    
    self.videoView.titleLabel.text = self.title;
    
    //顶踩按钮标题
    [self.videoView.videoLove setTitle:self.stringLove forState:UIControlStateNormal];
    [self.videoView.videoHate setTitle:self.stringHate forState:UIControlStateNormal];
    
    //结束按钮动作
    [self.videoView.endButon addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    //分享标题
    [self.videoView.shareVideo setTitle:@"分享" forState:UIControlStateNormal];
    
    //顶-点击事件
    [self.videoView.videoLove addTarget:self action:@selector(loveChange:) forControlEvents:UIControlEventTouchUpInside];
    
    //踩-点击事件
    [self.videoView.videoHate addTarget:self action:@selector(hateChange:) forControlEvents:UIControlEventTouchUpInside];
    
    //分享点击事件
    [self.videoView.shareVideo addTarget:self action:@selector(shareVideo:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma make 点击事件
//顶
-(void)loveChange:(UIButton *)sender
{
    if (!self.flag) {
        
        //转换数值类型,并使引用计数加一
        int love = [sender.titleLabel.text intValue] + 1;
        
        //使button接收数值
        sender.titleLabel.text = [[NSNumber numberWithInt:love]  stringValue];
        
        //赋值
        [sender setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        
        //装换状态
        self.flag = YES;
    }
    
}

//踩
-(void)hateChange:(UIButton *)sender
{
    if (!self.flag) {
        
        //转换数值类型,并使引用计数加一
        int hate = [sender.titleLabel.text intValue] + 1;
        
        //使button接收数值
        sender.titleLabel.text = [[NSNumber numberWithInt:hate]  stringValue];
        
        //赋值
        [sender setTitle:sender.titleLabel.text forState:UIControlStateNormal];
        
        self.flag = YES;
    }
    
}


#pragma mark 分享
-(void)shareVideo:(UIButton *)sender
{
    
    [self.movie pause];
    
    [MobClick setLogEnabled:YES];
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
    
    //第三方分享代码
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"537bfc9456240b066602f82b" shareText:self.VideoUrl shareImage:nil  shareToSnsNames:@[UMShareToSina,UMShareToRenren,UMShareToTencent,UMShareToDouban] delegate:self];
    
}

#pragma make 播放器设置
-(void)playMovie:(NSString *)fileName{
    
    NSURL *url = [NSURL URLWithString:fileName];
    
    //初始化视频播放对象
    self.movie = [[[MPMoviePlayerController alloc] initWithContentURL:url] autorelease];
    
    self.movie.view.backgroundColor = [UIColor whiteColor];
    
    [self.movie.view setFrame:self.videoView.view.bounds];
    
    self.movie.controlStyle = MPMovieControlStyleFullscreen;
    
    //视频缩放模式
    self.movie.scalingMode =  MPMovieScalingModeFill;
    
    //视频重复模式
    self.movie.repeatMode = MPMovieRepeatModeNone;
    
    //加到视图
    [self.videoView.view addSubview:self.movie.view];
    
    //播放视频
    [self.movie play];
    
    // 注册一个播放结束的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doFinished)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

#pragma mark --视频播放结束委托
/*
 @method 当视频播放完毕释放对象
 */
//
-(void)doFinished{
    
    //准备播放状态
    [self.movie readyForDisplay];
    
}

#pragma mark 收尾动作
-(void)back:(UIButton *)sender
{
    //停止播放
    [self.movie stop];
    
    //移除通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //移除视图
    [self.movie.view removeFromSuperview];
    
    //指针置空
    self.movie = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    NSLog(@"缓存已满");
    //缓存清空
    //    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    //    [urlCache removeAllCachedResponses];
}

@end
