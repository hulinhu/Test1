//
//  UIViewController+XTSideMenu.h
//  KaiYanPianKe
//
//  Created by yph on 15-7-11.
//  Copyright (c) 2015年 杨培浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPHSideMenu;

@interface UIViewController (YPHSideMenu)

@property (nonatomic, strong, readonly) YPHSideMenu *sideMenuViewController;

@end
