//
//  MusicLyricManager.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/10/1.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicLyricManager.h"
#import "MusicLyricModel.h"

@interface MusicLyricManager ()
@property(nonatomic,strong)NSMutableArray * allLyricModelArray;
@end

@implementation MusicLyricManager

+(instancetype )shareManeger
{
    static  MusicLyricManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc]init];
        manager.allLyricModelArray =  [NSMutableArray array];
    });
    return manager;
}

#pragma mark - 格式化歌词模型 
-(void)formatLyricModelWithLyric:(NSString *)lyric
{
    // 先移除数组中的元素
    [self.allLyricModelArray removeAllObjects];
    
    // 根据 换行符"\n" 切分
    NSArray * array = [lyric componentsSeparatedByString:@"\n"];
    
    // 遍历歌词数组 格式化歌词 组装模型 并存储到数组当中
    
    for (int i = 0; i < array.count - 1; i++) {
        
        //获得每一行的歌词
        NSString * str = array[i];
        
        // 根据 "]"来拆分 时间 和  歌词
        NSArray * array1 = [str componentsSeparatedByString:@"]"];
        
#pragma mark - 如果字符串长度小于1 直接跳出
        if ([array1.firstObject length] < 1) {
            break;
        }
        
        // 时间 格式为"[00:4523" 所以需要从1开始获取
        NSString * timeStr = [array1.firstObject substringFromIndex:1];
        
        // 时间格式为 00:4523 所以去掉":"
        NSArray * timeArray = [timeStr componentsSeparatedByString:@":"];
        
        // 算出总时间 以 秒 为  单位
        CGFloat totalTime = [timeArray.firstObject floatValue] * 60 + [timeArray.lastObject floatValue];
        
        // 歌词
        NSString * lyricStr = array1.lastObject;
        
        // 初始化歌词数据模型
        MusicLyricModel * model = [[MusicLyricModel alloc]init];
        
        // 歌词时间
        model.time = totalTime;
        
        // 歌词
        model.lyric = lyricStr;
        
        // 存入数组
        [self.allLyricModelArray addObject:model];
    }
}


#pragma mark - 返回当前歌词数组模型的长度
-(NSInteger)getLyricModelCount
{
    return self.allLyricModelArray.count;
}

#pragma mark -  根据下标取出当前歌词
-(NSString *)lyricAtIndex:(NSInteger)index
{
    MusicLyricModel * model = [self.allLyricModelArray objectAtIndex:index];
    return model.lyric;
}


#pragma mark - 根据时间返回下标  
-(NSInteger)indexOfTime:(CGFloat)time
{
    NSInteger index = 0;
    for (int i = 0; i < self.allLyricModelArray.count - 1; i++) {
        MusicLyricModel * model = self.allLyricModelArray[i];
        if (model.time > time) {
            index = i - 1 > 0? i - 1 :0;
            break;
        }
    }
    return index;
}


#pragma mark - 根据下标指定播放进度
-(CGFloat)progressAtIndex:(NSInteger)index
{
    MusicLyricModel * model = self.allLyricModelArray[index];
    CGFloat time = model.time;
    return time;
}













@end






