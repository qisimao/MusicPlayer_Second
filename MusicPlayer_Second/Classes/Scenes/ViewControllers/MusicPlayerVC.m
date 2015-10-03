//
//  MusicPlayerVC.m
//  MusicPlayer_Second
//
//  Created by 杨威 on 15/9/28.
//  Copyright (c) 2015年 Yoni. All rights reserved.
//

#import "MusicPlayerVC.h"
#import "MusicLyricManager.h"

@interface MusicPlayerVC ()<UITableViewDataSource,UITableViewDelegate,MusicPlayerManagerDeledate>
{
    NSInteger currentIndex;
}
@property(nonatomic,strong)MusicPlayerView *  musicPlayerView ;
@end

@implementation MusicPlayerVC

+(instancetype )shareManeger
{
    static  MusicPlayerVC * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc]init];
    });
    return manager;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (currentIndex == self.index) {
        [self updateUI];
        return;
    }else{
        currentIndex = self.index;
        [self updateUI];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [MusicPlayerManager shareManeger].delegate  = self;
    [self addSunViews];
}

#pragma mark - 刷新界面
-(void)updateUI
{
    //设置音乐播放器
    [[MusicPlayerManager shareManeger] playingWithUrl:self.model.mp3Url];
    
    //设置图片
    [self.musicPlayerView.musicPlayerImgView sd_setImageWithURL:[NSURL URLWithString:self.model.picUrl]];
    
    // 歌词
    [[MusicLyricManager shareManeger] formatLyricModelWithLyric:self.model.lyric];
    [self.musicPlayerView.lyricTableView reloadData];
    
    CGFloat duration = [self.model.duration floatValue]/1000;
    self.musicPlayerView.playSlider.maximumValue = duration;
}
-(void)addSunViews
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.musicPlayerView= [[MusicPlayerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.musicPlayerView];
    self.musicPlayerView.lyricTableView.dataSource = self;
    self.musicPlayerView.lyricTableView.delegate = self;
    [self.musicPlayerView.beforeBtn addTarget:self action:@selector(beforeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.musicPlayerView.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.musicPlayerView.nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.musicPlayerView.voiceSlider addTarget:self action:@selector(voiceSliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.musicPlayerView.playSlider addTarget:self action:@selector(playSliderAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 上一首
-(void)beforeBtnAction:(UIButton *)sender
{
    currentIndex -- ;
    if (currentIndex < 0) {
        currentIndex = [[MusicListManager shareManeger]getAllDataArrayCount] - 1;
    }
    [self updateUI];
}
#pragma mark - 播放 暂停
-(void)playBtnAction:(UIButton *)sender
{
    BOOL isPlaying = [[MusicPlayerManager shareManeger]musicPlayOrPause];
    if (isPlaying) {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }
}
#pragma mark - 下一首
-(void)nextBtnAction:(UIButton *)sender
{
    currentIndex ++;
    if (currentIndex > [[MusicListManager shareManeger]getAllDataArrayCount] - 1) {
        currentIndex = 0;
    }
    [self updateUI];
}

-(void)voiceSliderAction:(UISlider *)sender
{
    [MusicPlayerManager shareManeger].volum = sender.value;
}
#pragma mark - 快进快退方法
-(void)playSliderAction:(UISlider *)sender
{
    CGFloat dutation = [self.model.duration floatValue] / 1000;
    if (sender.value >= dutation) {
        return;
    }
    [[MusicPlayerManager shareManeger] musicSeekToPlay:sender.value];
}
#pragma mark - 根据下标取出数据模型
-(MusicListModel *)model
{
    MusicListModel * model = [[MusicListManager shareManeger] getMusicListModelAtIndex:currentIndex];
    return model;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[MusicLyricManager shareManeger] getLyricModelCount];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MusicPlayerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"musicPlayerCell"];
    }
    cell.lyricLable.text = [NSString stringWithFormat:@"%@",[[MusicLyricManager shareManeger] lyricAtIndex:indexPath.row]];
    
    // 选中
    UIView * selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectedView;
    cell.highlighted = YES;
    cell.lyricLable.highlightedTextColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMusicPlayerCell_luricLableHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat time = [[MusicLyricManager shareManeger]progressAtIndex:indexPath.row];
    [[MusicPlayerManager shareManeger]musicSeekToPlay:time];
    
}



#pragma mark - 代理方法
#pragma mark - MusicPlayHelper 代理方法
#pragma mark 播放过程中执行

-(void)playingWithProgress:(CGFloat)progress
{
    //1.图片旋转
    self.musicPlayerView.musicPlayerImgView.transform = CGAffineTransformRotate(self.musicPlayerView.musicPlayerImgView.transform, M_1_PI/180);
    //2.进度条
    self.musicPlayerView.playSlider.value = progress;
    //当期播放时间
    self.musicPlayerView.currentTimeLable.text =[self changeFormatWithTime:progress];
    //剩余时间
    CGFloat duration = [[self.model duration] floatValue]/1000;
    self.musicPlayerView.remainTimeLable.text = [self changeFormatWithTime:(duration - progress)];
    
    // 获取当前进度对应的下标
    NSInteger index = [[MusicLyricManager shareManeger]indexOfTime:progress];
    
    // 组拼  indexPath
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [self.musicPlayerView.lyricTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    
    
    
}


#pragma mark - 转换时间格式
-(NSString *)changeFormatWithTime:(CGFloat)time
{
    //计算分钟
    int minute = time/60;
    //计算秒
    int seconds = (int)time%60;
    
    NSString *timeFormat = [NSString stringWithFormat:@"%02d:%02d",minute,seconds];
    return timeFormat;
}








@end
