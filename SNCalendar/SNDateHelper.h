//
//  SNDateHelper.h
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNDateHelper : NSObject

+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

+ (NSArray *)getCurrentDateArray:(NSDate *)date;

//获取上一个月/下一个月或者某一个月的一个时间
+ (NSDate *)getNewDateByMonth:(NSInteger)monthNumber fromDate:(NSDate *)fromDate;
//获取上一天/下一天或者某一天的一个时间
+ (NSDate *)getNewDateByDay:(NSInteger)dayNumber fromDate:(NSDate *)fromDate;

+ (NSString *)getYearAndMonthStrWithDate:(NSDate *)date;

//获取一个特定格式的NSDate 用于比较两个日期是否相同的操作
+ (NSDate *)getNewDateByDateCompWithDate:(NSDate *)date;

@end
