//
//  MessageViewController.m
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

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
        self.view.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];
    
//    NSMutableDictionary *leftDict = [[NSMutableDictionary alloc] init];
//    [leftDict setObject:@"ic_drawer.png" forKey:@"itembgimagename"];
//    
//;
//    
//    NSMutableDictionary *rightDict = [[NSMutableDictionary alloc] init];
//    [rightDict setObject:@"ic_search.png" forKey:@"itembgimagename"];
//    
//    // 添加导航条
//    [self.myNavigationBar createMyNavigationBarWithBgImageName:@"nav_bg.png" andTitle:@"消息通知" andLeftItemArray:@[leftDict] andRightItemArray:@[rightDict] andClass:self andSEL:nil];
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
