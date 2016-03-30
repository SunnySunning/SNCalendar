//
//  ViewController.m
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "ViewController.h"
#import "SNCalendarHorizontalModeView.h"
#import "SNDateHelper.h"
#import "SNCalendarDayView.h"

@interface ViewController ()<SNCalendarHorizontalModeViewDelegate,SNCalendarPageViewDelegate>

@property (nonatomic,weak) SNCalendarHorizontalModeView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SNCalendarHorizontalModeView *calendarView = [[SNCalendarHorizontalModeView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) andPageViewDelegate:self];
    calendarView.delegate = self;
    [self.view addSubview:calendarView];
    self.calendarView = calendarView;
    
    
    self.title = [SNDateHelper getYearAndMonthStrWithDate:[NSDate date]];
    
    //回到今天
    UIBarButtonItem *backToTodayItem = [[UIBarButtonItem alloc] initWithTitle:@"今天" style:UIBarButtonItemStylePlain target:self action:@selector(backToTodayItemTouch:)];
    self.navigationItem.rightBarButtonItem = backToTodayItem;
    
    
    //订阅点击某一天的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dayViewTouch:) name:SNCalendarDayViewTouchNotification object:nil];
    
    /*
    [NSDate date] 返回的不是一个单例
    NSDate *dateOne = [NSDate date];
    NSLog(@"dateOne --- %p",dateOne);
    NSDate *dateTwo = [NSDate date];
    NSLog(@"dateTwo --- %p",dateTwo);
     */
    
}

#pragma mark - 得到点击某一天view的通知
- (void)dayViewTouch:(NSNotification *)notification
{
    NSLog(@"%@",[notification valueForKey:@"userInfo"]);
}

#pragma mark - privateMethod
- (void)backToTodayItemTouch:(UIBarButtonItem *)item
{
    [self.calendarView resetBackToToday];
}

#pragma mark - SNCalendarHorizontalModeViewDelegate
- (void)calendarHorizontalModeView:(SNCalendarHorizontalModeView *)horizontalModeView andDisplayCurrentDate:(NSDate *)date
{
    self.title = [SNDateHelper getYearAndMonthStrWithDate:date];
}

#pragma mark - SNCalendarPageViewDelegate
- (BOOL)calendarPageView:(SNCalendarPageView *)pageView andDayViewDate:(NSDate *)date
{
    if ([[SNDateHelper getNewDateByDateCompWithDate:[NSDate date]] isEqualToDate:date])
        return YES;
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
