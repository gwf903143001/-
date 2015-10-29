//
//  CircleMenuViewController.m
//  KYCircleMenuDemo
//
//  Created by Kjuly on 7/18/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "CircleMenuViewController.h"
#import "ImageViewController.h"
#import "PicListViewController.h"

@implementation CircleMenuViewController

- (void)dealloc {
    
    NSLog(@"动画按钮菜单dealloc----------------->");
    
    [super dealloc];
    
}

- (id)init {
  if (self = [super init])
      
      //题目
      [self setTitle:@"兮八图库"];
    
  return self;
}

- (void)viewDidLoad {
    
  [super viewDidLoad];
    
  // Modify buttons' style in circle menu
  for (UIButton * button in [self.menu subviews])
      
    [button setAlpha:.95f];
}

- (void)didReceiveMemoryWarning {
    
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - KYCircleMenu Button Action

// Run button action depend on their tags:
//
// TAG:        1       1   2      1   2     1   2     1 2 3     1 2 3
//            \|/       \|/        \|/       \|/       \|/       \|/
// COUNT: 1) --|--  2) --|--   3) --|--  4) --|--  5) --|--  6) --|--
//            /|\       /|\        /|\       /|\       /|\       /|\
// TAG:                             3       3   4     4   5     4 5 6
//
- (void)runButtonActions:(id)sender {
    
  [super runButtonActions:sender];
    
    switch ([sender tag]) {
            
        case 1:
        {
            // Configure new view & push it with custom |pushViewController:| method
            
            //动漫页面控制器
            ImageViewController *animationViewController = [[ImageViewController alloc] init];
            
            [animationViewController setTitle:@"兮八动漫"];
            
            // Use KYCircleMenu's |-pushViewController:| to push vc
            [self pushViewController:animationViewController];
            
            [animationViewController release];
        }
            break;
            
            case 2:
        {
            //搞笑图片页面控制器
            PicListViewController * viewController = [[PicListViewController alloc] init];
            
            [self pushViewController:viewController];
            
            [viewController release];
        }
        
    }
  
}


@end
