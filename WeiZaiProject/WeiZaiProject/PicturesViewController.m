//
//  PicturesViewController.m
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "PicturesViewController.h"
#import "HLHomeModel.h"
#import "PictureCell.h"
#import "MJRefresh.h"

@interface PicturesViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSMutableArray *dataArray2;
@end

@implementation PicturesViewController
{


    UITableView *_tableView1;
    UITableView *_tableView2;
    UIScrollView *_scrollView;
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
    
    

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 64, 320,self.view.frame.size.height-64-40);
    _scrollView.delegate = self;
    //_scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];
    _scrollView.contentSize = CGSizeMake(320, self.view.frame.size.height-64-44);
   
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, 150, self.view.frame.size.height-64-40) style:UITableViewStylePlain];
    _tableView1.delegate = self;
    _tableView1.bounces = NO;
    _tableView1.dataSource = self;
    
    _tableView1.showsVerticalScrollIndicator = NO;
    _tableView1.backgroundColor = [UIColor lightGrayColor];
    [_tableView1 setSeparatorColor:[UIColor clearColor]];
    [_scrollView addSubview:_tableView1];
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(165, 0, 150, self.view.frame.size.height-64-40) style:UITableViewStylePlain];
    _tableView2.delegate = self;
    _tableView2.bounces = NO;
    _tableView2.dataSource = self;
    
    _tableView2.showsVerticalScrollIndicator = NO;
    _tableView2.backgroundColor = [UIColor lightGrayColor];
    [_tableView2 setSeparatorColor:[UIColor clearColor]];
    
    [_scrollView addSubview:_tableView2];
    
    [self.view addSubview:_scrollView];
    /**
     *  上拉刷新
     */
    page = 1;
    [self loadData];
    _scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
         [self loadData];
    }];
    /**
     *  // MJRefreshAutoFooter  MJRefreshAutoNormalFooter 触底加载
     */
    _scrollView.footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        page = page +1;
        [self loadData];
    }];
    
    
    
}
-(void)loadData
{
    [_scrollView.header endRefreshing];
    [_scrollView.footer endRefreshing];
    
    HttpRequestBlock *block = [[HttpRequestBlock alloc] initWithUrlPath: [NSString stringWithFormat:PICT_URL ,page] Block:^(BOOL isSucceed, HttpRequestBlock *http) {
        
        if (isSucceed)
        {
            if (page == 1)
            {
            self.dataArray1=[[NSMutableArray alloc] init];
            self.dataArray2=[[NSMutableArray alloc] init];
            }

           
            NSArray *modelArray = [NSMutableArray arrayWithArray: http.dataDic[@"datas"]];
            
            int count = 1;
            for ( NSDictionary*dic in modelArray)
            {
                HLHomeModel *mo = [[HLHomeModel alloc] init];
                if (count%2 == 1)
                {
                    [mo setValuesForKeysWithDictionary:dic];
                    [self.dataArray1 addObject:mo];
                }
                else
                {
                    
                    [mo setValuesForKeysWithDictionary:dic];
                    [self.dataArray2 addObject:mo];
                
                }
                count++;
       
            }
            [_tableView1 reloadData];
            [_tableView2 reloadData];
        }
        
        
    }];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellName1 = @"cellName";
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName1];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PictureCell" owner:self options:nil]lastObject];
    }
    
    if (tableView == _tableView1)
    {
        HLHomeModel *hl = self.dataArray1[indexPath.row];
        [cell config:hl];
    }
    else
    {
        HLHomeModel *hl = self.dataArray2[indexPath.row];
        [cell config:hl];
    
    }

    return cell;




}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

   
    if (tableView == _tableView1)
        return 230;
        else
          return 230;

    
//    UIImageView *imageView;
//     imageView.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:hl.thumbnail]]]];
    
    
    
    
    






}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == _tableView1)
    {
        return [self.dataArray1 count];
    }
    else
        return [self.dataArray2 count];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView1.contentSize.height > _tableView2.contentSize.height)
    {
        _tableView2.contentSize = _tableView1.contentSize;
    }
    else
        _tableView1.contentSize = _tableView2.contentSize;
    
    if (scrollView == _tableView1)
    {
        [_tableView2 setContentOffset:CGPointMake(0, _tableView1.contentOffset.y)];
    }
    else
        [_tableView1 setContentOffset:CGPointMake(0, _tableView2.contentOffset.y)];

    
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
