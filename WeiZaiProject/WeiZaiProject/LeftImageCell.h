//
//  LeftImageCell.h
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLHomeModel.h"

@interface LeftImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *reader;
@property (weak, nonatomic) IBOutlet UIImageView *BIao;

-(void)config:(HLHomeModel *)HLHomeModel;
@end
