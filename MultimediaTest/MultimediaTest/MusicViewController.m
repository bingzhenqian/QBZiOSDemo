//
//  MusicViewController.m
//  MultimediaTest
//
//  Created by qianbingzhen on 2017/6/6.
//  Copyright © 2017年 qian. All rights reserved.
//

#import "MusicViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface MusicViewController ()<AVAudioPlayerDelegate,AVAudioRecorderDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (weak, nonatomic) IBOutlet UIButton *playerButton;

@end

@implementation MusicViewController
- (AVAudioPlayer *)audioPlayer
{
    if(_audioPlayer == nil)
    {
        
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record"];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        NSLog(@"时长 %f",_audioPlayer.duration);
        _audioPlayer.delegate = self;
        [_audioPlayer prepareToPlay];
    }
    NSLog(@"时长 %f",_audioPlayer.duration);

    return  _audioPlayer;
}
- (AVAudioRecorder *)recorder
{
    if(_recorder == nil)
    {
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record"];
        NSMutableDictionary *setting = [[NSMutableDictionary alloc] initWithCapacity:1];
        //采样率 赫兹
        [setting setValue:[NSNumber numberWithInt:44100] forKey:AVSampleRateKey];
        //录音格式
        [setting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        //录音通道
        [setting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        //录音质量
        [setting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
        //采样位数
        [setting setValue:[NSNumber numberWithInt:8] forKey:AVLinearPCMBitDepthKey];
        //必须
        [setting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        //必须
        [setting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];

//        NSMutableDictionary *recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
//                               [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
//                               [NSNumber numberWithInt:1000.0],AVSampleRateKey,
//                               [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
//                               [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
//                               [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
//                               [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
//                               nil];
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:setting error:nil];
        _recorder.delegate = self;
        [_recorder prepareToRecord];
    }
    return  _recorder;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)record:(id)sender {
    UIButton *button = (UIButton *)sender;
    if(button.selected == YES){
        [self.recorder stop];
        button.selected = NO;
    }else{
        [self.recorder record];
        button.selected = YES;

    }
}
- (IBAction)play:(id)sender {
    UIButton *button = (UIButton *)sender;
    if(button.selected == YES){
        [self.audioPlayer stop];
        button.selected = NO;
    }else{
        [self.audioPlayer play];
        button.selected = YES;
    }
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    _playerButton.selected = NO;
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    
}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record"]];
    NSLog(@"%@",data);
    NSLog(@"%lu",(unsigned long)data.length);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
