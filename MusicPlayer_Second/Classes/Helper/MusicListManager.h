//
//  MusicListManager.h
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicListManager : NSObject
// 单例声明
+(instancetype )shareManeger;
// 数据请求 ， 结果回调
-(void)requestDataForReloadWithBlock:(void(^)())block;
// NSArray * array

// 通过 下标获取  数据模型
-(MusicListModel *)getMusicListModelAtIndex:(NSInteger )index;

// 获取有多少条数据
-(NSInteger)getAllDataArrayCount;


@end
