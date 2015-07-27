//
//  HLAppDelegate.h
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLAppDelegate : UIResponder <UIApplicationDelegate,PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) PPRevealSideViewController *revealSideViewController;
@end
