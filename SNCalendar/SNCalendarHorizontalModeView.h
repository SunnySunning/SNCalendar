//
//  SNCalendarHorizontalModeView.h
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCalendarPageView.h"

@class SNCalendarHorizontalModeView;

@protocol SNCalendarHorizontalModeViewDelegate <NSObject>

- (void)calendarHorizontalModeView:(SNCalendarHorizontalModeView *)horizontalModeView andDisplayCurrentDate:(NSDate *)date;

@end

@interface SNCalendarHorizontalModeView : UIView

@property (nonatomic,weak) id<SNCalendarHorizontalModeViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andPageViewDelegate:(id<SNCalendarPageViewDelegate>)delegate;
- (void)resetBackToToday;

@end
