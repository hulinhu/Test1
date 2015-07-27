//
//  YPHSideMenu.h
//  KaiYanPianKe
//
//  Created by yph on 15-7-11.
//  Copyright (c) 2015年 杨培浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+YPHFram.h"
#import "YPHBlurView.h"

@protocol YPHSideMenuDelegate;

@interface YPHSideMenu : UIViewController

@property (nonatomic, strong) UIViewController *contentViewController;

@property (nonatomic, strong) UIViewController *leftMenuViewController;


@property (nonatomic, weak) id <YPHSideMenuDelegate> delegate;

@property (nonatomic) BOOL contentBlur;

@property (nonatomic) BOOL panGestureEnabled;

@property (nonatomic) NSTimeInterval animationDuration;

@property (nonatomic, strong) UIColor *contentBlurViewTintColor;

@property (nonatomic) CGFloat contentBlurViewMinAlpha;

@property (nonatomic) CGFloat contentBlurViewMaxAlpha;

@property (nonatomic) CGFloat leftMenuViewVisibleWidth;

@property (nonatomic, strong) UIColor *menuOpacityViewLeftBackgroundColor;

@property (nonatomic) CGFloat menuOpacityViewLeftMinAlpha;

@property (nonatomic) CGFloat menuOpacityViewLeftMaxAlpha;

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController
                       leftMenuViewController:(UIViewController *)leftMenuViewController;

- (void)presentLeftViewController;
- (void)hideMenuViewController;

@end

@protocol YPHSideMenuDelegate <NSObject>

@optional

- (void)sideMenu:(YPHSideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer;

- (void)sideMenu:(YPHSideMenu *)sideMenu willShowLeftMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(YPHSideMenu *)sideMenu didShowLeftMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(YPHSideMenu *)sideMenu willHideLeftMenuViewController:(UIViewController *)menuViewController;
- (void)sideMenu:(YPHSideMenu *)sideMenu didHideLeftMenuViewController:(UIViewController *)menuViewController;


@end
