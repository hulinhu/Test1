//
//  MediaCell.m
//  WeiZaiProject
//
//  Created by MS on 15-7-17.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "MediaCell.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation MediaCell
{
    
    MPMoviePlayerController *_player;
    // 区分 MPMoviePlayerViewController
    
    NSString *_strMedia;
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)config:(HLHomeModel *)HLHomeModel
{
    
    [_bgImage sd_setImageWithURL:[NSURL URLWithString:HLHomeModel.thumbnail]];
    _titleName.text = HLHomeModel.title;
    _author.text = HLHomeModel.author;
    _reader.text = HLHomeModel.view;
    
    NSData *MediaUrl = [HLHomeModel.show dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray  *jsonArray = [NSJSONSerialization JSONObjectWithData: MediaUrl options:NSJSONReadingMutableContainers error:nil];
    _strMedia = [jsonArray [0] objectForKey:@"url"];
    
    NSLog(@"%@",_strMedia);

    
}
- (IBAction)MediaPlay:(id)sender {
    
    
    
    [(UIButton *)sender setImage:[UIImage imageNamed:@"mediacontroller_pause.png"] forState:UIControlStateNormal];

    
    NSURL *url = [NSURL URLWithString: _strMedia];
    _player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    _player.view.frame =  _bgImage.frame;
    [_player play];
    
    [self.contentView addSubview:_player.view];

    

    NSLog(@"1234");
}


@end
