//
//  MediaCell.h
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLHomeModel.h"

@interface MediaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *reader;
- (IBAction)MediaPlay:(id)sender;
-(void)config:(HLHomeModel *)HLHomeModel;

@end
