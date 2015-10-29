//
//  ImageViewController.m
//  YuQi
//
//  Created by Conan on 14-12-16.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "ImageViewController.h"
#import "CollectionTableView.h"
#import "ImageCollectionCell.h"
#import "ShareWebAnalysis.h"
#import "ImageModel.h"
#import "UIImageView+WebCache.h"

//第三方进度条
#import "MBProgressHUD.h"
#import "ImageDetailsViewController.h"

//标志
#define kImageCollectionCell @"ImageCollectionCell"

#define kXiBaImageArray2 @"xiBaImageArray2"

//遵循集合视图代理,数据源协议
@interface ImageViewController ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,UITableViewDelegate>
//Flowlayout不需要设置代理

{
    //控制图片进入效果布尔值
    BOOL _transformFlag;
}

@property(nonatomic, retain)CollectionTableView *imageView;

@end

@implementation ImageViewController

-(void)dealloc
{
    
    NSLog(@"-------------------动漫第一页dealloc-----------------------");
    _model = nil;
    _imageView = nil;
    
    [_model release];
    [_imageView release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.imageView = [[[CollectionTableView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
        
        self.title = @"兮八动漫";
        
    }
    return self;
}

-(void)loadView
{
    
    self.view = self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //重新设置Button(保留)
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(buttonAction:)];
   self.navigationItem.leftBarButtonItem = button;
    [button release];
    
    //取消TableView 的分割线
    self.imageView.separatorStyle = NO;
    
    //设置代理
    self.imageView.collectionView.dataSource = self;
    self.imageView.collectionView.delegate = self;
    
    //请求数据
    [self requestData];
    
    //    [[NatDataHandel shareModel] requesImageDetauilsListData:[self.model.id]];
    //    NSLog(@"+++++%d",self.model.id);
    
    //注册cell(改为自己的Cell)
    [self.imageView.collectionView registerClass:[ImageCollectionCell class] forCellWithReuseIdentifier:kImageCollectionCell];
    
    //KVO
    [[ShareWebAnalysis shareModel] addObserver:self forKeyPath:kXiBaImageArray2 options:(NSKeyValueObservingOptionNew)|(NSKeyValueObservingOptionOld) context:nil];
    
    //实现第三方导航滚动
    [self followRollingScrollView:self.imageView];
    
}

- (void)requestData
{
    //第三方缓存数据进度条
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.imageView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    
    //请求数据
    [[ShareWebAnalysis shareModel] requesImageListData];
    
    [[ShareWebAnalysis shareModel] requesImageListData2];
    
}

//重写Button
-(void)buttonAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
        
    [[SDImageCache sharedImageCache] clearMemory];

//    [[ShareWebAnalysis shareModel].xiBaImageArray2 removeAllObjects];
    [ShareWebAnalysis shareModel].xiBaImageArray2 = nil;
    [[ShareWebAnalysis shareModel].xiBaImageArray2 release];

}

#pragma 观察者动作
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:kXiBaImageArray2]) {
        
        [MBProgressHUD hideHUDForView:self.imageView animated:NO];
        
        [self.imageView.collectionView reloadData];
        
        [[ShareWebAnalysis shareModel] removeObserver:self forKeyPath:kXiBaImageArray2];
        
    }
    
}

//改变Cell进入模式
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_transformFlag) {
        _transformFlag = !_transformFlag;
        
        //角度
        CGFloat rotationAngleDegrees = 0;
        //弧度
        CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/-180);
        //定位
        CGPoint offsetPositioning = CGPointMake(500, -20);
        //传送
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, -1.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
        
        UIView *card = [cell contentView];
        card.layer.transform = transform;
        card.layer.opacity = 0.8;
        
        [UIView animateWithDuration:0.3f animations:^{
            card.layer.transform = CATransform3DIdentity;
            card.layer.opacity = 1;
        }];
        
    }else{
        _transformFlag=!_transformFlag;
        
        CGFloat rotationAngleDegrees = 0;
        CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
        CGPoint offsetPositioning = CGPointMake(-200, -20);
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
        
        UIView *card = [cell contentView];
        card.layer.transform = transform;
        card.layer.opacity = 0.8;
        
        [UIView animateWithDuration:0.3f animations:^{
            card.layer.transform = CATransform3DIdentity;
            card.layer.opacity = 1;
        }];
        
    }

}

//每个分组有多少个Cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [ShareWebAnalysis shareModel].xiBaImageArray2.count;
    
}

//返回Cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //创建cell(改变为自己的cell)
    ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageCollectionCell forIndexPath:indexPath];
    
    //    UIImageView *tempIV = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"] ] autorelease];
    
    //设置背景颜色(图片)
    //    [cell setBackgroundView:tempIV];
    
    //    cell.backgroundColor = [UIColor redColor];
    
    //
    ImageModel *model = [ShareWebAnalysis shareModel].xiBaImageArray[indexPath.row];
    
    //拼接
    NSString *picString = [NSString stringWithFormat:@"http://tupian.nikankan.com%@",model.pic_url];
    NSString *tagString = [NSString stringWithFormat:@"http://tupian.nikankan.com%@",model.tag_url];
    
    //判断
    if (indexPath.row < 25) {
        
        [cell.xiBaImageView sd_setImageWithURL:[NSURL URLWithString:picString]];
        cell.xiBaLabel.text = model.str_name;
        [cell.xiBaLabel setNumberOfLines:1];
        [cell.xiBaLabel sizeToFit];
        cell.xiBaLabel.layer.cornerRadius = 10;
        
    }else{
        
        [cell.xiBaImageView sd_setImageWithURL:[NSURL URLWithString:tagString]];
        cell.xiBaLabel.text = model.tag_name;
        [cell.xiBaLabel setNumberOfLines:1];
        [cell.xiBaLabel sizeToFit];
    }
    
    return cell;
}

//添加点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择图片列表序号:%ld",indexPath.row);
    
    ImageDetailsViewController *ImageDetails = [[[ImageDetailsViewController alloc] init] autorelease];
    
    ImageModel *model = [ShareWebAnalysis shareModel].xiBaImageArray[indexPath.row];
    
    NSLog(@"模型传值id:%ld",model.id);
    
    ImageDetails.detailsId = model.id;
    
    ImageDetails.imageM = model;
    
    //动画效果
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f ;
    
    //水波效果
    animation.type = @"rippleEffect";
    
    [self.navigationController pushViewController:ImageDetails animated:NO];
    
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
