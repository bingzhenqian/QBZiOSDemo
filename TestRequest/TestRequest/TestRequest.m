//
//  TestRequest.m
//  TestRequest
//
//  Created by qianbingzhen on 2018/3/14.
//  Copyright © 2018年 qian. All rights reserved.
//http://www.cnblogs.com/wendingding/p/5168772.html

//https://www.jianshu.com/p/056b1817d25a  NSURLSession与NSURLConnection区别
/*
    NSURLSessionTask
    子类：
    NSURLSessionDataTask
    NSURLSessionDownloadTask
    NSURLSessionStreamTask
 */
#import "TestRequest.h"
#import <UIKit/UIKit.h>
@interface TestRequest()<NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
{
    NSMutableData *resultData;
}
@end
@implementation TestRequest
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getRequest
{
    //请求路径
    NSString *webPath = [NSString stringWithFormat:@"http://gc.ditu.aliyun.com/geocoding?a=泰州市"];
    //路径中的中文做处理
    webPath = [webPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:webPath];
    //创建请求对象
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    //获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //根据会话对象创建task
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil){
            //解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
        }
    }];
    //执行
    [dataTask resume];
}

- (void)postRequest
{
    //请求路径
    NSString *webPath = [NSString stringWithFormat:@"http://gc.ditu.aliyun.com/geocoding"];
    //对路径中中文做处理
    webPath = [webPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:webPath];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求类型，参数
    request.HTTPMethod = @"post";
    request.HTTPBody = [@"a=台州市" dataUsingEncoding:NSUTF8StringEncoding];
    //获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //根据会话对象创建task
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil){
            //解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
        }

    }];
    //执行任务
    [dataTask resume];
}

- (void)downloadRequest
{
    //请求路径
    NSURL *url = [NSURL URLWithString:[@"http://ftp.blizzard.com/pub/starcraft/patches/Mac/StarCraft_v116_OSX.zip" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    //创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //创建会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
     //根据会话对象创建一个Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
    
    
}

#pragma mark - Delegate
//1.接收到服务器响应的时候调用该方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    //在该方法中可以得到响应头信息，即response
    //注意：需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    NSLog(@"becomeload");
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    if(!resultData)
    {
        resultData = [[NSMutableData alloc] initWithCapacity:1];
    }
    [resultData appendData:data];
    NSLog(@"接受数据");
    NSLog(@"%f",[resultData length]/1024.0/1024.0);
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    if(error ==nil)
    {
        NSLog(@"%f",[resultData length]/1024.0);
    }
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler
{
    
}


@end






























