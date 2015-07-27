//
//  PictureCell.m
//  WeiZaiProject
//
//  Created by MS on 15-7-21.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell

- (void)awakeFromNib
{
    // Initialization code
    
}

-(void)config:(HLHomeModel *)HLHomeModel
{

    [_headerImage  sd_setImageWithURL:[NSURL URLWithString:HLHomeModel.avatar]];
    _headerImage.frame = CGRectMake(5, 5, 30, 30);
    
    _TitleName.text = HLHomeModel.author;
    _TitleName.frame = CGRectMake(40, 5, 100, 20);
    
    _timelabel.text = HLHomeModel.update_time;
    _timelabel.frame = CGRectMake(40, 25, 50, 10);
    
    UILabel *label = [ZCControl createLabelWithFrame:CGRectMake(5, 42, 140, 1) font: 0  text:nil];
    label.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:label];
    /**
     *  描述
     */

    _descLabel.text = HLHomeModel.title;
    CGSize titleSize = [ HLHomeModel.title sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(140, 10000) lineBreakMode:NSLineBreakByCharWrapping];
    _descLabel.numberOfLines = 3;
    _descLabel.frame = CGRectMake(5, 42, 130, titleSize.height);
    [_descLabel sizeToFit];
    
    /**
     *  加载图片
     */
    
//    NSData * showdata = [ HLHomeModel .show dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:showdata options: NSJSONReadingMutableContainers error:nil];
//    
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:HLHomeModel.thumbnail]]];
    
    [_bgImage sd_setImageWithURL:[NSURL URLWithString:HLHomeModel.thumbnail]];
    
    _bgImage.frame = CGRectMake(5, _descLabel.frame.origin.y + _descLabel.frame.size.height , 140, 100);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
