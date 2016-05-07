//
//  NSDate+date.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/7.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (date)

/**
 *  判断是否是今年
 *
 *  @return 布尔值
 */
- (BOOL)isThisYear;

/**
 *  判断是否是今天
 *
 *  @return 布尔值
 */
- (BOOL)isToday;

/**
 *  判断是否是昨天
 *
 *  @return 布尔值
 */
- (BOOL)isYesterday;


/**
 *  获得日期组建差
 *
 *  @return 组件差
 */
- (NSDateComponents *)detalDateToNow;
@end
