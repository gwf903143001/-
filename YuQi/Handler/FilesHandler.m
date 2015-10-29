//
//  FilesHandler.m
//  XIBA
//
//  Created by Conan on 14-12-20.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "FilesHandler.h"
#import "NICAppDelegate.h"
#import "MBHUDView.h"
#import "ImageModel.h"
#import "SDImageCache.h"

//用户信息
#define kuserInfoFile @"/userInfoFile.plist"

//图片收藏
#define kimageCollectionFile @"/imageCollection.plist"

@implementation FilesHandler

-(void)dealloc
{
    NSLog(@"----------文件读写单例dealloc-------");
    
    [super dealloc];
}

+(FilesHandler *)shareWriteFile
{
    static FilesHandler *shareWrite = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        shareWrite = [[FilesHandler alloc] init];
    
    });
    
    return shareWrite;
}

- (NSString *)sandBoxPath
{
    //获取沙盒路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
//    NSLog(@"沙盒路径--->%@",documentPath);
    
    return documentPath;
}


-(void)userInfoGet
{
    NICAppDelegate *tempMainDelegate = [[UIApplication sharedApplication] delegate];
    NSArray *userInfoArray = [NSArray arrayWithContentsOfFile:[self userInfoPathGet]];
    
    //用户信息获取
    tempMainDelegate.globleUserName = userInfoArray[0];
    tempMainDelegate.globleUserMail = userInfoArray[1];
    
}

- (NSString *)userInfoPathGet
{
    NSString *InfotextPath = [[self sandBoxPath] stringByAppendingString:kuserInfoFile];
    
    return InfotextPath;
}

-(NSArray *)imageCollectionGet
{
    NSArray *imageCollectionArray = [NSArray arrayWithContentsOfFile:[self imageCollectionPathGet]];
    
    return imageCollectionArray;

}

- (NSString *)imageCollectionPathGet
{
    NSString *imageCollectionPath = [[self sandBoxPath] stringByAppendingString:kimageCollectionFile];
    
    return imageCollectionPath;
}

-(void)wirteToCollectFile:(NSDictionary *)collectImageDict
{
    NSMutableArray *addImageArray = [NSMutableArray arrayWithArray:[self imageCollectionGet]];
    
        //加入
        [addImageArray addObject: collectImageDict];
        
        //写入
        [addImageArray writeToFile:[self imageCollectionPathGet] atomically:YES];
    
}

-(BOOL)isHadImage : (NSDictionary *)collectImageDict
{
    BOOL ishad = NO;
    
    //遍历看是否收藏过
    for (NSDictionary *hadImage in [self imageCollectionGet]) {
        
        if(([[hadImage objectForKey:@"pic2"] isEqualToString:[collectImageDict objectForKey:@"pic2"]])){
            
            ishad = YES;
            break;
            
        }
    }
    
    return ishad;
}

-(void)deleteImage : (NSInteger)deleIndex;
{
    //用来删除图片的数组
    NSMutableArray *tempDeleArray = [NSMutableArray arrayWithArray:[self imageCollectionGet]];
    
    //删除
    [tempDeleArray removeObjectAtIndex:deleIndex];
    
    [tempDeleArray writeToFile:[self imageCollectionPathGet] atomically:YES];
    
}

//通常用于删除缓存的时，计算缓存大小
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        NSError *error = nil;
        
        return [[manager attributesOfItemAtPath:filePath error:&error] fileSize];
    }
    
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
- (float) folderSizeAtPath
{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    //如果文件不存在
    if (![manager fileExistsAtPath:cachPath]){
        
        return 0;
    }
        
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    
    //遍历到末尾
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString *fileAbsolutePath = [cachPath stringByAppendingPathComponent: fileName];
        folderSize += [self fileSizeAtPath: fileAbsolutePath];
    }
    
    return folderSize / (1024.0 * 1024.0);
}

-(void)removeWebCache
{
    //gcd清理缓存(不用，因为是单独操作)
    //清理缓存图片
    [[SDImageCache sharedImageCache] clearDisk];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        //获取缓存路径
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
        //打印缓存路径
//        NSLog(@"-------------缓存路径：%@-------------",cachPath);
    
        //将子路径放入数组
        NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:cachPath];
        
//        NSLog(@"---------------缓存文件 :%@------------",files);
    
        for (NSString *separeString in files) {
            
              NSError *error = nil;
            
            //拼接路径
            NSString *path = [cachPath stringByAppendingString:[NSString stringWithFormat:@"/%@",separeString]];
            
//            NSLog(@"path>>>%@",path);
            
            //如果路径存在
            if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
                
                [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
                
            }
            
        }
    
//    });

}

@end
