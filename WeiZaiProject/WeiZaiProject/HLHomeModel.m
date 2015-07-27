//
//  HLHomeModel.m
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "HLHomeModel.h"

@implementation HLHomeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _tags = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"id"])
    {
        _applicationId = value;
    }


}
@end
