//
//  DownLoad.m
//  UITableView-4
//
//  Created by Visitor on 15/6/10.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import "DownLoad.h"

@implementation DownLoad
- (void)downLoad
{
    NSString *downLoadPath = [NSString stringWithFormat:@"%@",_downLoadStr];
    if(_downLoadPage >= 0)
    {
        downLoadPath = [NSString stringWithFormat:downLoadPath,_downLoadPage];
    }
    NSURL *url = [NSURL URLWithString:downLoadPath];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _downLoadData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_downLoadData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_delegate downLoadFinishWithDownLoad:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error");
}












@end
