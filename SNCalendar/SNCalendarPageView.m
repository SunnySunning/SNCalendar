//
//  SNCalendarPageView.m
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "SNCalendarPageView.h"
#import "SNCalendarWeekDayView.h"
#import "SNCalendarDayView.h"
#import "SNDateHelper.h"
#import "SNDayViewInfo.h"

@interface SNCalendarPageView ()

@property (nonatomic,weak) id<SNCalendarPageViewDelegate> pageViewDelegate;

@end

@implementation SNCalendarPageView

- (id)init
{
    if (self = [super init])
    {
        [self commitInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withPageViewDelegate:(id<SNCalendarPageViewDelegate>)pageViewDelegate
{
    if (self = [super initWithFrame:frame])
    {
        self.pageViewDelegate = pageViewDelegate;
        [self commitInit];
    }
    return self;
}

- (void)commitInit
{
    for (int i = 0; i < 6; i++)
    {
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height / 6;
        CGFloat x = 0;
        CGFloat y = i * h;
        SNCalendarWeekDayView *weekDayView = [[SNCalendarWeekDayView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [self addSubview:weekDayView];
    }
}

- (void)setDate:(NSDate *)date
{
    
    //首先对重用的pageview进行默认初始化工作
    for (int i = 0; i < [self.subviews count]; i++)
    {
        SNCalendarWeekDayView *weekView = self.subviews[i];
        for (int j = 0; j < [weekView.subviews count]; j++)
        {
            SNCalendarDayView *dayView = weekView.subviews[j];
            dayView.enabled = YES;
            [dayView setTitle:@"" forState:UIControlStateNormal];
            [dayView setTitle:@"" forState:UIControlStateSelected];
            [dayView setSelected:NO];
            [dayView setDotViewFlag:NO];
        }
    }
    
    
    //对pageview设置显示
    NSArray *dateArray = [SNDateHelper getCurrentDateArray:date];
    for (int i = 0; i < [self.subviews count]; i++)
    {
        SNCalendarWeekDayView *weekView = self.subviews[i];
        for (int j = 0; j < [weekView.subviews count]; j++)
        {
            SNDayViewInfo *dayViewInfo = [[dateArray objectAtIndex:i] objectAtIndex:j];
            SNCalendarDayView *dayView = weekView.subviews[j];
            
#warning 时间计算还有点问题
            dayView.date = dayViewInfo.date;
            
            if ([dayViewInfo.displayNumber integerValue] == NSIntegerMax)
            {
                dayView.enabled = NO;
                continue;
            }
            
            //对今天 进行标红操作
            [dayView setSelected:dayViewInfo.isToday];
            
            //像代理询问 添加事件标记
            if ([self.pageViewDelegate respondsToSelector:@selector(calendarPageView:andDayViewDate:)])
                [dayView setDotViewFlag:[self.pageViewDelegate calendarPageView:self andDayViewDate:dayViewInfo.date]];
            
            [dayView setTitle:[NSString stringWithFormat:@"%@",dayViewInfo.displayNumber] forState:UIControlStateNormal];
            [dayView setTitle:[NSString stringWithFormat:@"%@",dayViewInfo.displayNumber] forState:UIControlStateSelected];
        }
    }
}


















@end
