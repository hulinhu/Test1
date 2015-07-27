//
//  DownLoadManager.m
//  UITableView-4
//
//  Created by Visitor on 15/6/10.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import "DownLoadManager.h"



@implementation DownLoadManager
{
    NSMutableDictionary *_taskDict;
    NSMutableDictionary *_sourceDict;
}
static DownLoadManager *_sharedDownLoadManager;
+ (DownLoadManager *)sharedDownLoadManager
{
    if(!_sharedDownLoadManager)
    {
        _sharedDownLoadManager = [[DownLoadManager alloc] init];
    }
    return _sharedDownLoadManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sourceDict = [[NSMutableDictionary alloc] init];
        _taskDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addDownLoadWithDownLoadStr:(NSString *)downLoadStr andPage:(int)page andDownLoadType:(int)downLoadType andIsRefresh:(BOOL)isRefresh;
{
    
    if(isRefresh)
    {
        if(![_taskDict objectForKey:downLoadStr])
        {
            [_sourceDict removeObjectForKey:downLoadStr];
            DownLoad *dl = [[DownLoad alloc] init];
            dl.downLoadStr = downLoadStr;
            dl.downLoadType = downLoadType;
            dl.delegate = self;
            dl.downLoadPage = page;
            [dl downLoad];
            [_taskDict setObject:dl forKey:downLoadStr];
        }
        else
            NSLog(@"当前下载任务正在下载");
    }
    else
    {
        if([_sourceDict objectForKey:downLoadStr])
        {
            if([[_sourceDict objectForKey:downLoadStr] objectForKey:[NSString stringWithFormat:@"%d",page]])
            {
                NSLog(@"有缓存数据");
                [[NSNotificationCenter defaultCenter] postNotificationName:downLoadStr object:nil];
            }
            else
            {
                if(![_taskDict objectForKey:downLoadStr])
                {
                    DownLoad *dl = [[DownLoad alloc] init];
                    dl.downLoadStr = downLoadStr;
                    dl.downLoadType = downLoadType;
                    dl.delegate = self;
                    dl.downLoadPage = page;
                    [dl downLoad];
                    [_taskDict setObject:dl forKey:downLoadStr];
                }
                else
                    NSLog(@"当前下载任务正在下载");
            }
        }
        else
        {
            if(![_taskDict objectForKey:downLoadStr])
            {
                DownLoad *dl = [[DownLoad alloc] init];
                dl.downLoadStr = downLoadStr;
                dl.downLoadType = downLoadType;
                dl.delegate = self;
                dl.downLoadPage = page;
                [dl downLoad];
                [_taskDict setObject:dl forKey:downLoadStr];
            }
            else
                NSLog(@"当前下载任务正在下载");
        }
        
        /*
         if(![_sourceDict objectForKey:downLoadStr])
         {
         if(![_taskDict objectForKey:downLoadStr])
         {
         DownLoad *dl = [[DownLoad alloc] init];
         dl.downLoadStr = downLoadStr;
         dl.downLoadType = downLoadType;
         dl.delegate = self;
         dl.downLoadPage = page;
         [dl downLoad];
         [_taskDict setObject:dl forKey:downLoadStr];
         }
         else
         NSLog(@"当前下载任务正在下载");
         }
         else
         {
         NSLog(@"已经有缓存数据");
         [[NSNotificationCenter defaultCenter] postNotificationName:downLoadStr object:nil];
         }
         */
    }
}

- (void)downLoadFinishWithDownLoad:(DownLoad *)downLoad
{
    [_taskDict removeObjectForKey:downLoad.downLoadStr];
    
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    if(downLoad.downLoadType == 0)
    {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
        NSArray *news = [jsonDict objectForKey:@"news"];
        for(NSDictionary *dict in news)
        {
  
        }
    }
    
    NSMutableArray *oldArray;
    // 判断之前是否有数据
    if([_sourceDict objectForKey:downLoad.downLoadStr])
    {
        NSDictionary *oldDict = [_sourceDict objectForKey:downLoad.downLoadStr];
        oldArray = [NSMutableArray arrayWithArray:[[oldDict allValues] firstObject]];
        [oldArray addObjectsFromArray:dataArray];
        NSDictionary *newDict = [[NSDictionary alloc] initWithObjectsAndKeys:oldArray,[NSString stringWithFormat:@"%d",downLoad.downLoadPage], nil];
        [_sourceDict setObject:newDict forKey:downLoad.downLoadStr];
    }
    else
    {
        
        // 存储
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:dataArray,[NSString stringWithFormat:@"%d",downLoad.downLoadPage], nil];
        [_sourceDict setObject:dict forKey:downLoad.downLoadStr];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:downLoad.downLoadStr object:nil];
    
}

- (NSMutableArray *)getDataWithDownLoadStr:(NSString *)downLoadStr
{
    return [((NSArray *)[[_sourceDict objectForKey:downLoadStr] allValues]) firstObject];
}










@end
