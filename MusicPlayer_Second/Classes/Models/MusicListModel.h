//
//  MusicListModel.h
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicListModel : NSObject

@property (nonatomic, copy) NSString *mp3Url;   // 音乐地址
@property (nonatomic, copy) NSString *ID;       // 应为id
@property (nonatomic, copy) NSString *name;     // 歌名
@property (nonatomic, copy) NSString *picUrl;   // 图片地址
@property (nonatomic, copy) NSString *blurPicUrl;   // 模糊图片地址
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *singer;   // 歌手
@property (nonatomic, copy) NSString *duration; // 时间
@property (nonatomic, copy) NSString *artists_name; // 歌手名字
@property (nonatomic, copy) NSString *lyric;    // 歌词


@end
