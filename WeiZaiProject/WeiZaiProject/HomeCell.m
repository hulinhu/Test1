//
//  HomeCell.m
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "HomeCell.h"


@implementation HomeCell


-(void)config:(HLHomeModel *)HLHomeModel
{

    [_bgImage sd_setImageWithURL:[NSURL URLWithString:HLHomeModel.thumbnail]];
    _Maintitle.text = HLHomeModel.title;
    [_Maintitle sizeToFit];
    _readerLabel.text = HLHomeModel.view;


}





- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
