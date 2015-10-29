//
//  ImageDetailsViewController.m
//  YuQi
//
//  Created by Conan on 14-12-16.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "ImageDetailsViewController.h"
#import "collectionTableView.h"
#import "ImageDetailsCollectionViewCell.h"
#import "ShareWebAnalysis.h"
#import "UIImageView+WebCache.h"
#import "ImageMenuViewController.h"
#import "ImageModel.h"
#import "MBProgressHUD.h"


#define kImageDrtailsCollectionCell @"ImageDrtailsCollectionCell"
#define kxiBaImageDetailsArray @"xiBaImageDetailsArray"

@interface ImageDetailsViewController ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>
//Flowlayout不需要设置代理
{
    BOOL _transformFlag;
}
@property (nonatomic, retain) CollectionTableView *tableView;

@end

@implementation ImageDetailsViewController


-(void)dealloc
{
    NSLog(@"-------动漫详细dealloc------");
    
    _imageM = nil;
    
    [_imageM release];
    
    [super dealloc];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.tableView = [[[CollectionTableView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
        
        self.title = @"兮八动漫";
        
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
    
    //重新设置Button
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(buttonAction:)];
    self.navigationItem.leftBarButtonItem = button;
    
    //取消TableView 的分割线
    self.tableView.separatorStyle = NO;
    
    //设置代理
    self.tableView.collectionView.dataSource = self;
    self.tableView.collectionView.delegate = self;
    
    //请求数据
    [self requestData];
    
    //注册cell(改为自己的Cell)
    [self.tableView.collectionView registerClass:[ImageDetailsCollectionViewCell class] forCellWithReuseIdentifier:kImageDrtailsCollectionCell];
    
    //KVO
    [[ShareWebAnalysis shareModel] addObserver:self forKeyPath:kxiBaImageDetailsArray options:(NSKeyValueObservingOptionNew)|(NSKeyValueObservingOptionOld) context:nil];
    
    //第三方导航滚动
    [self followRollingScrollView:self.tableView];
}

- (void)requestData
{
    //第三方缓存数据进度条
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    
    //请求数据
    [[ShareWebAnalysis shareModel] requesImageDetauilsListData:self.detailsId];
}

//返回按钮动作
-(void)buttonAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
    //清除图片缓存（不知实际是否有效果）
    [[SDImageCache sharedImageCache] clearMemory];
    
    [ShareWebAnalysis shareModel].xiBaImageDetailsArray = nil;
    [[ShareWebAnalysis shareModel].xiBaImageDetailsArray release];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:kxiBaImageDetailsArray]) {
        
        [MBProgressHUD hideHUDForView:self.tableView animated:NO];
        
        [self.tableView.collectionView reloadData];
                
        //移除观察者
        [[ShareWebAnalysis shareModel] removeObserver:self forKeyPath:kxiBaImageDetailsArray];
    }
    
}

//特效
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_transformFlag) {
        _transformFlag = !_transformFlag;
        
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
        
    }else{
        _transformFlag=!_transformFlag;
        
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
        
    }
}

//每个分组有多少个Cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [ShareWebAnalysis shareModel].xiBaImageDetailsArray.count;
    
}

//返回Cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建cell(改变为自己的cell)
    ImageDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageDrtailsCollectionCell forIndexPath:indexPath];
    
    //    UIImageView *tempIV = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]] autorelease];
    
    //    //设置背景颜色(图片)
    //    [cell setBackgroundView:tempIV];
    
    ImageModel *model = [ShareWebAnalysis shareModel].xiBaImageDetailsArray[indexPath.row];
    
    //拼接
    NSString *tempString = [NSString stringWithFormat:@"http://tupian.nikankan.com%@",model.pic_url_2];
    
    
    [cell.xiBaImageView sd_setImageWithURL:[NSURL URLWithString:tempString]];
    
    return cell;
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"图片列表序号:%ld",indexPath.row);
    
    ImageMenuViewController *rootVC = [[ImageMenuViewController alloc] init];
    
    //传值到下一个控制器
    ImageModel *model = [ShareWebAnalysis shareModel].xiBaImageDetailsArray[indexPath.row];
    
    rootVC.string = model.pic_url_1;
    
    //传给收藏，看是否要收藏
    rootVC.collectionImageDict = @{@"pic1": model.pic_url_1,@"pic2": model.pic_url_2};
    
    [self.navigationController pushViewController:rootVC animated:YES];
    
    [rootVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
