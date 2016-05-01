//
//  MYSettingViewController.m
//  底部标签添加发布按钮
//
//  Created by admin on 16/4/24.
//  Copyright © 2016年 程涛. All rights reserved.
//

#import "MYSettingViewController.h"
#import "MYFileManager.h"


#define MYcachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface MYSettingViewController ()

@end
static NSString * const ID = @"set";
@implementation MYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
   /*
    //文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //获取caches路径
    NSString *cachPath = MYcachesPath;
    
    NSInteger totalSize = 0;
//    NSLog(@"%@",[manager subpathsAtPath:cachPath]);
    NSArray *subPaths = [manager subpathsAtPath:cachPath];
    
    //遍历数组，拼接文件全路径
    for (NSString *subpath in subPaths) {
        NSString *filePath = [cachPath stringByAppendingPathComponent:subpath];
        
        
        //文件夹中的子文件夹和隐藏文件也是有大小的，导致尺寸偏大，排除这些
        
        if ([filePath containsString:@".DS"]) continue;
        
        //文件管理者，有判断文件是文件夹，是否存在的方法
        BOOL isDirectory = NO;
        BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if (isDirectory || !isExist) continue;
        
        //获取文件属性，
        //        NSLog(@"%@",[manager attributesOfItemAtPath:filePath error:nil]);
        NSDictionary *attrdict = [manager attributesOfItemAtPath:filePath error:nil];
        //属性中包含尺寸属性，可以获取尺寸
        NSInteger fileSize = [attrdict fileSize];
        totalSize += fileSize;
    }
    NSLog(@"%ld",totalSize);
    */
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [self textLabelString];
    
    return cell;
}

//凭借标题字符串
- (NSString *)textLabelString
{
    //获取cache路径
    NSString *cachePath = MYcachesPath;
    
    //获取缓存尺寸
    NSInteger size = [MYFileManager getSizeOfDirectoryPath:cachePath];
    
    //拼接字符串
    NSString *str = @"清除缓存";
    if (size > 1000 * 1000) {//MB
        CGFloat sizeMB = size / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fMB)",str,sizeMB];
    } else if (size > 1000) {//KB
        CGFloat sizeKB = size / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fKB)",str,sizeKB];
    } else if (size > 0) {
        str = [NSString stringWithFormat:@"%@(%.1ldB)",str,size];
    }
    return str;
}


#pragma mark delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除缓存
    [MYFileManager removeItemAtDirectoryPath:MYcachesPath];
    
    //刷新
    [self.tableView reloadData];
}

@end
