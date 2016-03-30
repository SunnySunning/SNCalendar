//
//  SNCalendarDayView.h
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SNCalendarDayViewTouchNotification @"SNCalendarDayViewTouchNotification"

@interface SNCalendarDayView : UIButton

@property (nonatomic,strong) NSDate *date;

- (void)setDotViewFlag:(BOOL)flag;
- (void)setCalendarDayViewFlag:(BOOL)flag;
- (void)setDate:(NSDate *)date;

@end
