//
//  HLIndexView.m
//  WeiZaiProject
//
//  Created by MS on 15-7-16.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "HLIndexView.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation HLIndexView
{

    UIImageView *_bg1;
    MPMoviePlayerController *_player;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)createAnimation
{

    UIImageView *bg =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iPhone 4.png"]];
    bg.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:bg];
    
    _bg1 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_circle_wezeit.png"]];
    _bg1.frame = CGRectMake(130, 500, 60 , 60);
    [self addSubview:_bg1];
    
    [ self timerlay];
    

    
}
-(void)timerlay
{
    

    
    
    [UIView animateWithDuration:1 animations:^{
        _bg1.frame = CGRectMake(130, 380, 60 , 60);
        _bg1.alpha = 0.5f;
        
    } completion:^(BOOL finished) {
        [self mediaPlay];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];

        });
    }];
     

    
}
-(void)mediaPlay
{

    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/loading.mp4",[[NSBundle mainBundle] resourcePath]]];
    _player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    _player.controlStyle=MPMovieControlStyleNone;
    _player.view.frame = self.frame;
    _player.shouldAutoplay = YES;
    [_player play];
    [self addSubview:_player.view];
    

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
