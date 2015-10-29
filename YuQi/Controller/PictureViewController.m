//
//  PictureViewController.m
//  XIBA
//
//  Created by Conan on 14-12-17.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "PictureViewController.h"
#import "PictureTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PictureModel.h"
#import "PictureViewController.h"

@interface PictureViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *tableData;
}
@property (retain,nonatomic)UITableView *picListTableView;

@end

@implementation PictureViewController

-(void)dealloc
{
    NSLog(@"搞笑图大图dealloc---------------->");
    _model = nil;
    _picListTableView = nil;
    
    [_model release];
    [_picListTableView release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.picListTableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
        
        self.title = @"兮八趣图";
    }
    return self;
}

-(void)loadView
{
    self.view = self.picListTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.picListTableView.delegate = self;
    self.picListTableView.dataSource = self;
    
    //去掉分割线
    self.picListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //实现第三方导航滚动
    [self followRollingScrollView:self.picListTableView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cell_id = @"cell_id";
    
    PictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    if (nil == cell) {
        
        cell = [[[PictureTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id] autorelease];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.pictureImageView.image = [UIImage imageNamed:@"picwaitbackground.jpg"];
    
    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.model.large_url]];
    
    cell.pictureImageView.frame = CGRectMake(0, cell.pictureLabel.frame.size.height, 320, self.view.frame.size.width/ self.model.large_width* self.model.large_height);
    
//    cell.pictureLabel.text = self.model.description;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回自适应高度
    return  self.view.frame.size.width/ self.model.large_width* self.model.large_height + 40;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
