//
//  ShareWebAnalysis.h
//  语奇cell2
//
//  Created by lanou3g on 14-12-5.
//  Copyright (c) 2014年 赵雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CellDescriptModel;

@interface ShareWebAnalysis : NSObject

//CellDescriptModel的数组
@property (nonatomic, retain)NSMutableArray *cellDescriArray;

//视频信息数组
@property(nonatomic,retain)NSMutableArray *videoMessageArray;

//文章内容模型存放数组
@property (nonatomic, retain)NSMutableArray *detailArray;

//主页列表模型
@property(nonatomic,retain) CellDescriptModel *cellDescriptModel;

//图片列表数据的数组
@property (nonatomic, retain) NSMutableArray *xiBaImageArray;
@property (nonatomic, retain) NSMutableArray *xiBaImageArray2;

//详情数组
@property (nonatomic, retain) NSMutableArray *xiBaImageDetailsArray;

//搞笑图片存储数组
@property(nonatomic,retain)NSMutableArray *pictureArray;

//单例类方法
+(ShareWebAnalysis *)shareModel;

/**
 * @brief 网络解析方法
 */
-(void)descriptionNetAnalysis;

//详情解析
-(void)detailsNetAnalysis : (NSString *)sender;

//列表刷新
-(void)descriptionNetAnalysisPlus : (NSString *)received;

//视频解析
-(void)requestVideoData : (NSString *)received;

//视频控制页面-属性
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,retain)NSMutableArray *arrayTitle;

//视频控制页面-存值方法(将视频标题存起来)
-(BOOL)loveOrHateButtonJudge:(NSString *)sender;

//获取图片列表的数据
-(void)requesImageListData;

-(void)requesImageListData2;

//详情
-(void)requesImageDetauilsListData:(NSInteger)sender;

//搞笑图片解析
-(void)requestPicturesData;
//-(void)requestPicturesDataPlus : (NSInteger)sender;

@end
