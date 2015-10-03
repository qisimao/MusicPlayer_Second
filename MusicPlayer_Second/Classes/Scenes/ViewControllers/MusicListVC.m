//
//  MusicListVC.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicListVC.h"

@interface MusicListVC ()
@property(nonatomic,strong)NSArray * allDataArray;
@end

@implementation MusicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MusicListManager shareManeger] requestDataForReloadWithBlock:^(NSArray *array) {
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[MusicListManager shareManeger]getAllDataArrayCount];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"musicListCell"];
    if (!cell) {
        cell = [[MusicListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"musicListCell"];
    }
    cell.model =  [[MusicListManager shareManeger]getMusicListModelAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicPlayerVC * vc = [MusicPlayerVC shareManeger];
    vc.index = indexPath.row;
    [self.navigationController pushViewController:vc animated:NO];
}


@end
