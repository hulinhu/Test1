//
//  ShowViewController.m
//  WeiZaiProject
//
//  Created by MS on 15-7-21.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController
{

    UIView *_barView;


}

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
    self.view.backgroundColor = [UIColor blackColor];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 20, WIDTH, HEIGHT-20);
    webView.backgroundColor = [UIColor redColor];

    NSURL *url = [NSURL URLWithString:_showUrl];
    webView.scrollView.bounces = NO;
    webView.scalesPageToFit = YES;//⾃自动对⻚页⾯面进⾏行缩放以适应屏幕
    webView.detectsPhoneNumbers = YES;//⾃自动检测⺴⽹网⻚页上的电话号码,
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
      [self createTableBar];
    
}
-(void)createTableBar
{
    _barView = [ZCControl createViewWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 49) color:[UIColor whiteColor]];
    [self.view addSubview:_barView];
    
    
    UIButton *savebtn = [ZCControl createButtonWithFrame:CGRectMake(20, 15, 20, 20) title:nil imageName:nil bgImageName:nil target:self  method:@selector(savebtnClick)];
    [savebtn setImage:[UIImage imageNamed:@"bottombar_like.png"] forState:UIControlStateNormal];
    [_barView addSubview:savebtn];
    
    
    
    UIButton *commentbtn = [ZCControl createButtonWithFrame:CGRectMake(80, 18, 20, 20) title:nil imageName:nil bgImageName:nil target:self  method:@selector(commentbtnClick)];
    [commentbtn setImage:[UIImage imageNamed:@"bottombar_comment.png"] forState:UIControlStateNormal];
    [_barView addSubview:commentbtn];
    
    
    UIButton *advicebtn = [ZCControl createButtonWithFrame:CGRectMake(140, 17, 20, 20) title:nil imageName:nil bgImageName:nil target:self  method:@selector(advicebtnClick)];
    [advicebtn setImage:[UIImage imageNamed:@"bottombar_ha.png"] forState:UIControlStateNormal];
    [_barView addSubview:advicebtn];
    
    
    
    UIButton *sharedbtn = [ZCControl createButtonWithFrame:CGRectMake(WIDTH-80, HEIGHT-80, 60, 60) title:nil imageName:nil bgImageName:nil target:self  method:@selector(sharedClick)];
    [sharedbtn setImage:[UIImage imageNamed:@"bottombar_share.png"] forState:UIControlStateNormal];
    [self.view addSubview:sharedbtn];
    
    
}
-(void)savebtnClick
{
    
    
    NSLog(@"收藏");
    
    
}
-(void)commentbtnClick
{
    
    NSLog(@"评论");
    
    
    
}
-(void)advicebtnClick
{
    
    
    
    NSLog(@"测评建议");
    
    
    
}
-(void)sharedClick
{
    
    
    NSLog(@"分享");
    
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
