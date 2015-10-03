//
//  MusicListCell.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicListCell.h"

@implementation MusicListCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews
{
    self.musicListImgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 100, 100)];
    [self addSubview:self.musicListImgView];
    
    self.musicListSingLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.musicListImgView.frame) + 20, 20, kScreenWidth - self.musicListImgView.frame.size.width - 20, 20)];
    self.musicListSingLable.text = @"李白";
    [self addSubview:self.musicListSingLable];
    
    self.musicListSingerLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.musicListImgView.frame) + 20, CGRectGetMaxY(self.musicListSingLable.frame) + 20, kScreenWidth - self.musicListImgView.frame.size.width - 20 , 20)];
    self.musicListSingerLable.text = @"李荣浩";
    [self addSubview:self.musicListSingerLable];
}

-(void)setModel:(MusicListModel *)model
{
   // cell控件赋值
   [self.musicListImgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
   self.musicListSingLable.text = [NSString stringWithFormat:@"%@",model.name];
   self.musicListSingerLable.text = [NSString stringWithFormat:@"%@",model.singer];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
