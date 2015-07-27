//
//  UIViewController+XTSideMenu.m
//  KaiYanPianKe
//
//  Created by yph on 15-7-11.
//  Copyright (c) 2015年 杨培浩. All rights reserved.
//

#import "UIViewController+YPHSideMenu.h"
#import "YPHSideMenu.h"

@implementation UIViewController (YPTSideMenu)

- (YPHSideMenu *)sideMenuViewController
{
    UIViewController *superVC = self.parentViewController;
    while (superVC) {
        if ([superVC isKindOfClass:[YPHSideMenu class]]) {
            return (YPHSideMenu *)superVC;
        } else if (superVC.parentViewController && superVC.parentViewController != superVC) {
            superVC = superVC.parentViewController;
        } else {
            superVC = nil;
        }
    }
    return nil;
}

@end
