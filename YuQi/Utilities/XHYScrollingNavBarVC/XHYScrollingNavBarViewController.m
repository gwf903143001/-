//
//  XHYScrollingNavBarViewController.m
//  XHYScrollingNavBarViewController
//
//  Created by smm_imac on 14-3-7.
//  Copyright (c) 2014年 XHY. All rights reserved.
//

#import "XHYScrollingNavBarViewController.h"

@interface XHYScrollingNavBarViewController ()<UIGestureRecognizerDelegate>

@property (assign, nonatomic)UIView *scrollView;
@property (retain, nonatomic)UIPanGestureRecognizer *panGesture;
@property (retain, nonatomic)UIView *overLay;
@property (assign, nonatomic)BOOL isHidden;

@end

@implementation XHYScrollingNavBarViewController

-(void)dealloc
{
    _panGesture = nil;
    _overLay = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

//设置跟随滚动的滑动试图
-(void)followRollingScrollView:(UIView *)scrollView
{
    //传过来的视图
    self.scrollView = scrollView;
    
    self.panGesture = [[[UIPanGestureRecognizer alloc] init] autorelease];
    self.panGesture.delegate = self;
    self.panGesture.minimumNumberOfTouches = 1;
    [self.panGesture addTarget:self action:@selector(handlePanGesture:)];
    [self.scrollView addGestureRecognizer:self.panGesture];
    
    //改变导航栏颜色
    self.navigationController.navigationBar.barTintColor = MainCellAndTableViewColor;
    //导航栏文字颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: MainTitleTextColor}];
    /*
    //与导航栏相同大小的视图
    self.overLay = [[[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds] autorelease];
    self.overLay.alpha = 0;
    self.overLay.backgroundColor = MainCellAndTableViewColor;//self.navigationController.navigationBar.barTintColor;
    //视图覆盖导航栏
    [self.navigationController.navigationBar addSubview:self.overLay];
    [self.navigationController.navigationBar bringSubviewToFront:self.overLay];
    */
}

#pragma mark - 兼容其他手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - 手势调用函数
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    //translationinview调查
    CGPoint translation = [panGesture translationInView:[self.scrollView superview]];
    
    //显示
    if (translation.y >= 5) {
        if (self.isHidden) {
            
//            self.overLay.alpha = 0;
            CGRect navBarFrame = NavBarFrame;
            CGRect scrollViewFrame = self.scrollView.frame;
            
            //导航y值加20
            navBarFrame.origin.y = 20;
            //视图y增加44，高减少44
            scrollViewFrame.origin.y += 44;
            scrollViewFrame.size.height -= 44;
            
            [UIView animateWithDuration:0.2 animations:^{
                //用动画回复原位
                NavBarFrame = navBarFrame;
                self.scrollView.frame = scrollViewFrame;
            }];
            //显示状态
            self.isHidden = NO;
        }
    }
    
    //隐藏
    if (translation.y <= -20) {
        if (!self.isHidden) {
            CGRect frame = NavBarFrame;
            CGRect scrollViewFrame = self.scrollView.frame;
            frame.origin.y = -44;
            scrollViewFrame.origin.y -= 44;
            scrollViewFrame.size.height += 44;
            
            [UIView animateWithDuration:0.2 animations:^{
                NavBarFrame = frame;
                self.scrollView.frame = scrollViewFrame;

            } completion:^(BOOL finished) {
//                self.overLay.alpha = 1;
            }];
            self.isHidden = YES;
        }
    }
    
}


-(void)viewDidAppear:(BOOL)animated{
    
//    [self.navigationController.navigationBar bringSubviewToFront:self.overLay];
}

@end
