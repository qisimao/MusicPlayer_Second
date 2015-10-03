//
//  MusicPlayerManager.h
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/29.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MusicPlayerManagerDeledate <NSObject>

// 播放过程中执行  params :播放时间 进度
-(void)playingWithProgress:(CGFloat)progress;

@end


@interface MusicPlayerManager : NSObject

// 设置代理属性
@property (nonatomic, assign) id<MusicPlayerManagerDeledate> delegate;

// 声明单例
+(instancetype )shareManeger;

// 播放器
@property(nonatomic,strong)AVPlayer * player;

// 声音值
@property(nonatomic,assign)CGFloat volum;


// 根据Url设置播放
-(void)playingWithUrl:(NSString *)url;

// 开始播放
-(void)musicPlay;

// 暂停播放
-(void)musicPause;

// 播放状态切换
-(BOOL)musicPlayOrPause;

// 设置在某一个时间播放
-(void)musicSeekToPlay:(CGFloat)time;


@end
