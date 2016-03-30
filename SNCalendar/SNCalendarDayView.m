//
//  SNCalendarDayView.m
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "SNCalendarDayView.h"
#import "Tools.h"

@interface SNCalendarDayView ()

@property (nonatomic,weak) UIView *dotView;

@end

@implementation SNCalendarDayView

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
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    
    [self setBackgroundImage:[Tools getUIImageWithUIColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[Tools getUIImageWithUIColor:[UIColor redColor]] forState:UIControlStateSelected];
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(btTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *dotView = [[UIView alloc] init];
    [self addSubview:dotView];
    self.dotView = dotView;
    CGFloat dotViewW = 6;
    CGFloat dotViewH = 6;
    CGFloat dotViewX = ( self.bounds.size.width - dotViewW ) * 0.5;
    CGFloat dotViewY = ( self.bounds.size.height - dotViewH - 4 ) * 1.0;
    dotView.frame = CGRectMake(dotViewX, dotViewY, dotViewW, dotViewH);
    
    dotView.clipsToBounds = YES;
    dotView.layer.cornerRadius = dotViewW * 0.5;
}

- (void)btTouch:(UIButton *)bt
{
    self.selected = !bt.selected;
    
#warning 以通知的形式通知外边 哪一天被点击了
    [[NSNotificationCenter defaultCenter] postNotificationName:SNCalendarDayViewTouchNotification object:self userInfo:@{@"date":self.date}];
    
}

- (void)setDotViewFlag:(BOOL)flag
{
    if (flag)
    {
        self.dotView.backgroundColor = [UIColor blackColor];
    }
    else
    {
        self.dotView.backgroundColor = [UIColor clearColor];
    }
}

- (void)setCalendarDayViewFlag:(BOOL)flag
{
    self.selected = flag;
}

@end
