//
//  HLLeft.h
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLeft : UIView
@property (weak, nonatomic) IBOutlet UIImageView *HeaderImage;
- (IBAction)numberILogin:(id)sender;
- (IBAction)faviriteText:(id)sender;

- (IBAction)faviritePicture:(id)sender;
- (IBAction)BaoLiaoPicture:(id)sender;
- (IBAction)Comment:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Setting;

@end
