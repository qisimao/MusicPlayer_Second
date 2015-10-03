//
//  MusicListCell.h
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicListModel;

@interface MusicListCell : UITableViewCell
// 图片
@property(nonatomic,strong)UIImageView * musicListImgView;
// 歌曲名称
@property(nonatomic,strong)UILabel * musicListSingLable;
// 歌手名字
@property(nonatomic,strong)UILabel * musicListSingerLable;
// 当前cell的model
@property(nonatomic,strong)MusicListModel * model;

@end
