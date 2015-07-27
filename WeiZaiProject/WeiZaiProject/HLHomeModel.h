//
//  HLHomeModel.h
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLHomeModel : NSObject
@property(nonatomic,strong) NSString * author;
@property(nonatomic,strong) NSString * html5;
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * view;
@property(nonatomic,strong) NSString * model;
@property(nonatomic,strong) NSString * uid;
@property(nonatomic,strong) NSMutableArray * tags;
@property(nonatomic,strong) NSString * avatar;
@property(nonatomic,strong) NSString *applicationId;
@property(nonatomic,strong) NSString * share;
@property(nonatomic,strong) NSString  *thumbnail;
@property(nonatomic,strong) NSString  *show_detail;
@property(nonatomic,strong) NSString  *show;
@property(nonatomic,strong) NSString  *face;
@property(nonatomic,strong) NSString  *update_time;
@property(nonatomic ) int  more;

@end
