//
//  ShareWebAnalysis.m
//  语奇cell2
//
//  Created by lanou3g on 14-12-5.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import "ShareWebAnalysis.h"
#import "DataToolHandler.h"
#import "CellDescriptModel.h"
#import "DetailModel.h"
#import "VideoModel.h"
#import "ImageModel.h"
#import "PictureModel.h"

//新鲜事接口
#define kActivityUrl @"http://i.jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=tags,author,title,date,comment_count,url,custom_fields&custom_fields=thumb_s"

//新鲜事详情
#define kDetailsWorkingUrl @"http://i.jandan.net/?oxwlxojflwblxbsapi=get_post&post_id="
#define kDetailsWorkingUrl1 @"&include=content"

//关键词宏定义
#define kPost @"posts"
#define kAuthor @"author"

@interface ShareWebAnalysis()

//存放临时数据的全局数组
@property (retain,nonatomic) NSMutableArray *tempArray;

@end

@implementation ShareWebAnalysis

-(void)dealloc
{
    NSLog(@"---------------网络解析dealloc------------");

    _tempArray = nil;
    _cellDescriArray = nil;
    _detailArray = nil;
    _cellDescriptModel = nil;
    _videoMessageArray = nil;
    
    [_tempArray release];
    [_cellDescriArray release];
    [_detailArray release];
    [_cellDescriptModel release];
    [_videoMessageArray release];
    
    [super dealloc];
}

+(ShareWebAnalysis *)shareModel
{
    static ShareWebAnalysis *shareModel = nil;
    
    //单例
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        shareModel = [[ShareWebAnalysis alloc] init];
    });

    return shareModel;
}

#pragma mark 无网络提示
- (void)alertForNet
{
    //网络状况提示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"兮八，网络便秘" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

#pragma mark  获取活动列表数据
-(void)descriptionNetAnalysis
{
    
    //防止循环引用
    __block typeof(self) tempSelf = self;
    
    //懒加载
    self.cellDescriArray = [NSMutableArray arrayWithCapacity:10];
    //临时存放数据的数组
    self.tempArray = [NSMutableArray arrayWithCapacity:10];
    
    [DataToolHandler solveDataFromUrlStrig:kActivityUrl dataBlock:^(NSData *data) {
        
        //防止没有网络崩溃
        if (nil == data) {
            
            data = [NSData data];
            
            [self alertForNet];
            
        }
        
        NSError *error = nil;
        //json解析
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:&error];
                
        //遍历获取数据
        for (NSDictionary *dictionary in jsonDict[kPost]) {
            
            CellDescriptModel *cellModel = [[[CellDescriptModel alloc] init] autorelease];
            
            //KVC
            [cellModel setValuesForKeysWithDictionary: dictionary];
            
            //module加到数组
            [tempSelf.tempArray addObject:cellModel];
            
        }
        
        //判断是否有数据
        if(tempSelf.tempArray.count > 0){
            
            //有时候请求的数据会出问题，第一条是旧数据，因此移除第一个元素（保留用）
//            [tempSelf.tempArray removeObjectAtIndex:0];
            
            //赋值
            tempSelf.cellDescriArray = [NSMutableArray arrayWithArray:tempSelf.tempArray];

        }else{
            
            return ;
            
        }
        
        //log输出
        NSLog(@"----------------------------------------------");
        NSLog(@"文章列表刷新前个数：%ld",(unsigned long)tempSelf.cellDescriArray.count);
        NSLog(@"----------------------------------------------");

    }];
    
}

#pragma mark 列表刷新网络解析
-(void)descriptionNetAnalysisPlus : (NSString *)received
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://i.jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&page=%@&include=tags,author,title,date,comment_count,url,custom_fields&custom_fields=thumb_s",received];

    __block typeof(self) tempSelf = self;

    [DataToolHandler solveDataFromUrlStrig:urlString dataBlock:^(NSData *data) {
        
        //防止没有网络崩溃
        if (nil == data) {
            
            data = [NSData data];
            
            [self alertForNet];
            
        }
        
        //json解析
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        
        //遍历获取数据
        for (NSDictionary *dictionary in jsonDict[kPost]) {
            
            CellDescriptModel *cellModel = [[[CellDescriptModel alloc] init] autorelease];
            
            //KVC
            [cellModel setValuesForKeysWithDictionary: dictionary];
            
            //module加到数组
            [tempSelf.tempArray addObject:cellModel];
            
        }
        
        //赋值
        tempSelf.cellDescriArray = [NSMutableArray arrayWithArray:tempSelf.tempArray];
        
        NSLog(@"----------------------------------------------");
        NSLog(@"列表刷新后个数：%ld",tempSelf.cellDescriArray.count);
        NSLog(@"----------------------------------------------");

    }];
    
}

#pragma mark 文章内容网络解析
-(void)detailsNetAnalysis : (NSString *)sender
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://i.jandan.net/?oxwlxojflwblxbsapi=get_post&post_id=%@&include=content",sender];
    
    __block typeof(self) tempSelf = self;
    
    [DataToolHandler solveDataFromUrlStrig:urlString dataBlock:^(NSData *data) {
        
        //防止没有网络崩溃
        if (nil == data) {
            
            data = [NSData data];
            
            [self alertForNet];
            
        }
        
        NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        
        DetailModel *detailModel = [[[DetailModel alloc] init] autorelease];
        
        [detailModel setValuesForKeysWithDictionary: tempDict];
        
        //模型加到数组
        tempSelf.detailArray = [NSMutableArray arrayWithObject:detailModel];
        
    }];
}

#pragma make 获取视频列表数据
-(void)requestVideoData : (NSString *)received
{
    
    NSString *mainVideoUrl = [NSString stringWithFormat:@"http://api.budejie.com/api/api_open.php?market=tencentyingyongbao&udid=860955024571485&a=list&c=video&os=4.1.1&client=android&userID=&page=1&per=%@&visiting=&type=41&mac=ac%%3Af7%%3Af3%%3A5d%%3A71%%3Ad2&ver=4.4.5&maxtime=",received];
    
    __block typeof(self) tempSelf = self;

    [DataToolHandler solveDataFromUrlStrig:mainVideoUrl dataBlock:^(NSData *data) {
        
        //防止没有网络崩溃
        if (nil == data) {
            
            data = [NSData data];
            
            [self alertForNet];
            
        }
        
        //JSON解析,由数组接收数据
        NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //临时存放数组的数据
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:10];
        
        //遍历获取信息
        for (NSDictionary *dict in tempDict[@"list"]) {
            
            VideoModel *VoidM = [[[VideoModel alloc] init] autorelease];
            
            //KVC
            [VoidM setValuesForKeysWithDictionary:dict];
            
            [tempArray addObject:VoidM];
            
        }
        
        //赋值
        tempSelf.videoMessageArray = [NSMutableArray arrayWithArray:tempArray];
        
        NSLog(@"----------------------------------------------");
        NSLog(@"列表个数：%ld",tempSelf.videoMessageArray.count);
        NSLog(@"----------------------------------------------");
    }];
    
}

#pragma make 以下为获取动漫图片
-(void)requesImageListData2
{
    
    NSURL *url = [NSURL URLWithString: @"http://tupian.nikankan.com/animepic.php?m=Index&a=animepictagbysortid&sortid=1"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //防止没有网络崩溃
        if (nil == data){
            
            data = [NSData data];
            
            [self alertForNet];
            
        }
        
        NSDictionary *imageDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        //遍历
        for (NSDictionary *dictionary in imageDict[@"pictagarr"]) {
            
            //model初始化
            ImageModel *model = [[ImageModel alloc] init];
            
            //kvc
            [model setValuesForKeysWithDictionary:dictionary];
            
            [self.xiBaImageArray addObject:model];
            
        }
        
        self.xiBaImageArray2 = [NSMutableArray arrayWithArray:self.xiBaImageArray];
        
        NSLog(@"列表图片:%ld",self.xiBaImageArray2.count);
    }];
    
}

//第一批列表图片
-(void)requesImageListData
{
    __block typeof(self) tempSelf = self;

    NSURL *url = [NSURL URLWithString: @"http://tupian.nikankan.com/animepic.php?m=Index&a=animepicsortindex&sortid=1"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //防止没有网络崩溃
        if (nil == data) {
            
            data = [NSData data];
            
            [tempSelf alertForNet];
            
        }
        
        NSDictionary *imageDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        //临时存储数据的数组
        NSMutableArray *imageArraya = [NSMutableArray arrayWithCapacity:10];
        
        //遍历
        for (NSDictionary *dictionary in imageDict[@"index_arr"]) {
                        
            //model初始化
            ImageModel *model = [[ImageModel alloc] init];
            
            //kvc
            [model setValuesForKeysWithDictionary:dictionary];
            
            [imageArraya addObject:model];
        }
        
        if(imageArraya.count == 0){
            
            NSLog(@"图片列表没有数据!!!!!!!!!!");
            
        }else{
            
            //赋值
            tempSelf.xiBaImageArray =[NSMutableArray arrayWithArray:imageArraya];
            
        }

    }];
}

//非分类列表
-(void)requesImageDetauilsListData:(NSInteger)sender
{
    __block typeof(self) tempSelf = self;
    
    NSLog(@"用于解析图片接收的id:%ld",sender);

    if (sender < 61) {
        NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://tupian.nikankan.com/animepic.php?m=Index&a=animepicindexpic&index_id=%ld",(long)sender]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            //防止没有网络崩溃
            if (nil == data) {
                data = [NSData data];
                
                [tempSelf alertForNet];
                
            }
            
            NSDictionary *imageDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            //临时存储数据的数组
            NSMutableArray *imageArraya = [NSMutableArray arrayWithCapacity:10];
            
            //遍历
            for (NSDictionary *dictionary in imageDict[@"picarr"]) {
                
                //model初始化
                ImageModel *model = [[[ImageModel alloc] init] autorelease];
                
                //kvc
                [model setValuesForKeysWithDictionary:dictionary];
                
                [imageArraya addObject:model];
                
            }
            
            //赋值
            if(imageArraya.count == 0){
                
                NSLog(@"图片没有数据!!!!!!!!!!");
                
            }else{
                
                tempSelf.xiBaImageDetailsArray = [NSMutableArray arrayWithArray:imageArraya];
                
            }
            
            NSLog(@"图片个数:%ld",_xiBaImageDetailsArray.count);
            
        }];
        
    }else{
        
        NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://tupian.nikankan.com/animepic.php?m=Index&a=animepicbytagid&pictagid=%ld",sender]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            //防止没有网络崩溃
            if (nil == data) {
                
                data = [NSData data];
                
                [tempSelf alertForNet];
                
            }
            
            NSDictionary *imageDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            //临时存储数据的数组
            NSMutableArray *imageArraya = [NSMutableArray arrayWithCapacity:10];
            
            //遍历
            for (NSDictionary *dictionary in imageDict[@"picarr"]) {
                
                //model初始化
                ImageModel *model = [[[ImageModel alloc] init] autorelease];
                
                //kvc
                [model setValuesForKeysWithDictionary:dictionary];
                
                [imageArraya addObject:model];
            }
            
            if(imageArraya.count == 0){
                
                NSLog(@"图片没有数据!!!!!!!!!!");
                
            }else{
              
                //赋值
                tempSelf.xiBaImageDetailsArray =[NSMutableArray arrayWithArray:imageArraya];
            }
            
            NSLog(@"图片个数:%ld",_xiBaImageDetailsArray.count);
            
        }];
        
    }
    
}

//搞笑图数据解析
-(void)requestPicturesData
{
    
    NSURL *url = [NSURL URLWithString:@"http://ic.snssdk.com/2/image/recent/?tag=heavy&count=100"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block typeof(self) tempSelf = self;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //防止没有网络崩溃
        if (nil == data) {
            
            data = [NSData data];
            
            [tempSelf alertForNet];
            
        }
        
        //解析大字典
        NSDictionary *pictureImageDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        //懒加载，临时数组
        NSMutableArray *tempPicArray = [NSMutableArray arrayWithCapacity:10];
        
        //从上面字典中取数组
        NSArray *pictureImageArr = [NSArray arrayWithArray:pictureImageDict[@"data"]];
        
        for (NSDictionary *dictionary in pictureImageArr) {
            
            //model初始化
            PictureModel *model = [[[PictureModel alloc] init] autorelease];
            
            //kvc
            [model setValuesForKeysWithDictionary:dictionary];
            
            [tempPicArray addObject:model];
            
        }
        
        tempSelf.pictureArray = [NSMutableArray arrayWithArray:tempPicArray];
        
        NSLog(@"图片刷新个数：%ld",tempPicArray.count);
    }];
    
}

//-(void)requestPicturesDataPlus : (NSInteger)sender
//{
//    //拼接url
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ic.snssdk.com/2/image/recent/?tag=heavy&count=%d",sender]];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    __block ShareWebAnalysis *tempSelf = self;
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        //防止没有网络崩溃
//        if (nil == data) {
//            data = [NSData data];
//            
//            [self alertForNet];
//            
//        }
//        
//        //解析大字典
//        NSDictionary *pictureImageDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        
//        //NSLog(@"%@",pictureImageDict);
//        
//        //从上面字典中取数组
//        NSArray *pictureImageArr = [NSArray arrayWithArray:pictureImageDict[@"data"]];
//        
//        for (NSDictionary *dictionary in pictureImageArr) {
//            
//            //model初始化
//            PictureModel *model = [[[PictureModel alloc]init]autorelease];
//            
//            //kvc
//            [model setValuesForKeysWithDictionary:dictionary];
//            
//            [tempSelf.pictureArray addObject:model];
//            
//        }
//        
//    }];
//    
//}

#pragma make 存值
-(BOOL)loveOrHateButtonJudge:(NSString *)sender
{
    //将布尔值设为一个定值
    BOOL flags = NO;
    
    //新建字符串遍历储存标题的数组
    for (NSString *s in self.arrayTitle) {
        
        //如果遍历不到,就将传入的字符串(标题)存入数组,然后flages设为YES;
        if ([s isEqualToString:sender] == 0) {
            
            //此处将标题写入数组
            [self.arrayTitle addObject:sender];
            
            flags = YES;
        }
    }
    
    //返回flags的值用于判断
    return flags;

}

@end
