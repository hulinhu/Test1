//
//  ChoiceCell.h
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLHomeModel.h"

@interface ChoiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;

- (IBAction)Btn1:(UIButton *)sender;
- (IBAction)Btn2:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

-(void)config:(HLHomeModel *)HLHomeModel;

@end
