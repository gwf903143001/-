//
//  TimeHandler.m
//  YuQi
//
//  Created by Conan on 14-12-13.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "TimeHandler.h"

@implementation TimeHandler

- (void)dealloc
{
    NSLog(@"---------------时间格式化dealloc------------");
    [super dealloc];
}

//时间
+(NSString *)getUTCFormateDate:(NSString *)newsDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    //现在时间
    NSDate* current_date = [[NSDate alloc] init];
    
    //现在时间和发表时间间隔的秒数
    NSTimeInterval time = [current_date timeIntervalSinceDate:newsDateFormatted];
    
    int month = ((int)time)/(3600*24*30);
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/60;
    
    NSString *dateContent;
    
    if(month != 0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@" ",month,@"个月前"];
        
    }else if(days != 0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@" ",days,@"天前"];
        
    }else if(hours != 0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@" ",hours,@"小时前"];
        
    }else {
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@" ",minute,@"分钟前"];
    }
    
    [current_date release];
    [dateFormatter release];
    
    return dateContent;
}

@end
