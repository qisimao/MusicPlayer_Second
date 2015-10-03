//
//  MusicLyricManager.h
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/10/1.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicLyricManager : NSObject

// 声明 单例
+(instancetype )shareManeger;


// 格式化歌词  创建歌词模型 并且存放进数组当中
-(void)formatLyricModelWithLyric:(NSString *)lyric;

// 返回模型长度
-(NSInteger)getLyricModelCount;

// 根据下标取出当前歌词
-(NSString *)lyricAtIndex:(NSInteger)index;

// 根据时间返回下标
-(NSInteger)indexOfTime:(CGFloat)time;


// 根据下标指定播放进度
-(CGFloat)progressAtIndex:(NSInteger)index;


@end
