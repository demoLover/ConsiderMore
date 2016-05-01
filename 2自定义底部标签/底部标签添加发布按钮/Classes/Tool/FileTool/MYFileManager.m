//
//  MYFileManager.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYFileManager.h"

@implementation MYFileManager
/*
 写业务类的注意点：
 1、方法要用多行注释，方便别人很清晰的了解方法功能参数
 2.文件前面要写注释，告诉别人业务类的功能
 3.要严谨，判断传入的参数是否正确，不正确要抛出异常
 */
+ (NSInteger)getSizeOfDirectoryPath:(NSString *)directoryPath{
    //获取文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //判断传入参数是否正确，不正确抛出异常
    BOOL isDirectory = NO;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isDirectory || !isExist) {
        NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"your filePath is not a Directory file" userInfo:nil];
        
        //抛出
        [exception raise];
    }
    
    NSInteger totalSize = 0;
    //获取文件夹的子路径
    NSArray *subPaths = [manager subpathsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        //去除隐藏文件和文件夹
        BOOL isDirectory = NO;
        BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
        if ([filePath containsString:@".DS"]) continue;
        
        if (isDirectory || !isExist) continue;
        
        //获取文件属性，包含了尺寸属性
        NSInteger fileSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        //累加
        totalSize += fileSize;
    }
    
    return totalSize;
}


+ (void)removeItemAtDirectoryPath:(NSString *)directoryPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //抛出异常
    //判断传入参数是否正确，不正确抛出异常
    BOOL isDirectory = NO;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isDirectory || !isExist) {
        NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"your filePath is not a Directory file" userInfo:nil];
        
        //抛出
        [exception raise];
    }
    
    //获取子文件(只能获取下一级子文件)
    NSArray *subPaths = [manager subpathsAtPath:directoryPath];
    
    //遍历拼接全路径，移除
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        //移除
        [manager removeItemAtPath:filePath error:nil];
    }

}
@end
