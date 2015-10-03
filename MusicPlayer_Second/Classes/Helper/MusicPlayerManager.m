//
//  MusicPlayerManager.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/29.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicPlayerManager.h"

@interface MusicPlayerManager ()
{
    BOOL isPlaying;
}
@property(nonatomic,strong)NSTimer * timer;
@end

@implementation MusicPlayerManager

+(instancetype )shareManeger
{
    static  MusicPlayerManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc]init];
        manager.player = [[AVPlayer alloc]init];
        manager.player.volume = 1;
    });
    return manager;
}

#pragma mark - 根据Url设置播放
-(void)playingWithUrl:(NSString *)url
{
    AVPlayerItem * items = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:url]];
    
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    // 添加观察者
    [items addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.player replaceCurrentItemWithPlayerItem:items];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        NSLog(@"%@",change);
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        
        switch (status) {
            case AVPlayerItemStatusUnknown:
                NSLog(@"未知错误");
                break;
             
            case AVPlayerItemStatusFailed:
                NSLog(@"失败");
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准备播放");
                [self musicPlay];
                break;
            default:
                break;
        }
    }
}


#pragma mark - 播放
-(void)musicPlay
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playingAction) userInfo:nil repeats:YES];
    isPlaying = YES;
    [self.player play];
}
#pragma mark - 暂停
-(void)musicPause
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    isPlaying = NO;
    [self.player pause];
}

#pragma mark - 播放状态切换
-(BOOL)musicPlayOrPause
{
    if (isPlaying) {
        [self musicPause];
        return NO;
    }else{
        [self musicPlay];
        return YES;
    }
}


#pragma mark - 音量键的set和 get方法
-(void)setVolum:(CGFloat)volum
{
    self.player.volume = volum;
}

-(CGFloat)volum
{
    return self.player.volume;
}

#pragma mark - 设置在某一个时间点播放
-(void)musicSeekToPlay:(CGFloat)time
{
    [self musicPause];
    [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        if (finished) {
            [self musicPlay];
        }
    }];
}


#pragma mark - 私有方法
#pragma mark - 播放过程中执行
-(void)playingAction
{
    CGFloat time = self.player.currentTime.value / self.player.currentTime.timescale;
    // 把当前播放时间(进度)给音乐播放界面
    if (self.delegate && [self.delegate performSelector:@selector(playingWithProgress:)]) {
        [self.delegate playingWithProgress:time];
    }
}












@end
