//
//  SNCalendarMenuView.m
//  SNCalendar
//
//  Created by bfec on 16/3/25.
//  Copyright © 2016年 LMC. All rights reserved.
//

#import "SNCalendarMenuView.h"

@interface SNCalendarMenuView ()

@property (nonatomic,strong) NSMutableArray *menuLabelTitleArray;

@end

@implementation SNCalendarMenuView

- (NSMutableArray *)menuLabelTitleArray
{
    if (_menuLabelTitleArray == nil)
    {
        _menuLabelTitleArray = [NSMutableArray arrayWithArray:@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]];
    }
    return _menuLabelTitleArray;
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

- (void)commitInit
{
    for (int i = 0; i < 7; i++)
    {
        UILabel *menuLabel = [[UILabel alloc] init];
        [self addSubview:menuLabel];
    
        CGFloat w = self.frame.size.width / 7;
        CGFloat h = w;
        CGFloat x = w * i;
        CGFloat y = 0;
        menuLabel.frame = CGRectMake(x, y, w, h);
        
        menuLabel.textAlignment = NSTextAlignmentCenter;
        menuLabel.textColor = [UIColor darkGrayColor];
        menuLabel.font = [UIFont systemFontOfSize:14.0];
        
        
        menuLabel.text = self.menuLabelTitleArray[i];
    }
    
    UILabel *partLine = [[UILabel alloc] init];
    [self addSubview:partLine];
    partLine.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
    partLine.backgroundColor = [UIColor lightGrayColor];
}

@end
