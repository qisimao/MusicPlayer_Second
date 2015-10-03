//
//  MusicListModel.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicListModel.h"

@implementation MusicListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID  = value;
    }
}

@end
