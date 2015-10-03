//
//  MusicPlayerView.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicPlayerView.h"

@implementation MusicPlayerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}
-(void)addSubViews
{
    self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    self.backScrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenWidth );
    self.backScrollView.pagingEnabled = YES;
    [self addSubview:self.backScrollView];
    
    self.musicPlayerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth - 40, kScreenWidth - 40)];
    self.musicPlayerImgView.backgroundColor = [UIColor orangeColor];
    
    self.musicPlayerImgView.layer.masksToBounds = YES;
    self.musicPlayerImgView.layer.cornerRadius = self.musicPlayerImgView.frame.size.height / 2.0;
    
    [self.backScrollView addSubview:self.musicPlayerImgView];
    
    
    self.lyricTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenWidth)];
    [self.backScrollView addSubview:self.lyricTableView];
    
    
    self.beforeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.beforeBtn.frame = CGRectMake(0, kScreenHeight - 120, kScreenWidth / 3, 50);
    [self.beforeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.beforeBtn setTitle:@"上一首" forState:UIControlStateNormal];
    [self addSubview:self.beforeBtn];
    
    
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(kScreenWidth / 3, kScreenHeight - 120, kScreenWidth / 3, 50);
    [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.playBtn];

    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(kScreenWidth / 3 * 2, kScreenHeight - 120, kScreenWidth / 3, 50);
    [self.nextBtn setTitle:@"下一首" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.nextBtn];

    
    self.voiceSlider = [[UISlider alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.backScrollView.frame) + 20, kScreenWidth  - 40, 20)];
    self.voiceSlider.value = 0.3;
    [self addSubview:self.voiceSlider];
    
    self.playSlider = [[UISlider alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(self.voiceSlider.frame) + 20, kScreenWidth - 140, 20)];
    [self addSubview:self.playSlider];

    
    self.currentTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(self.voiceSlider.frame) + 20, 50, 20)];
    self.currentTimeLable.font = [UIFont systemFontOfSize:14];
    self.currentTimeLable.textColor = [UIColor orangeColor];
    self.currentTimeLable.text = @"00:00";
    [self addSubview:self.currentTimeLable];

    
    self.remainTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.playSlider.frame) + 10,CGRectGetMaxY(self.voiceSlider.frame) + 20, 50, 20)];
    self.remainTimeLable.font = [UIFont systemFontOfSize:14];
    self.remainTimeLable.text = @"00:00";
    self.remainTimeLable.textColor = [UIColor orangeColor];
    [self addSubview:self.remainTimeLable];
    
    
    
    
}

@end
