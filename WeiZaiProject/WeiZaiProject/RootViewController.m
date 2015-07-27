//
//  RootViewController.m
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "RootViewController.h"
#import "LeftViewController.h"
#import "MyTabbar.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    for (UIView *view in self.tabBarController.view.subviews)
    {
        if ([view isKindOfClass:[MyTabbar class]])
        {
            view.hidden = NO;
        }
        
    }
    [self createNavigation];
    [self ADDleftView];

    
    
}

-(void)ADDleftView
{
    
    
    
    
    
    
}

-(void)createNavigation
{
    _myNavigationBar = [[MyNavigationBar alloc] init];
    _myNavigationBar.frame = CGRectMake(0, 20, 320, 44);
    
    
    NSMutableDictionary *leftDict = [[NSMutableDictionary alloc] init];
    [leftDict setObject:@"ic_drawer.png" forKey:@"itembgimagename"];
    
    NSMutableDictionary *leftDict1 = [[NSMutableDictionary alloc] init];
    [leftDict1 setObject:@"ic_logo.png" forKey:@"itembgimagename"];
    
    NSMutableDictionary *rightDict = [[NSMutableDictionary alloc] init];
    [rightDict setObject:@"ic_search.png" forKey:@"itembgimagename"];
    
    // 添加导航条
    [self.myNavigationBar createMyNavigationBarWithBgImageName:@"nav_bg.png" andTitle:nil andLeftItemArray:@[leftDict,leftDict1] andRightItemArray:@[rightDict] andClass:self andSEL:@selector(bbtClick:)];
    
    [self.view addSubview:_myNavigationBar];



}
-(void)bbtClick:(UIButton *)btn
{
    
    NSLog(@"%ld",(long)btn.tag);
    if (btn.tag == 0)
    {
        
        LeftViewController *ta = [[LeftViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.revealSideViewController pushViewController:ta onDirection: PPRevealSideDirectionLeft  animated:YES];
        
    }
    else
    {
    
        NSLog(@"执行搜索");
        
    
    }
    

  
     //[self.revealSideViewController pushViewController:ta onDirection: PPRevealSideInteractionNavigationBar  animated:YES];
    
    
   
    //[self.revealSideViewController presentViewController:ta animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
