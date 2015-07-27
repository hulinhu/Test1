//
//  HomeViewController.m
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "HomeViewController.h"
#import "HLHomeModel.h"
#import "MyTabbar.h"

#import "HomeCell.h"
#import "LeftImageCell.h"
#import "ChoiceCell.h"
#import "MediaCell.h"

#import "MJRefresh.h"
#import "ShowViewController.h"



#import "WedViewController.h"

@interface HomeViewController ()
@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HomeViewController
{
   // NSMutableArray *_dataArray;
    UITableView *_tableView;
    UIView *_headerView;
    NSArray *_headerArray;
    NSString *_strURL;
    int page;



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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

  
   
    _headerView = [ZCControl createViewWithFrame:CGRectMake(5, 0, 310, 190) color:nil];
    _headerView.backgroundColor = [UIColor lightGrayColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, WIDTH ,HEIGHT- 64-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled = YES;
    _tableView.separatorColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];;


    /**
     *  跳入页面时就刷新 自动加载
     */
    page = 1;
    [self loadData];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self loadData];
    }];
    
    _tableView.footer = [MJRefreshBackGifFooter  footerWithRefreshingBlock:^{
        page = page + 1;
        [self loadData];
    }];
    
    // NSLog(@"%@",_headerArray);
    // 主要是是计算数组的vount 头视图判断
    if (_headerArray.count == 0)
    {
        _headerView.frame =  CGRectMake(0, 0, 0, 0);
        
    }
    else
    {
        [self createHeaderView];
        
    }

    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    
    
}
-(void)loadData
{
    
    [_tableView.header endRefreshing];
    [_tableView.footer  endRefreshing];
    
    HttpRequestBlock *block = [[HttpRequestBlock alloc] initWithUrlPath: [NSString stringWithFormat:HOME_URL,page] Block:^(BOOL isSucceed, HttpRequestBlock *http) {
     
        if (isSucceed)
        {
            if (page == 1)
            {
                self.dataArray=[[NSMutableArray alloc] init];

            }
            NSArray *modelArray = [NSMutableArray arrayWithArray: http.dataDic[@"datas"][@"list"]];
            _headerArray = [NSMutableArray arrayWithArray:http.dataDic[@"datas"][@"top"]];
            
            for ( NSDictionary*dic in modelArray)
            {
                HLHomeModel *mo = [[HLHomeModel alloc] init];
                [mo setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:mo];
            }
            [_tableView reloadData];
        }
        
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.dataArray count];
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellName1 = @"cell1";
    static NSString *cellName2 = @"cell2";
    static NSString *cellName3 = @"cell3";
    static NSString *cellName4 = @"cell4";
    
  
    HLHomeModel *model = self.dataArray [indexPath.row];
    
    // 顶端视图
    if ([model.model isEqualToString:@"6"] )
    {
        HomeCell *cell1=[tableView dequeueReusableCellWithIdentifier:cellName1];
        if(!cell1){
            
            cell1= [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil]lastObject];
            cell1.selectionStyle  = UITableViewCellSeparatorStyleNone;
        }
        
        if (model.more == 1)
        {
            cell1.frame = CGRectMake(0, 0, 320, 90);
            cell1.backgroundColor = [UIColor lightGrayColor];
            
            UIButton *btn;
            btn = [ ZCControl createButtonWithFrame:CGRectMake(240, 75, 60, 20) title:@"更多最火" imageName:nil bgImageName:nil target:self method:  @selector(bbtClick)];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.titleLabel.textColor = [UIColor  whiteColor];
            [cell1.contentView addSubview:btn];
            
            
        }
        
        [cell1 config:model];
        
        return cell1;
    }

    else if ([model.model isEqualToString:@"13"] )
    {
    
       ChoiceCell *cell3=[tableView dequeueReusableCellWithIdentifier:cellName3];
        if(!cell3){
            
            cell3= [[[NSBundle mainBundle] loadNibNamed:@"ChoiceCell" owner:self options:nil]lastObject];
            cell3.selectionStyle  = UITableViewCellSeparatorStyleNone;
        }
        
        [cell3 config:model];
        
        return cell3;
    
    
    }
    else if ([model.model isEqualToString:@"2"])
    {
       MediaCell *cell4=[tableView dequeueReusableCellWithIdentifier:cellName4];
        if(!cell4){
            
            cell4= [[[NSBundle mainBundle] loadNibNamed:@"MediaCell" owner:self options:nil]lastObject];
            cell4.selectionStyle  = UITableViewCellSeparatorStyleNone;
        }
        [cell4 config:model];
        
        return cell4;
    
    }
    else
    {
        
        LeftImageCell *cell2=[tableView dequeueReusableCellWithIdentifier:cellName2];
        if(!cell2){
            
            cell2= [[[NSBundle mainBundle] loadNibNamed:@"LeftImageCell" owner:self options:nil]lastObject];
            cell2.selectionStyle  = UITableViewCellSeparatorStyleNone;
        }
        [cell2 config:model];
        
        return cell2;
    }
    
    

}
-(void)bbtClick
{
    
    NSLog(@"1234");
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HLHomeModel *model = self.dataArray [indexPath.row];
    
    if (_headerArray == nil)
    {
        return 0;
    }
    else if ([model.model isEqualToString:@"6"] )
    {
        if (model.more == 1)
        {
            return 90;
        }
        return 70;
        
    }else if ([model.model isEqualToString:@"13"])
    {
    
        return 130;
    
    }// 视频
    else if ([model.model isEqualToString:@"2"])
    {
    
        return 240;
    
    }else // 大多数
    {
    
        return 80;
    
    }

}


-(void)createHeaderView
{
   
    NSDictionary *dict = [_headerArray lastObject];
    

    _strURL = [dict objectForKey:@"html5"];
    
    UIImageView * imageView =  [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 180)];
   [imageView sd_setImageWithURL:[NSURL URLWithString: [dict objectForKey:@"thumbnail"]]];
    [_headerView addSubview:imageView];
    
    UILabel *label = [ZCControl createLabelWithFrame:CGRectMake(5, 130, 320, 20) font:15 text:[dict objectForKey:@"title"]];
    label.textColor = [UIColor whiteColor];
    [_headerView addSubview:label];
    
    
    UIImageView *img1 = [ZCControl createImageViewFrame:CGRectMake(10, 160, 10, 10) imageName: @"user_top.png"];
    [_headerView addSubview:img1];
    
    
    UIImageView *img2 = [ZCControl createImageViewFrame:CGRectMake(60, 160, 10, 10) imageName: @"eye_open.png"];
    [_headerView addSubview:img2];
    
    
    UILabel *label1 = [ZCControl createLabelWithFrame:CGRectMake(30, 155, 20, 20) font:13 text:[dict objectForKey:@"author"]];
    label1.textColor = [UIColor whiteColor];
    [_headerView addSubview:label1];
    
    
    UILabel *label3 = [ZCControl createLabelWithFrame:CGRectMake(80, 155, 20, 20) font:13 text:[dict objectForKey:@"view"]];
    label3.textColor = [UIColor whiteColor];
    [_headerView addSubview:label3];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired = 1;
    _headerView.userInteractionEnabled = YES;
    [_headerView addGestureRecognizer:tap];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    HLHomeModel *model = self.dataArray [indexPath.row];

    if (!([model.model isEqualToString:@"13"]  || [model.model isEqualToString:@"2"]) )
    {
        
        ShowViewController *sh =[[ShowViewController alloc] init];
        sh.showUrl = ((HLHomeModel *) self.dataArray [indexPath.row]).html5;
        [self presentViewController:sh animated:YES completion:nil];
        
    }
    

}


-(void)tapClick
{

    WedViewController *wed = [[WedViewController alloc] init];
    wed.wedURL = _strURL;
    [self presentViewController:wed animated:YES completion:nil];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /**
     *  TabBar的判断跟隐藏，其继承于RootViewController 滑动时出现
     */
    for (UIView *view in  self.tabBarController.view.subviews  )
    {
        if ([view isKindOfClass:[MyTabbar class]])
        {
            view.hidden = NO;
            
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
