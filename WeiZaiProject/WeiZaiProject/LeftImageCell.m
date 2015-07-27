//
//  LeftImageCell.m
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "LeftImageCell.h"

@implementation LeftImageCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)config:(HLHomeModel *)HLHomeModel
{
    
//    [_bgImage sd_setImageWithURL:[NSURL URLWithString:HLHomeModel.thumbnail]];
//    _Maintitle.text = HLHomeModel.title;
//    _readerLabel.text = HLHomeModel.view;
    
    [_leftImg sd_setImageWithURL:[NSURL URLWithString:HLHomeModel.thumbnail]];
    _titleName.text = HLHomeModel.title;
    _titleName.font = [UIFont systemFontOfSize:13];
    _titleName.numberOfLines = 0;
    [_titleName sizeToFit];
    _author.text = HLHomeModel.author;
    _reader.text = HLHomeModel.view;
    _BIao.image = [UIImage imageNamed:[NSString stringWithFormat:@"ha_%@_n.png",HLHomeModel.face]];
    
    
    
}



@end
