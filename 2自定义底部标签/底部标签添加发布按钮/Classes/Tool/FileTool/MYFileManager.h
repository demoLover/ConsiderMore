//
//  MYFileManager.h
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 程涛. All rights reserved.
//

/*
 
 获取文件尺寸，以及清除文件夹内容
 */
#import <Foundation/Foundation.h>

@interface MYFileManager : NSObject
/**
 *  传入文件夹路径，获取文件夹大小
 *
 *  @param directoryPath 文件夹路径
 *
 *  @return 文件夹尺寸
 */
+ (NSInteger)getSizeOfDirectoryPath:(NSString *)directoryPath;

/**
 *  传入文件夹路径，删除子文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeItemAtDirectoryPath:(NSString *)directoryPath;
@end
