//
//  HomeCell.h
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLHomeModel.h"

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *Maintitle;

@property (weak, nonatomic) IBOutlet UILabel *readerLabel;


-(void)config:(HLHomeModel *)HLHomeModel;
@end
