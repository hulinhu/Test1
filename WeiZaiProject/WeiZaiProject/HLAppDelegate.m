//
//  HLAppDelegate.m
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "HLAppDelegate.h"
#import "HLIndexView.h"
#import "RootViewController.h"
#import "HomeViewController.h"
#import "PicturesViewController.h"
#import "MessageViewController.h"
#import "AddViewController.h"
#import "MyTabbar.h"


@implementation HLAppDelegate
{
    UITabBarController *_tabbarController;



}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // 1.读取plist并实例化试图控制器
    NSMutableArray *viewControllArray = [[NSMutableArray alloc] init];
    NSArray *plistArray = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ViewController.plist",[[NSBundle mainBundle] resourcePath]]];
    for(NSDictionary *dict in plistArray)
    {
        RootViewController *vc = [[NSClassFromString([dict objectForKey:@"viewcontrollername"]) alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
        _revealSideViewController.delegate = self;
        [viewControllArray addObject:_revealSideViewController];
    }
    
    _tabbarController = [[UITabBarController alloc] init];
    _tabbarController.tabBar.hidden = YES;
    _tabbarController.viewControllers = viewControllArray;
   // _tabbarController.selectedIndex = 1;
    self.window.rootViewController = _tabbarController;
    
    [self createTableBar];
    // [self createNavigationView];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)createNavigationView
{

    // 判断是不第一次启动
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"count"])
//    {
        // 滚动图片
        HLIndexView *iv = [[HLIndexView alloc] init];
        iv.frame = self.window.bounds;
        [iv createAnimation];
    
        [_tabbarController.view addSubview:iv];
    
  //  }



}
-(void)createTableBar
{
    _tabbarController.tabBar.hidden = YES;
    MyTabbar *mt = [[MyTabbar alloc] init];
    mt.frame = CGRectMake(0, self.window.frame.size.height-40, 320, 40);
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Tabbar.plist",[[NSBundle mainBundle] resourcePath]]];
    [mt createMyTabbarWithTabbarDict:dict andClass:self andSEL:@selector(tabbarClick:)];
    [_tabbarController.view addSubview:mt];
    
    ((UIButton *)[((UIView *)[mt.subviews objectAtIndex:1]).subviews objectAtIndex:0]).selected = YES;
    
}
-(void)tabbarClick:(UIButton *)btn
{
    // 保证没有选中得按钮设置为暗色 重点 上来就将所有的按钮变为无色；
    for (UIView *view in btn.superview.superview.subviews)
    {
        if (![view isKindOfClass:[UIImageView class]])
        {
            ((UIButton *) [view.subviews objectAtIndex:0]).selected = NO;
        }
    }
    _tabbarController.selectedIndex = btn.tag;
    btn.selected = YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
