//
//  MusicPlayerView.h
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayerView : UIView

//滚动试图
@property(nonatomic,strong)UIScrollView * backScrollView;

// 播放图片
@property(nonatomic,strong)UIImageView * musicPlayerImgView;

// 歌词展示
@property(nonatomic,strong)UITableView * lyricTableView;

// 播放暂停
@property(nonatomic,strong)UIButton * playBtn;

// 上一首
@property(nonatomic,strong)UIButton * beforeBtn;

// 下一首
@property(nonatomic,strong)UIButton * nextBtn;
// 声音
@property(nonatomic,strong)UISlider * voiceSlider;
// 播放进度
@property(nonatomic,strong)UISlider * playSlider;

// 当前播放时间
@property(nonatomic,strong)UILabel * currentTimeLable;

// 剩余时间
@property(nonatomic,strong)UILabel * remainTimeLable;




@end
