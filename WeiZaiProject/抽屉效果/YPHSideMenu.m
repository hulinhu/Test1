//
//  YPHSideMenu.m
//  KaiYanPianKe
//
//  Created by yph on 15-7-11.
//  Copyright (c) 2015年 杨培浩. All rights reserved.
//

#import "YPHSideMenu.h"
#import "UIView+YPHFram.h"

typedef NS_ENUM(NSUInteger, YPHSideMenuVisibleType) {
    YPHSideMenuVisibleTypeContent = 0,
    YPHSideMenuVisibleTypeLeft = 1,
    YPHSideMenuVisibleTypeMoving = 3,
};

typedef NS_ENUM(NSUInteger, YPHSideMenuShowType) {
    YPHSideMenuShowTypeNone = 0,
    YPHSideMenuShowTypeLeft = 1,
};

typedef NS_ENUM(NSUInteger, YPHSideMenuDelegateType) {
    YPHSideMenuDelegateTypeDidRecognizePanGesture,
    
    YPHSideMenuDelegateTypeWillShowLeftMenuViewController,
    YPHSideMenuDelegateTypeDidShowLeftMenuViewController,
    YPHSideMenuDelegateTypeWillHideLeftMenuViewController,
    YPHSideMenuDelegateTypeDidHideLeftMenuViewController,
    
};



@interface YPHSideMenu ()<UIGestureRecognizerDelegate>

@property (nonatomic) YPHSideMenuVisibleType visibleType;

@property (nonatomic) YPHSideMenuShowType showType;

@property (nonatomic) CGPoint originalPoint;

@property (nonatomic, strong) UIView *menuViewContainer;

@property (nonatomic, strong) UIButton *menuButton;

@property (nonatomic, strong) UIView *menuOpacityView;

@property (nonatomic, strong) UIView *contentViewContainer;

@property (nonatomic, strong) YPHBlurView *contentBlurView;

@end

@implementation YPHSideMenu

- (id)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _visibleType = YPHSideMenuVisibleTypeContent;
    
    _menuViewContainer = [[UIView alloc] init];
    
    _contentViewContainer = [[UIView alloc] init];
    
    _contentBlurViewTintColor = [UIColor colorWithWhite:0.7 alpha:0.73];
    
    _contentBlurViewMinAlpha = 0;
    
    _contentBlurViewMaxAlpha = 0.5;
    
    _leftMenuViewVisibleWidth = 240;
    
    _animationDuration = 0.35;
    
    _panGestureEnabled = YES;
    
    _contentBlur = NO;
    
    _menuOpacityViewLeftMinAlpha = 0.8;
    
    _menuOpacityViewLeftMaxAlpha = 0.9;
    
    
    _menuOpacityViewLeftBackgroundColor = [UIColor blackColor];
    
}

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController leftMenuViewController:(UIViewController *)leftMenuViewController
{
    if (self = [self init]) {
        _contentViewController = contentViewController;
        _leftMenuViewController = leftMenuViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.menuButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectNull;
        [button addTarget:self action:@selector(hideMenuViewController) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    self.menuOpacityView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectNull];
        view;
    });
    
    self.contentBlurView = ({
        YPHBlurView *imageView = [[YPHBlurView alloc] initWithFrame:CGRectNull];
        [self updateContentBlurViewImage];
        imageView;
    });
    
    [self.view addSubview:self.menuViewContainer];
    [self.view addSubview:self.contentViewContainer];
    
    self.menuViewContainer.frame = self.view.bounds;
    self.menuViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (self.leftMenuViewController)
    {
        [self addChildViewController:self.leftMenuViewController];
        self.leftMenuViewController.view.frame = CGRectMake(0, 0, self.leftMenuViewVisibleWidth, CGRectGetHeight(self.view.bounds));
        self.leftMenuViewController.view.center = [self leftMenuViewCenter:YPHSideMenuShowTypeNone];
        [self.menuViewContainer addSubview:self.leftMenuViewController.view];
        [self.leftMenuViewController didMoveToParentViewController:self];
        self.leftMenuViewController.view.hidden = YES;
    }
    
    
    self.contentViewContainer.frame = self.view.bounds;
    self.contentViewContainer.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addChildViewController:self.contentViewController];
    self.contentViewController.view.frame = self.view.bounds;
    [self.contentViewContainer addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    
    self.menuViewContainer.alpha = 0;
    
    self.view.multipleTouchEnabled = NO;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    panGestureRecognizer.delegate = self;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    [self addCenterKVO];
}

#pragma mark -
#pragma mark KVO Method

- (void)addCenterKVO
{
    [self.leftMenuViewController.view addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"center"])
    {
        UIView *view = object;
        if (view == self.leftMenuViewController.view)
        {
            if (CGRectGetMinX(view.frame) > 0)
            {
                view.left = 0;
            }
        }
        
    }
}


#pragma mark -
#pragma mark - PublicMethod

/*!
 *  显示leftMenu
 */

- (void)presentLeftViewController
{
    if (self.leftMenuViewController)
    {
        [self dealDelegateWithType:YPHSideMenuDelegateTypeWillShowLeftMenuViewController object:self.leftMenuViewController];
        
        [self _presentLeftViewController];
    }
    else
    {
        NSAssert(false,@"NONE LEFTMENU!");
    }
}

/*!
 *  隐藏menu
 */

- (void)hideMenuViewController
{
    if (self.visibleType == YPHSideMenuVisibleTypeLeft)
    {
        [self dealDelegateWithType:YPHSideMenuDelegateTypeWillHideLeftMenuViewController object:self.leftMenuViewController];
    }
    
    YPHSideMenuVisibleType type = self.visibleType;
    [self.menuButton removeFromSuperview];
    self.visibleType = YPHSideMenuVisibleTypeMoving;
    
    if(type)
    {
        CGPoint center = self.leftMenuViewController.view.center;
        CGPoint endCenter = CGPointMake(center.x - CGRectGetWidth(self.leftMenuViewController.view.bounds), center.y);
        [UIView animateWithDuration:self.animationDuration
                         animations:^{
                             self.leftMenuViewController.view.center = endCenter;
                             self.menuOpacityView.center = endCenter;
                             self.menuOpacityView.alpha = self.menuOpacityViewLeftMinAlpha;
                             self.contentBlurView.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             self.menuViewContainer.alpha = 0;
                             self.leftMenuViewController.view.center = center;
                             self.leftMenuViewController.view.hidden = YES;
                             self.visibleType = YPHSideMenuVisibleTypeContent;
                             [self.contentBlurView removeFromSuperview];
                             [self dealDelegateWithType:YPHSideMenuDelegateTypeDidHideLeftMenuViewController object:self.leftMenuViewController];
                         }];
        
    }
}

#pragma mark -
#pragma mark - Private Method

- (CGPoint)leftMenuViewCenter:(YPHSideMenuShowType)type
{
    switch (type)
    {
        case YPHSideMenuShowTypeNone:
        case YPHSideMenuShowTypeLeft:
            return CGPointMake(self.leftMenuViewVisibleWidth / 2.0, CGRectGetHeight(self.leftMenuViewController.view.bounds) / 2.0);
            break;
        default:
            break;
    }
}


- (void)prepareForPresentMenuViewController
{
    [self.view bringSubviewToFront:self.menuViewContainer];
    
    [self.view.window endEditing:YES];
    
    [self addContentBlurView];
    
    [self addMenuButton];
    
    self.menuButton.enabled = NO;
    
    self.menuViewContainer.alpha = 1;
    
    self.contentBlurView.alpha = self.contentBlurViewMinAlpha;
}

- (void)prepareForPresentLeftViewController
{
    [self prepareForPresentMenuViewController];
    
    self.menuOpacityView.alpha = self.menuOpacityViewLeftMinAlpha;
    
    [self addMenuOpacityView:YPHSideMenuShowTypeLeft];
    
    [self updateMenuOperateViewBackgroundColor:YPHSideMenuShowTypeLeft];
    
    self.leftMenuViewController.view.hidden = NO;
    
    self.leftMenuViewController.view.center = [self leftMenuViewCenter:YPHSideMenuShowTypeNone];
    
    self.menuOpacityView.center = self.leftMenuViewController.view.center;
}



- (void)_presentLeftViewController
{
    if (!_leftMenuViewController) {
        return;
    }
    
    [self prepareForPresentLeftViewController];
    
    [self userInteractionEnabled:NO];
    
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.leftMenuViewController.view.center = [self leftMenuViewCenter:YPHSideMenuShowTypeLeft];
                         self.menuOpacityView.center = [self leftMenuViewCenter:YPHSideMenuShowTypeLeft];
                         self.menuOpacityView.alpha = self.menuOpacityViewLeftMaxAlpha;
                         self.contentBlurView.alpha = self.contentBlurViewMaxAlpha;
                     }
                     completion:^(BOOL finished) {
                         [self userInteractionEnabled:YES];
                         self.visibleType = YPHSideMenuVisibleTypeLeft;
                         self.menuButton.enabled = YES;
                         [self dealDelegateWithType:YPHSideMenuDelegateTypeDidShowLeftMenuViewController object:self.leftMenuViewController];
                     }];
}


#pragma mark -
#pragma mark UIGestureRecognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (!self.panGestureEnabled)
    {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark PanGestureAction

- (void)prepareForPanPresentLeftViewController
{
    [self prepareForPresentLeftViewController];
    
    self.showType = YPHSideMenuShowTypeLeft;
}


- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)sender
{
    [self dealDelegateWithType:YPHSideMenuDelegateTypeDidRecognizePanGesture object:sender];
    
    if (self.visibleType == YPHSideMenuVisibleTypeContent)
    {
        CGPoint point = [sender locationInView:self.view];
        
        switch (sender.state) {
            case UIGestureRecognizerStateBegan:
            {
                CGPoint dirPoint = [sender translationInView:self.view];
                
                self.originalPoint = point;
                
                if (dirPoint.x > 0 && self.leftMenuViewController)
                {
                    [self dealDelegateWithType:YPHSideMenuDelegateTypeWillShowLeftMenuViewController object:self.leftMenuViewController];
                    
                    [self prepareForPanPresentLeftViewController];
                }
                else
                {
                    self.showType = YPHSideMenuShowTypeNone;
                }
                break;
            }
            case UIGestureRecognizerStateChanged:
            {
                if (self.showType == YPHSideMenuShowTypeLeft)
                {
                    CGRect rect = self.leftMenuViewController.view.frame;
                    CGFloat maxX = CGRectGetMaxX(rect);
                    CGFloat progress = maxX / self.leftMenuViewVisibleWidth;
                    self.menuOpacityView.alpha = progress * (self.menuOpacityViewLeftMaxAlpha - self.menuOpacityViewLeftMinAlpha) + self.menuOpacityViewLeftMinAlpha;
                    self.contentBlurView.alpha = self.contentBlurViewMinAlpha + progress * (self.contentBlurViewMaxAlpha - self.contentBlurViewMinAlpha);
                    
                    CGPoint center = self.leftMenuViewController.view.center;
                    self.leftMenuViewController.view.center = CGPointMake(center.x + point.x - self.originalPoint.x, center.y);
                    self.menuOpacityView.center = self.leftMenuViewController.view.center;
                    self.originalPoint = point;
                }
                break;
            }
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled:
            {
                if (self.showType == YPHSideMenuShowTypeLeft)
                {
                    CGRect rect = self.leftMenuViewController.view.frame;
                    CGFloat maxX = CGRectGetMaxX(rect);
                    CGFloat deltaX = [sender velocityInView:self.view].x;
                    if (maxX == self.leftMenuViewVisibleWidth)
                    {
                        self.menuButton.enabled = YES;
                        self.visibleType = YPHSideMenuVisibleTypeLeft;
                        
                        [self dealDelegateWithType:YPHSideMenuDelegateTypeDidShowLeftMenuViewController object:self.leftMenuViewController];
                    }
                    else if ((maxX < self.leftMenuViewVisibleWidth && maxX >= self.leftMenuViewVisibleWidth / 2.0) || deltaX > 400)
                    {
                        [self userInteractionEnabled:NO];
                        [UIView animateWithDuration:self.animationDuration
                                         animations:^{
                                             self.leftMenuViewController.view.center = CGPointMake(self.leftMenuViewVisibleWidth / 2.0, CGRectGetMidY(rect));
                                             self.menuOpacityView.center = CGPointMake(self.leftMenuViewVisibleWidth / 2.0, CGRectGetMidY(rect));
                                             self.menuOpacityView.alpha = self.menuOpacityViewLeftMaxAlpha;
                                             self.contentBlurView.alpha = self.contentBlurViewMaxAlpha;
                                         }
                                         completion:^(BOOL finished) {
                                             [self userInteractionEnabled:YES];
                                             self.menuButton.enabled = YES;
                                             self.visibleType = YPHSideMenuVisibleTypeLeft;
                                             [self dealDelegateWithType:YPHSideMenuDelegateTypeDidShowLeftMenuViewController object:self.leftMenuViewController];
                                         }];
                    }
                    else
                    {
                        [self userInteractionEnabled:NO];
                        [self.menuButton removeFromSuperview];
                        CGPoint endCenter = CGPointMake(-1 * self.leftMenuViewVisibleWidth / 2.0, CGRectGetMidY(rect));
                        CGPoint origionCenter = CGPointMake(self.leftMenuViewVisibleWidth / 2.0, CGRectGetMidY(rect));
                        [UIView animateWithDuration:self.animationDuration
                                         animations:^{
                                             self.leftMenuViewController.view.center = endCenter;
                                             self.menuOpacityView.center = endCenter;
                                             self.menuOpacityView.alpha = self.menuOpacityViewLeftMinAlpha;
                                             self.contentBlurView.alpha = self.contentBlurViewMinAlpha;
                                         }
                                         completion:^(BOOL finished) {
                                             [self userInteractionEnabled:YES];
                                             self.menuViewContainer.alpha = 0;
                                             self.leftMenuViewController.view.center = origionCenter;
                                             self.leftMenuViewController.view.hidden = YES;
                                             self.visibleType = YPHSideMenuVisibleTypeContent;
                                             [self.contentBlurView removeFromSuperview];
                                         }];
                    }
                }
                
            }
            default:
                break;
        }
    }
    else if (self.visibleType == YPHSideMenuVisibleTypeLeft)
    {
        CGPoint point = [sender locationInView:self.view];
        switch (sender.state) {
            case UIGestureRecognizerStateBegan:
            {
                self.originalPoint = point;
                [self dealDelegateWithType:YPHSideMenuDelegateTypeWillHideLeftMenuViewController object:self.leftMenuViewController];
                break;
            }
            case UIGestureRecognizerStateChanged:
            {
                CGRect rect = self.leftMenuViewController.view.frame;
                CGFloat maxX = CGRectGetMaxX(rect);
                CGFloat progress = maxX / self.leftMenuViewVisibleWidth;
                self.menuOpacityView.alpha = progress * (self.menuOpacityViewLeftMaxAlpha - self.menuOpacityViewLeftMinAlpha) + self.menuOpacityViewLeftMinAlpha;
                self.contentBlurView.alpha = self.contentBlurViewMinAlpha + progress * (self.contentBlurViewMaxAlpha - self.contentBlurViewMinAlpha);
                CGPoint center = self.leftMenuViewController.view.center;
                self.leftMenuViewController.view.center = CGPointMake(center.x + point.x - self.originalPoint.x, center.y);
                self.menuOpacityView.center = self.leftMenuViewController.view.center;
                self.originalPoint = point;
                break;
            }
            case UIGestureRecognizerStateCancelled:
            case UIGestureRecognizerStateEnded:
            {
                CGRect rect = self.leftMenuViewController.view.frame;
                CGFloat maxX = CGRectGetMaxX(rect);
                CGFloat delta = [sender velocityInView:self.view].x;
                if (delta < -400 || maxX < self.leftMenuViewVisibleWidth / 2.0)
                {
                    [self userInteractionEnabled:NO];
                    [UIView animateWithDuration:self.animationDuration
                                     animations:^{
                                         self.leftMenuViewController.view.center = [self leftMenuViewCenter:YPHSideMenuShowTypeNone];
                                         self.menuOpacityView.center = [self leftMenuViewCenter:YPHSideMenuShowTypeNone];
                                         self.menuOpacityView.alpha = self.menuOpacityViewLeftMinAlpha;
                                         self.contentBlurView.alpha = self.contentBlurViewMinAlpha;
                                     }
                                     completion:^(BOOL finished) {
                                         [self.menuButton removeFromSuperview];
                                         self.menuViewContainer.alpha = 0;
                                         self.leftMenuViewController.view.center = [self leftMenuViewCenter:YPHSideMenuShowTypeLeft];
                                         self.leftMenuViewController.view.hidden = YES;
                                         self.visibleType = YPHSideMenuVisibleTypeContent;
                                         [self.contentBlurView removeFromSuperview];
                                         [self userInteractionEnabled:YES];
                                         [self dealDelegateWithType:YPHSideMenuDelegateTypeDidHideLeftMenuViewController object:self.leftMenuViewController];
                                     }];
                }
                else
                {
                    [self userInteractionEnabled:NO];
                    [UIView animateWithDuration:self.animationDuration
                                     animations:^{
                                         self.leftMenuViewController.view.center = CGPointMake(self.leftMenuViewVisibleWidth / 2.0, CGRectGetMidY(rect));
                                         self.menuOpacityView.center = CGPointMake(self.leftMenuViewVisibleWidth / 2.0, CGRectGetMidY(rect));
                                         self.menuOpacityView.alpha = self.menuOpacityViewLeftMaxAlpha;
                                         self.contentBlurView.alpha = self.contentBlurViewMaxAlpha;
                                     }
                                     completion:^(BOOL finished) {
                                         [self userInteractionEnabled:YES];
                                         self.menuButton.enabled = YES;
                                         self.visibleType = YPHSideMenuVisibleTypeLeft;
                                     }];
                }
                break;
            }
            default:
                break;
        }
        
    }
    
}

- (void)addMenuButton
{
    if (self.menuButton.superview)
    {
        return;
    }
    self.menuButton.autoresizingMask = UIViewAutoresizingNone;
    self.menuButton.frame = self.menuViewContainer.bounds;
    self.menuButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.menuViewContainer insertSubview:self.menuButton atIndex:0];
}

- (void)addMenuOpacityView:(YPHSideMenuShowType)type
{
    if (self.menuOpacityView.superview)
    {
        if (type == YPHSideMenuShowTypeLeft) {
            self.menuOpacityView.frame = self.leftMenuViewController.view.bounds;
        }
        return;
    }
    self.menuOpacityView.autoresizingMask = UIViewAutoresizingNone;
    if (type == YPHSideMenuShowTypeLeft) {
        self.menuOpacityView.frame = self.leftMenuViewController.view.bounds;
    }
    self.menuOpacityView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.menuViewContainer insertSubview:self.menuOpacityView aboveSubview:self.menuButton];
}

- (void)addContentBlurView
{
    if (self.contentBlurView.superview)
    {
        return;
    }
    self.contentBlurView.autoresizesSubviews = UIViewAutoresizingNone;
    self.contentBlurView.frame = self.contentViewContainer.bounds;
    self.contentBlurView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.contentBlurView.viewToBlur = self.contentViewController.view;
    [self.contentViewContainer insertSubview:self.contentBlurView aboveSubview:self.contentViewController.view];
}

- (void)updateContentBlurViewImage
{
    if (self.contentBlur)
    {
        self.contentBlurView.blur = YES;
        self.contentBlurView.tintColor = self.contentBlurViewTintColor;
    }
    else
    {
        self.contentBlurView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    }
}

- (void)updateMenuOperateViewBackgroundColor:(YPHSideMenuShowType)type
{
    if (type == YPHSideMenuShowTypeLeft)
    {
        self.menuOpacityView.backgroundColor = self.menuOpacityViewLeftBackgroundColor;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Status Bar Appearance Management

- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIStatusBarStyle statusBarStyle = UIStatusBarStyleLightContent;
    return statusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    BOOL statusBarHidden = NO;
    return statusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    UIStatusBarAnimation statusBarAnimation = UIStatusBarAnimationNone;
    return statusBarAnimation;
}

#pragma mark -
#pragma mark UserInteractionEnabled

- (void)userInteractionEnabled:(BOOL)enable
{
    self.view.userInteractionEnabled = enable;
}

#pragma mark -
#pragma mark DelegateMethod


#define YPHSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

- (void)dealDelegateWithType:(YPHSideMenuDelegateType)type object:(id)object
{
    if (_delegate) {
        SEL action;
        switch (type) {
            case YPHSideMenuDelegateTypeDidRecognizePanGesture:
                action = @selector(sideMenu:didRecognizePanGesture:);
                break;
            case YPHSideMenuDelegateTypeWillShowLeftMenuViewController:
                action = @selector(sideMenu:willShowLeftMenuViewController:);
                break;
            case YPHSideMenuDelegateTypeDidShowLeftMenuViewController:
                action = @selector(sideMenu:didShowLeftMenuViewController:);
                break;
            case YPHSideMenuDelegateTypeWillHideLeftMenuViewController:
                action = @selector(sideMenu:willHideLeftMenuViewController:);
                break;
            case YPHSideMenuDelegateTypeDidHideLeftMenuViewController:
                action = @selector(sideMenu:didHideLeftMenuViewController:);
                break;
            default:
                break;
        }
        if (action && [_delegate respondsToSelector:action] && object) {
            YPHSuppressPerformSelectorLeakWarning([_delegate performSelector:action withObject:self withObject:object]);
        }
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
