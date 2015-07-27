//
//  YPHBlurView.h
//  KaiYanPianKe
//
//  Created by yph on 15-7-11.
//  Copyright (c) 2015年 杨培浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPHBlurView : UIView

@property (nonatomic, readwrite) CGFloat blurRadius;
@property (nonatomic, readwrite) CGFloat saturationDelta;
@property (nonatomic, readwrite) UIColor *tintColor;
@property (nonatomic, weak) UIView *viewToBlur;
@property (nonatomic) BOOL blur;

@end
