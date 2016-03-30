//
//  SNCalendarWeekDayView.m
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "SNCalendarWeekDayView.h"
#import "SNCalendarDayView.h"

@implementation SNCalendarWeekDayView

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

- (void)commitInit
{
    for (int i = 0 ; i < 7; i++)
    {
        CGFloat w = self.frame.size.width / 7;
        CGFloat h = w;
        CGFloat x = i * w;
        CGFloat y = 0;
        
        SNCalendarDayView *dayView = [[SNCalendarDayView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [self addSubview:dayView];
        
    }
}

@end
