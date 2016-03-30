//
//  SNDateHelper.m
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "SNDateHelper.h"
#import "SNDayViewInfo.h"

@implementation SNDateHelper

+ (NSInteger)totaldaysInThisMonth:(NSDate *)date
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

//获取当前月的日历数组 比如说:
//  日  一  二  三  四  五  六
//  0   0   1  2   3   4  5
//  6   7   8  9   10  11 12
//  13  14  15 16  17  18 19
//  20  21  22 23  24  25 26
//  27  28  29 30  31  0  0
//  0   0   0  0   0   0  0


//补充:将今天进行标红操作


+ (NSArray *)getCurrentDateArray:(NSDate *)date
{
    NSInteger daysCount = [SNDateHelper totaldaysInThisMonth:date];
    NSInteger firstDayInWeek = [SNDateHelper firstWeekdayInThisMonth:date];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 6 * 7; i++)
    {
        SNDayViewInfo *dayViewInfo = [[SNDayViewInfo alloc] init];
        if (i >= firstDayInWeek && i < (firstDayInWeek + daysCount) )
            dayViewInfo.displayNumber = @((i + 1) - firstDayInWeek);
        else
            dayViewInfo.displayNumber = @(NSIntegerMax);
        
        //补充:将今天 进行标红操作
        if ([[self getNewDateByDateCompWithDate:date] compare:[self getNewDateByDateCompWithDate:[NSDate date]]] == NSOrderedSame && [dayViewInfo.displayNumber integerValue] == [self getDayInteger:[NSDate date]])
            dayViewInfo.isToday = YES;
        else
            dayViewInfo.isToday = NO;
        
        //设置dayViewInfo时间
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSInteger year = [[dateFormatter stringFromDate:date] integerValue];
        
        [dateFormatter setDateFormat:@"MM"];
        NSInteger month = [[dateFormatter stringFromDate:date] integerValue];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:year];
        [comps setMonth:month];
        [comps setDay:[dayViewInfo.displayNumber integerValue] + 1];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [dayViewInfo setDate:[calendar dateFromComponents:comps]];
        
        
        /*
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        NSLog(@"%@",[dateFormatter1 stringFromDate:dayViewInfo.date]);
        */
        
        
        
        
        
        [tempArray addObject:dayViewInfo];
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++)
    {
        NSMutableArray *weekArray = [NSMutableArray array];
        [weekArray addObjectsFromArray:[tempArray subarrayWithRange:NSMakeRange(i * 7, 7)]];
        [resultArray addObject:weekArray];
    }
    
    return resultArray;
}

+ (NSDate *)getNewDateByMonth:(NSInteger)monthNumber fromDate:(NSDate *)fromDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *adComps = [[NSDateComponents alloc] init];
    [adComps setYear:0];
    [adComps setMonth:monthNumber];
    [adComps setDay:0];
    return [calendar dateByAddingComponents:adComps toDate:fromDate options:0];
}

+ (NSDate *)getNewDateByDay:(NSInteger)dayNumber fromDate:(NSDate *)fromDate
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy"];
//    NSInteger year = [[dateFormatter stringFromDate:fromDate] integerValue];
//    
//    [dateFormatter setDateFormat:@"MM"];
//    NSInteger month = [[dateFormatter stringFromDate:fromDate] integerValue];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *adComps = [[NSDateComponents alloc] init];
    [adComps setYear:0];
    [adComps setMonth:0];
    [adComps setDay:dayNumber];
    return [calendar dateByAddingComponents:adComps toDate:fromDate options:0];
}

+ (NSString *)getYearAndMonthStrWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    return [dateFormatter stringFromDate:date];
}

//获取一个特定格式的NSDate 用于比较两个日期是否相同的操作
+ (NSDate *)getNewDateByDateCompWithDate:(NSDate *)date
{
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearStr = [dateFormatter stringFromDate:date];
    [dc setYear:[yearStr integerValue]];
    
    [dateFormatter setDateFormat:@"MM"];
    NSString *monthStr = [dateFormatter stringFromDate:date];
    [dc setMonth:[monthStr integerValue]];
    
    [dateFormatter setDateFormat:@"dd"];
    NSString *dayStr = [dateFormatter stringFromDate:date];
#warning 为什么需要加一呢???
    [dc setDay:[dayStr integerValue] + 1];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [calendar dateFromComponents:dc];
}

#pragma mark - privateMethod
+ (NSInteger)getDayInteger:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    return [[dateFormatter stringFromDate:date] integerValue];
}

+ (NSInteger)getCurrentDayNumber
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    return [[dateFormatter stringFromDate:[NSDate date]] integerValue];
}













@end
