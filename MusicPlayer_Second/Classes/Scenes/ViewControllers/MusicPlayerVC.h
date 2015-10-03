//
//  MusicPlayerVC.h
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayerVC : UIViewController


+(instancetype )shareManeger;


// 数据模型下标
@property(nonatomic,assign)NSInteger index;

// 当前播放的model
@property(nonatomic,strong)MusicListModel * model;


@end
