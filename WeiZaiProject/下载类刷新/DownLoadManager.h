//
//  DownLoadManager.h
//  UITableView-4
//
//  Created by Visitor on 15/6/10.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownLoad.h"

@interface DownLoadManager : NSObject<DownLoadDelegate>
+ (DownLoadManager *)sharedDownLoadManager;
- (void)addDownLoadWithDownLoadStr:(NSString *)downLoadStr andPage:(int)page andDownLoadType:(int)downLoadType andIsRefresh:(BOOL)isRefresh;
- (NSMutableArray *)getDataWithDownLoadStr:(NSString *)downLoadStr;
@end















