//
//  SNCalendarHorizontalModeView.m
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "SNCalendarHorizontalModeView.h"
#import "SNCalendarMenuView.h"
#import "SNCalendarPageView.h"
#import "SNDateHelper.h"

@interface SNCalendarHorizontalModeView ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *currentDateArray;
@property (nonatomic,strong) NSDate *currentDisplayDate;
@property (nonatomic,weak) UIScrollView *mainScrollView;
@property (nonatomic,weak) id<SNCalendarPageViewDelegate> pageViewDelegate;

@end

@implementation SNCalendarHorizontalModeView

- (NSMutableArray *)currentDateArray
{
    if (_currentDateArray == nil)
    {
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:[SNDateHelper getNewDateByMonth:-1 fromDate:[NSDate date]]];
        [tempArray addObject:[NSDate date]];
        [tempArray addObject:[SNDateHelper getNewDateByMonth:1 fromDate:[NSDate date]]];
        _currentDateArray = tempArray;
    }
    return _currentDateArray;
}

- (id)init
{
    if (self = [super init])
    {
        [self commitInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self commitInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andPageViewDelegate:(id<SNCalendarPageViewDelegate>)delegate
{
    if (self = [super initWithFrame:frame])
    {
        self.pageViewDelegate = delegate;
        [self commitInit];
//        for (SNCalendarPageView *pageView in self.mainScrollView.subviews)
//        {
//            if ([pageView isKindOfClass:[SNCalendarPageView class]])
//                pageView.delegate = delegate;
//        }
    }
    return self;
}

- (void)commitInit
{
    //设置表示周期的菜单栏
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.width / 7;
    SNCalendarMenuView *menuView = [[SNCalendarMenuView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self addSubview:menuView];
    
    
    //每一个月的日历view
    CGFloat pageViewX = 0;
    CGFloat pageViewY = CGRectGetMaxY(menuView.frame);
    CGFloat pageViewW = self.frame.size.width;
    CGFloat pageViewH = self.frame.size.width / 7 * 6;
    /*
    SNCalendarPageView *pageView = [[SNCalendarPageView alloc] initWithFrame:CGRectMake(pageViewX, pageViewY, pageViewW, pageViewH)];
    [self addSubview:pageView];
    
    //设置日期
    [pageView setDate:[NSDate date]];
     */
    
    
    //创建一个mainscrollview
    UIScrollView *mainScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(pageViewX, pageViewY, pageViewW, pageViewH)];
    [self addSubview:mainScrollview];
    self.mainScrollView = mainScrollview;
    mainScrollview.delegate = self;
    mainScrollview.pagingEnabled = YES;
    mainScrollview.showsHorizontalScrollIndicator = NO;
    
    
    //创建三个循环使用的pageView
    for (int i = 0; i < 3; i++)
    {
        CGFloat w = mainScrollview.frame.size.width;
        CGFloat h = mainScrollview.frame.size.height;
        CGFloat x = w * i;
        CGFloat y = 0;
        
        SNCalendarPageView *contentPageView = [[SNCalendarPageView alloc] initWithFrame:CGRectMake(x, y, w, h) withPageViewDelegate:self.pageViewDelegate];
        [mainScrollview addSubview:contentPageView];
    }
    
    
    //设置内容大小
    mainScrollview.contentSize = CGSizeMake(3 * mainScrollview.frame.size.width, mainScrollview.frame.size.height);
    
    [self contentPageViewReload];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //向左
    if (scrollView.contentOffset.x >= scrollView.frame.size.width * 2)
    {
        NSDate *displayCurrentDate = self.currentDateArray[2];
        [self.currentDateArray removeObjectAtIndex:0];
        [self.currentDateArray addObject:[SNDateHelper getNewDateByMonth:1 fromDate:displayCurrentDate]];
        
        self.currentDisplayDate = displayCurrentDate;
        [self contentPageViewReload];
    }
    //向右
    else if (scrollView.contentOffset.x <= 0)
    {
        NSDate *displayCurrentDate = self.currentDateArray[0];
        [self.currentDateArray removeObjectAtIndex:2];
        [self.currentDateArray insertObject:[SNDateHelper getNewDateByMonth:-1 fromDate:displayCurrentDate] atIndex:0];
        
        self.currentDisplayDate = displayCurrentDate;
        [self contentPageViewReload];
    }
}

#pragma mark - privateMethod
- (void)contentPageViewReload
{
    int i = 0;
    for (SNCalendarPageView *pageView in self.mainScrollView.subviews)
    {
        if (![pageView isKindOfClass:[SNCalendarPageView class]])
            continue;
        
        [pageView setDate:self.currentDateArray[i]];
        i++;
    }
    
    //设置偏移量
    self.mainScrollView.contentOffset = CGPointMake(self.mainScrollView.frame.size.width, 0);
    
    //通知代理现在展示的时间
    if ([self.delegate respondsToSelector:@selector(calendarHorizontalModeView:andDisplayCurrentDate:)])
    {
        [self.delegate calendarHorizontalModeView:self andDisplayCurrentDate:self.currentDisplayDate];
    }
}

- (void)resetBackToToday
{
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObject:[SNDateHelper getNewDateByMonth:-1 fromDate:[NSDate date]]];
    [tempArray addObject:[NSDate date]];
    [tempArray addObject:[SNDateHelper getNewDateByMonth:1 fromDate:[NSDate date]]];
    self.currentDateArray = tempArray;
    self.currentDisplayDate = self.currentDateArray[1];
    
    [self contentPageViewReload];
}

@end
