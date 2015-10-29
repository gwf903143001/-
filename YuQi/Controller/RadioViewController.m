//
//  RadioViewController.m
//  YuQi
//
//  Created by Conan on 14-12-14.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "RadioViewController.h"
#import "RadioTableViewCell.h"
#import "AudioButton.h"
#import <MediaPlayer/MediaPlayer.h>

#define kCellIdentifier @"AudioCell"

@interface RadioViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    //上一个按钮tag值
    NSInteger _previousTag;
    
    //上一个按钮
    AudioButton *_previousButton;
}

@property (retain,nonatomic)UITableView *radioTableView;

//电台数组
@property (retain,nonatomic)NSArray *itemArray;

//媒体播放控制器
@property (retain,nonatomic)MPMoviePlayerController *mp;

@end

@implementation RadioViewController

-(void)dealloc
{
    NSLog(@"---------电台dealloc------------");
    _previousButton = nil;
    _radioTableView = nil;
    _itemArray = nil;
    _mp = nil;
    
    [_previousButton release];
    [_radioTableView release];
    [_itemArray release];
    [_mp release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //电台tableview初始化
        self.radioTableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    }
    return self;
}

-(void)loadView
{
    self.view = self.radioTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"兮八电台";
    
    //电台数据
    self.itemArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"CRI环球旅游", @"title", @"http://180.150.191.89/live/998.m3u8", @"url", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"青苹果音乐台", @"title", @"http://180.150.191.233/live/4576.m3u8", @"url", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"青檬音乐台", @"title", @"http://180.150.191.233/live/1582.m3u8", @"url", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"亚洲音乐台", @"title", @"http://180.150.191.233/live/4581.m3u8", @"url", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Tiktok网络电台", @"title", @"http://180.150.191.233/live/5062.m3u8", @"url", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"悠米音悦台", @"title", @"http://180.150.191.233/live/2137149.m3u8", @"url", nil], nil];
    
    self.radioTableView.delegate = self;
    self.radioTableView.dataSource = self;
    
    [self.radioTableView registerClass:[RadioTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    //实现第三方导航滚动
    [self followRollingScrollView:self.radioTableView];
}

- (void)playAudio:(AudioButton *)button
{
    
    //此处应用状态机控制播放流程，没有播放，状态为no。
    static BOOL bState = NO;
    
    if(bState){
        
        //同一个按钮，停止播放
        if(_previousTag == button.tag){
            
            [button stopSpin];
            [self.mp stop];
            bState = NO;
            
        }else{
            
            //不是同一个按钮停掉之前，播放选中
            [_previousButton stopSpin];
            [self.mp stop];
            
            [self initMPlayer:button.tag - 101];
            
            [button startSpin];
            [self.mp play];
            bState = YES;
            
        }
        
    }else{
        
        //播放flag为yes，播放
        [self initMPlayer:button.tag - 101];
        
        [button startSpin];
        [self.mp play];
        bState = YES;
    }
    
    //上一个按钮信息
    _previousTag = button.tag;
    _previousButton = button;
    
}

#pragma 初始化电台播放器
- (void)initMPlayer : (NSInteger)index
{
    NSDictionary *item = [self.itemArray objectAtIndex:index];
    
    NSString *radioUrlString = [item objectForKey:@"url"];
    
    //初始化播放器
    self.mp = [[[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:radioUrlString]] autorelease];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RadioTableViewCell *cell = [[[RadioTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier] autorelease];
    
    [cell configurePlayerButton];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Configure the cell..
    NSDictionary *item = [self.itemArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [item objectForKey:@"title"];
    
//    NSString *radioUrlString = [item objectForKey:@"url"];
//    self.mp = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:radioUrlString]];
    
    //给按钮赋tag值
    cell.audioButton.tag = 101 + indexPath.row;
    
    [cell.audioButton addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - Table view delegate

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
