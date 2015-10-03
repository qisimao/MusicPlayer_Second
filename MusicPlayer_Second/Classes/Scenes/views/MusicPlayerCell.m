//
//  MusicPlayerCell.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/29.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicPlayerCell.h"

@implementation MusicPlayerCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews
{
    self.lyricLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kMusicPlayerCell_luricLableHeight)];
    self.lyricLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lyricLable];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
