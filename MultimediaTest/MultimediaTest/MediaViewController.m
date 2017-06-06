//
//  MediaViewController.m
//  MultimediaTest
//
//  Created by qianbingzhen on 2017/6/6.
//  Copyright © 2017年 qian. All rights reserved.
//

#import "MediaViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface MediaViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSURL *medioURL;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) AVPlayerViewController *playerViewController;
@end

@implementation MediaViewController
- (AVPlayerViewController *)playerViewController
{
    if(_playerViewController == nil)
    {
        _playerViewController = [[AVPlayerViewController alloc] init];
        _playerViewController.player = [[AVPlayer alloc] initWithURL:medioURL];

    }
    return _playerViewController;
}

- (UIImagePickerController *)imagePickerController
{
    if(_imagePickerController == nil)
    {
        _imagePickerController = [[UIImagePickerController alloc] init];
        //采集源数据类型
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //媒体类型
        _imagePickerController.mediaTypes = @[(__bridge NSString *)kUTTypeImage,(__bridge NSString *)kUTTypeMovie];
        //视频质量
        _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}
- (IBAction)collectionPic:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取媒体类型
    NSString *type = info[UIImagePickerControllerMediaType];
    if([type isEqualToString:(__bridge NSString *)kUTTypeMovie])
    {
        medioURL = info[UIImagePickerControllerMediaURL];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)play:(id)sender {
    [self presentViewController:self.playerViewController animated:YES completion:nil];
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
