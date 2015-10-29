//
//  collectionController.m
//  XIBA
//
//  Created by Conan on 14-12-19.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "CollectController.h"

//第三方进度条
#import "MBHUDView.h"

#import "collectionTableView.h"
#import "ImageDetailsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "FilesHandler.h"
#import "ImageMenuViewController.h"
#import "ImageModel.h"

//cell标识
#define kImageDrtailsCollectionCell @"ImageDrtailsCollectionCell"
#define kxiBaImageDetailsArray @"xiBaImageDetailsArray"

@interface CollectController ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,UIActionSheetDelegate>
{
    //删除索引
    NSInteger _deleIndex;
    
    //删除按钮状态
    BOOL _deleButtonState;
}

@property (nonatomic, retain)CollectionTableView *tableView;

@end


@implementation CollectController

-(void)dealloc
{
    NSLog(@"收藏控制器dealloc----------------->");
    _tableView = nil;
    
    [_tableView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.tableView = [[[CollectionTableView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
        self.title = @"收藏";
    }
    return self;
}

-(void)loadView
{
    
    self.view = self.tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //判断收藏是否为空
    if([[FilesHandler shareWriteFile] imageCollectionGet].count == 0){
        
        //提示窗
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"什么也没有" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        [alert release];

    }
    
    //滑动导航
    [self followRollingScrollView:self.tableView];
    
    //删除Button
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //取消TableView 的分割线
    self.tableView.separatorStyle = NO;
    
    //设置代理
    self.tableView.collectionView.dataSource = self;
    self.tableView.collectionView.delegate = self;
    
    
    //注册cell(改为自己的Cell)
    [self.tableView.collectionView registerClass:[ImageDetailsCollectionViewCell class] forCellWithReuseIdentifier:kImageDrtailsCollectionCell];
    
}

//每个分组有多少个Cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [[FilesHandler shareWriteFile] imageCollectionGet].count;
    
}

//返回Cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建cell(改变为自己的cell)
    ImageDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageDrtailsCollectionCell forIndexPath:indexPath];
    
    //获取图片字典
    NSDictionary *image2Dict = [[FilesHandler shareWriteFile] imageCollectionGet][indexPath.row];
    
    //将图片地址
    NSString *collectImageUrl = [NSString stringWithFormat:@"http://tupian.nikankan.com%@",[image2Dict objectForKey:@"pic2"]];

    //图片赋值
    [cell.xiBaImageView sd_setImageWithURL:[NSURL URLWithString:collectImageUrl]];
    
    //添加删除手势（保留）
//    UILongPressGestureRecognizer *deleGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)];
//    
//    deleGes.minimumPressDuration = 1.f;
//    
//    [cell addGestureRecognizer:deleGes];
    
    return cell;
}

//手势删除
//- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)gesture
//{
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        
//        CGPoint point = [gesture locationInView:self.tableView.collectionView];
//        
//        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
//        
//        _deleIndex = indexPath.row;
//        
//        NSLog(@"删除索引%d-------------->",_deleIndex);
//        
//        UIActionSheet *deleSheet = [[UIActionSheet alloc] initWithTitle:@"确定要删除此收藏?" delegate:self cancelButtonTitle:@"取消删除" destructiveButtonTitle:@"确定删除" otherButtonTitles:nil, nil];
//        
//        [deleSheet showInView:self.tableView];
//
//    }
//    
//}

//删除按钮动作
-(void)deleButtonAction : (UIButton *)sender
{
    //删除状态
    _deleButtonState = (!_deleButtonState);
    
    if(_deleButtonState){
        
        //提示窗
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除状态开启" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        [alert release];

    }else{
        
        //提示窗
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除状态关闭" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        [alert release];

    }
    
}

//删除动作
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        
        [[FilesHandler shareWriteFile] deleteImage:_deleIndex];
        
        [self.tableView.collectionView reloadData];
        
        [MBHUDView hudWithBody:@"删除成功" type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
        
    }
}

//cell点击动作
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _deleIndex = indexPath.row;
    
    //判断是否为删除状态
    if(_deleButtonState){
        
        NSLog(@"删除索引%ld-------------->",_deleIndex);
        
        UIActionSheet *deleSheet = [[UIActionSheet alloc] initWithTitle:@"确定要删除此收藏?" delegate:self cancelButtonTitle:@"取消删除" destructiveButtonTitle:@"确定删除" otherButtonTitles:nil, nil];
        
        [deleSheet showInView:self.tableView];
        
    }else{
        
        ImageMenuViewController *rootVC = [[ImageMenuViewController alloc] init];
        
        //传值到下一个控制器
        NSDictionary *imageDict = [[FilesHandler shareWriteFile] imageCollectionGet][indexPath.row];
        
        rootVC.string = [imageDict objectForKey:@"pic1"];
        
        [self.navigationController pushViewController:rootVC animated:YES];
        
        [rootVC release];
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
