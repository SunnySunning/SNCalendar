//
//  SNCalendarPageView.h
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNCalendarPageView;
@protocol SNCalendarPageViewDelegate <NSObject>

- (BOOL)calendarPageView:(SNCalendarPageView *)pageView andDayViewDate:(NSDate *)date;

@end

@interface SNCalendarPageView : UIView

- (id)initWithFrame:(CGRect)frame withPageViewDelegate:(id<SNCalendarPageViewDelegate>)pageViewDelegate;
- (void)setDate:(NSDate *)date;

@end
