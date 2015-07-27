//
//  DownLoad.h
//  UITableView-4
//
//  Created by Visitor on 15/6/10.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DownLoad;
@protocol DownLoadDelegate <NSObject>
- (void)downLoadFinishWithDownLoad:(DownLoad *)downLoad;
@end

@interface DownLoad : NSObject<NSURLConnectionDataDelegate>
@property(nonatomic,strong)NSString *downLoadStr;
@property(nonatomic)int downLoadPage;
@property(nonatomic)int downLoadType;
@property(nonatomic,strong)NSMutableData *downLoadData;
@property(nonatomic,weak)__weak id<DownLoadDelegate> delegate;
- (void)downLoad;








@end
