//
//  YPHBlurView.m
//  KaiYanPianKe
//
//  Created by yph on 15-7-11.
//  Copyright (c) 2015年 杨培浩. All rights reserved.
//

#import "YPHBlurView.h"
#import "UIImage+ImageEffects.h"

@implementation UIView (rn_Screenshot)

- (UIImage *)rn_screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

NSString * const YPHBlurViewImageKey = @"YPHBlurViewImageKey";

@implementation YPHBlurView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.blurRadius = 20;
        self.saturationDelta = 1.5;
        self.tintColor = nil;
        self.viewToBlur = nil;
        self.clipsToBounds = YES;
        self.blur = YES;
    }
    return self;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeObject:[UIImage imageWithCGImage:(CGImageRef)self.layer.contents] forKey:YPHBlurViewImageKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    self.layer.contents = (id)[[coder decodeObjectForKey:YPHBlurViewImageKey] CGImage];
}

- (UIView *)viewToBlur {
    if(_viewToBlur)
        return _viewToBlur;
    return self.superview;
}

- (void)updateBlur {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *blurredImage = [self applyBlurToImage:[self.viewToBlur rn_screenshot]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = (id)blurredImage.CGImage;
        });
    });
}

- (UIImage *)applyBlurToImage:(UIImage *)image {
    return [image applyBlurWithRadius:self.blurRadius
                            tintColor:self.tintColor
                saturationDeltaFactor:self.saturationDelta
                            maskImage:nil];
}

- (void)didMoveToSuperview {
    if (self.blur) {
        if(self.superview && self.viewToBlur.superview) {
            self.backgroundColor = [UIColor clearColor];
            [self updateBlur];
        }
        else if (!self.layer.contents) {
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
