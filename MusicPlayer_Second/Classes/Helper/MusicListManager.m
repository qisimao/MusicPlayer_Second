//
//  MusicListManager.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicListManager.h"

@interface MusicListManager ()
@property(nonatomic,strong)NSMutableArray * allDataArray;
@end

@implementation MusicListManager

#pragma mark - 单例实现
+(instancetype )shareManeger
{
    static  MusicListManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc]init];
    });
    return manager;
}
#pragma mark - 数据请求 用block进行回调
-(void)requestDataForReloadWithBlock:(void(^)())block
{
    // NSArray * array
    // 创建子线程 做数据解析
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 通过接口 获取数据  用数组接收
        NSArray * array =  [NSArray arrayWithContentsOfURL:[NSURL URLWithString:kMusicPlayerUrl]];
        // 遍历数组
        for (NSDictionary * dic in array) {
            MusicListModel * model = [[MusicListModel alloc]init];
            // model 赋值
            [model setValuesForKeysWithDictionary:dic];
            // 存入数组
            [self.allDataArray addObject:model];
        }
        // 回到主线程做结果回调
        dispatch_async(dispatch_get_main_queue(), ^{
            block(array);
        });
    });
}

#pragma mark ——通过下标获取数据模型
-(MusicListModel *)getMusicListModelAtIndex:(NSInteger)index
{
    MusicListModel * model = self.allDataArray[index];
    return model;
}
#pragma mark - 获取有多少条数据
-(NSInteger)getAllDataArrayCount
{
    return self.allDataArray.count;
}
-(NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}
@end





