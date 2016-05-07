//
//  NSDate+date.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "NSDate+date.h"

@implementation NSDate (date)

- (BOOL)isThisYear
{
    NSCalendar *curentCalendar = [NSCalendar currentCalendar];//获取日历类
    
    //获取日期年组件
    NSDateComponents *cmp = [curentCalendar components:NSCalendarUnitYear fromDate:self];
    
    //获取当前日期组建
    NSDateComponents *cureentCmp = [curentCalendar components:NSCalendarUnitYear  fromDate:[NSDate date]];
    
    return cmp.year == cureentCmp.year;
}


- (BOOL)isToday
{
    NSCalendar *curentCalendar = [NSCalendar currentCalendar];//获取日历类
    
    return [curentCalendar isDateInToday:self];
}


- (BOOL)isYesterday
{
    NSCalendar *curentCalendar = [NSCalendar currentCalendar];//获取日历类
    
    return [curentCalendar isDateInYesterday:self];
}


- (NSDateComponents *)detalDateToNow
{
    NSCalendar *curentCalendar = [NSCalendar currentCalendar];//获取日历类
    
    NSInteger uinit =NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|
    NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    return [curentCalendar components:uinit fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
}
@end
