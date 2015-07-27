//
//  PictureCell.h
//  WeiZaiProject
//
//  Created by MS on 15-7-21.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLHomeModel.h"

@interface PictureCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *TitleName;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

-(void)config:(HLHomeModel *)HLHomeModel;
@end
