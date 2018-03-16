//
//  DownLoadTestViewController.m
//  TestRequest
//
//  Created by qianbingzhen on 2018/3/16.
//  Copyright © 2018年 qian. All rights reserved.
//https://www.jianshu.com/p/01390c7a4957
//https://www.jianshu.com/p/5a07352e9473
//https://www.jianshu.com/p/ce3eaee74bde

#import "DownLoadTestViewController.h"

@interface DownLoadTestViewController ()<NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

/*
    NSURLSession断点下载
 */
//下载任务
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
//上次下载信息
@property (nonatomic, strong) NSData *resumeData;
//session
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation DownLoadTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
    dataWithContentsOfURL直接下载
 */
- (void)downloadPicWithData
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://news.youth.cn/yl/201601/W020160121370177246745.jpg"]];
    _imageView.image = [UIImage imageWithData:data];
}

/*
    NSURLsession下载
 */
- (IBAction)downloadPicWithSession:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://news.youth.cn/yl/201601/W020160121370177246745.jpg"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *newFilePath = [documentsPath stringByAppendingPathComponent:response.suggestedFilename];
        [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:newFilePath error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageView.image = [UIImage imageWithContentsOfFile:newFilePath];
        });
        
    }];
    [task resume];
}

/*
 NSURLsession下载 并监听下载速度
 */
- (IBAction)downloadPicWithSessionAndSee:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://news.youth.cn/yl/201601/W020160121370177246745.jpg"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url];
    [task resume];
}
#pragma mark - NSURLSessionDownloadDelegate
//文件下载完毕使用
- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *newFilePath = [documentsPath stringByAppendingPathComponent:@"qq.dmg"];
    NSLog(@"%@",newFilePath);
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:newFilePath error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = [UIImage imageWithContentsOfFile:newFilePath];
    });
}
//每次下载数据
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //下载进度
    self.progress.progress = 1.0*totalBytesWritten/totalBytesExpectedToWrite;
}
//恢复下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

/*
    NSURLSession断点下载
 */
- (IBAction)downloadPicWithSessionContinue:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if(self.downloadTask == nil)
    {
        if(self.resumeData)
        {
            self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
            [self.downloadTask resume];
            
        }else{
            //初次下载
            NSURL *url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg"];
            self.downloadTask = [self.session downloadTaskWithURL:url];
            [self.downloadTask resume];
        }
    }else{//暂停下载
        __weak typeof(self) weakself = self;
        [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            weakself.resumeData = resumeData;
            weakself.downloadTask = nil;
        }];
    }
}

- (NSURLSession *)session
{
    if(!_session)
    {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
@end
