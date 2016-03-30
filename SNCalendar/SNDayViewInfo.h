//
//  SNDayViewInfo.h
//  SNCalendar
//
//  Created by bfec on 16/3/28.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNDayViewInfo : NSObject

@property (nonatomic,strong) NSNumber *displayNumber;
@property (nonatomic,assign) BOOL isToday;
@property (nonatomic,strong) NSDate *date;

@end
