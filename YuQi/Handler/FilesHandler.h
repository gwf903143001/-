//
//  FilesHandler.h
//  XIBA
//
//  Created by Conan on 14-12-20.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageModel;

@interface FilesHandler : NSObject

+(FilesHandler *)shareWriteFile;

//用户信息获取
- (void)userInfoGet;

//用户信息路径
- (NSString *)userInfoPathGet;

//获取收藏图片
- (NSArray *)imageCollectionGet;

//图片收藏路径
- (NSString *)imageCollectionPathGet;

//保存收藏图片
-(void)wirteToCollectFile:(NSDictionary *)collectImageDict;

//图片是否收藏
-(BOOL)isHadImage : (NSDictionary *)collectImageDict;

//删除收藏图片
-(void)deleteImage : (NSInteger)deleIndex;

//移除缓存
-(void)removeWebCache;

//缓存文件夹路径
- (float) folderSizeAtPath;

@end
