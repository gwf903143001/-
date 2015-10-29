//
//  ImageMenuViewController.m
//  YuQi
//
//  Created by Conan on 14-12-16.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "ImageMenuViewController.h"
#import "ImageMenuView.h"
#import "ImageDetailsViewController.h"
#import "SDImageCache.h"
#import "MBHUDView.h"
#import "FilesHandler.h"
#import "ShareWebAnalysis.h"
#import "HMSideMenu.h"

@interface ImageMenuViewController ()<UIScrollViewDelegate>

@property(nonatomic,retain)ImageMenuView *rv;

@end

@implementation ImageMenuViewController

-(void)dealloc
{
    NSLog(@"---------动画菜单dealloc----------");
    
    _string = nil;
    _sideMenu = nil;
    _rv = nil;
    _collectionImageDict = nil;
    
    [_string release];
    [_sideMenu release];
    [_rv release];
    [_collectionImageDict release];
    
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        self.rv = [[[ImageMenuView alloc] initWithFrame:[UIScreen mainScreen].bounds]autorelease];
        
        self.title = @"兮八动漫";
        
    }
    return self;
}

-(void)loadView
{
    self.view = self.rv;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    tap.numberOfTapsRequired = 1;
    [self.rv addGestureRecognizer:tap];
    
    //收藏按钮
    UIButton *collectionButtion = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)] autorelease];
    UIImageView *collectionView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)] autorelease];
    [collectionView setImage:[UIImage imageNamed:@"KYICircleMenuCenterButton"]];
    [collectionButtion addSubview:collectionView];
    [collectionButtion addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    
    //下载按钮
    UIButton *downloadButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)] autorelease];
    UIImageView *downloadIcon = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)] autorelease];
    [downloadIcon setImage:[UIImage imageNamed:@"download"]];
    [downloadButton addSubview:downloadIcon];
    [downloadButton addTarget:self action:@selector(imageDownloadAction) forControlEvents:UIControlEventTouchUpInside];
    
    //保留菜单按钮
/*
    UIView *facebookItem = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)] autorelease];
    [facebookItem setMenuActionWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Tapped facebook item"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil, nil];
        [alertView show];

    }];
    UIImageView *facebookIcon = [[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)] autorelease];
    [facebookIcon setImage:[UIImage imageNamed:@"facebook"]];
    [facebookItem addSubview:facebookIcon];

    UIView *browserItem = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)] autorelease];
    [browserItem setMenuActionWithBlock:^{
        NSLog(@"tapped browser item");
    }];
    UIImageView *browserIcon = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)] autorelease];
    [browserIcon setImage:[UIImage imageNamed:@"browser"]];
    [browserItem addSubview:browserIcon];

    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction)];
    self.navigationItem.leftBarButtonItem = button;
    */
    
    //自定义返回按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"detailback.png"]];
    button.frame = CGRectMake(10, 15, 28, 18);
    button.imageView.image = [UIImage imageNamed:@"detailback.png"];
    [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rv addSubview:button];
    
    //第三方菜单
    self.sideMenu = [[[HMSideMenu alloc] initWithItems:@[collectionButtion,downloadButton]] autorelease];
    [self.sideMenu setItemSpacing:5.0f];
    [self.rv addSubview:self.sideMenu];
    
    //scrollV的设置代理
    self.rv.scrollV.delegate = self;
    
    //调用方法(赋值)载入图片
    [self.rv with:self.string];
    
    //    static dispatch_once_t onceTaken;
    //    dispatch_once(&onceTaken, ^{
    
    //实现第三方导航滚动
    //    [self followRollingScrollView:self.rv];
    
    //naviation 隐藏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //隐藏状态栏
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    //    });
    
}

#pragma mark 保存图片按钮动作
-(void)imageDownloadAction
{
    //此处有问题，图片未完成加载保存图片为占位图片
    UIImageWriteToSavedPhotosAlbum(_rv.imv.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

//是否保存成功
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (!error) {
        
        //没有问题保存成功
        //提示窗
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        [alert release];
        
    }else{
        
        //提示窗
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存失败" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        [alert release];
    
    }
}

#pragma mark 收藏按钮动作
-(void)collectionAction
{
    //判断是否为空和是否已经收藏
    if((self.collectionImageDict != nil) && (![[FilesHandler shareWriteFile] isHadImage:self.collectionImageDict])){
        
        //提示窗
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        [alert release];
        
        [[FilesHandler shareWriteFile] wirteToCollectFile:self.collectionImageDict];
        
    }else{
        
        //提示窗
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已添加到收藏" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        [alert release];
        
    }
    
}

#pragma mark 返回按钮（处理内存）
-(void)backButtonAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //navigationController 隐藏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.rv.imv.image = nil;
    [_rv.imv.image release];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gestureAction:(UIGuidedAccessRestrictionState *)sender
{
    //第三方菜单
    if (self.sideMenu.isOpen){
        
        [self.sideMenu close];
        
    }else{
        
        [self.sideMenu open];
        
    }
}

@end
