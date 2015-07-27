//
//  ChoiceCell.m
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "ChoiceCell.h"

@implementation ChoiceCell
{

    
    NSDictionary *_choiceDic;
    NSString *Choicestr;
    
    NSArray *_answerArray;

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



-(void)config:(HLHomeModel *)HLHomeModel
{

    _titleName.text = HLHomeModel.title;
    [_titleName sizeToFit];
    
    NSData *ChoiceUrl = [HLHomeModel.show dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray  *jsonArray = [NSJSONSerialization JSONObjectWithData: ChoiceUrl options:NSJSONReadingMutableContainers error:nil];
    
    _answerArray = [jsonArray[0] objectForKey:@"answer"];
    
    
    
    [ _btn1 setTitle:[_answerArray[0] objectForKey:@"text"] forState:UIControlStateNormal];
    [ _btn2 setTitle:[_answerArray[1] objectForKey:@"text"] forState:UIControlStateNormal];
    
    


}
- (IBAction)Btn1:(UIButton *)sender {
    
    [self createView];

}

- (IBAction)Btn2:(UIButton *)sender {
    [self createView];

}

-(void)createView
{

    float sum = [[_answerArray[0] objectForKey:@"count"] floatValue] + [[_answerArray[1] objectForKey:@"count"] floatValue];
    
    
    UIView *View =  [ZCControl createViewWithFrame:  CGRectMake(5, 60, 310, 55) color:[UIColor whiteColor]];
    
    UILabel *label = [ZCControl createLabelWithFrame:CGRectMake(60, 10, 230, 15) font: 15 text:nil];
    //label.backgroundColor = [UIColor redColor];
    label.layer.borderWidth  = 1.0f;
    label.clipsToBounds = YES;
    label.layer.borderColor  = [UIColor darkGrayColor].CGColor;
    label.layer.cornerRadius = 8.0f;
    [View addSubview:label];
    
    // 会得时候
    float persent1 = [[_answerArray[0] objectForKey:@"count"] floatValue]/sum;
    NSLog(@"%lf",persent1);
    
    UILabel *Number1 = [ZCControl createLabelWithFrame:CGRectMake(0, 0, 230 * persent1 , 15) font: 15 text:nil];
    Number1.backgroundColor = [UIColor redColor];
    [label addSubview:Number1];
    
    UILabel *namelabel = [ZCControl createLabelWithFrame:CGRectMake(20, 10, 40, 15) font:15 text:[NSString stringWithFormat:@"%.0lf%@",persent1 * 100 ,@"%"]];
    [View addSubview:namelabel];
 
    
    
    
    

    UILabel *label1 = [ZCControl createLabelWithFrame:CGRectMake(60, 35, 230, 15) font: 15 text:nil];
   // label1.backgroundColor = [UIColor redColor];
    label1.layer.borderWidth  = 1.0f;
    label1.clipsToBounds = YES;
    label1.layer.borderColor  = [UIColor darkGrayColor].CGColor;
    label1.layer.cornerRadius = 10.f;
    [View addSubview:label1];
    
    float persent2 = [[_answerArray[1] objectForKey:@"count"] floatValue]/sum;
    UILabel *Number2 = [ZCControl createLabelWithFrame:CGRectMake(0, 0, 230 * persent2, 15) font: 15 text:nil];
    Number2.backgroundColor = [UIColor redColor];
    [label1 addSubview:Number2];
    
    UILabel *namelabel1 = [ZCControl createLabelWithFrame:CGRectMake(20, 35, 40, 15) font:15 text:[NSString stringWithFormat:@"%.0lf%@",persent2 * 100 ,@"%"]];
    [View addSubview:namelabel1];
    
    
    
    [self.contentView addSubview:View];
    
    
    
    
    
    



}


@end
