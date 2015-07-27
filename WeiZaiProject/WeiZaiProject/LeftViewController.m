//
//  LeftViewController.m
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "LeftViewController.h"
#import "HLLeft.h"
#import "MyTabbar.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

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

    
    self.view.backgroundColor = [UIColor redColor];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"left" owner:self options:nil];
    HLLeft *leftView = [array firstObject];
    leftView.frame =  self.view.frame;
    [self.view addSubview:leftView];
    

    
    
}
// 此处可以隐藏抽屉
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


    for (UIView *view in self.tabBarController.view.subviews)
    {
        if ([view isKindOfClass:[MyTabbar class]])
        {
            view.hidden = YES;
            
        }
    }

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
