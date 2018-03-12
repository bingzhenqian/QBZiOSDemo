//
//  QBZClientViewController.m
//  AsyncSocketTest
//
//  Created by qianbingzhen on 2018/3/6.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "QBZClientViewController.h"
#import "GCDAsyncSocket.h"
@interface QBZClientViewController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *hostTextField;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
@property (weak, nonatomic) IBOutlet UITextView *sendOrReadTextView;

@property (weak, nonatomic) IBOutlet UITextView *receiveTextView;

@property (nonatomic,strong) GCDAsyncSocket *clientSocket;
@property (nonatomic,strong) NSTimer *timer;//心跳包
@end

@implementation QBZClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)connect:(id)sender
{
    //链接socket服务
    NSError *error = nil;
    BOOL result = [self.clientSocket connectToHost:_hostTextField.text onPort:[_portTextField.text integerValue] error:&error];
    result?NSLog(@"链接成功"):NSLog(@"链接失败");
}

-(IBAction)sendMessage:(id)sender
{
    NSData *data = [_sendOrReadTextView.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];

}

- (IBAction)disconnect:(id)sender
{
    [self.clientSocket disconnect];
}


- (void)addTimer
{
    //每隔5秒，发送心跳包，保活
    _timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(jump) userInfo:nil repeats:YES];
    [_timer fire];
}

-(void)jump
{
    //心跳包
    NSData *data = [@"xintiao" dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];

}
#pragma mark - GCDAsyncSocketDelegate
//链接成功回调
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    
    NSLog(@"链接成功");
    NSLog([NSString stringWithFormat:@"host地址%@ 端口%d",host,port]);
    [self addTimer];
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
//读取服务端信息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到信息");
    NSLog(@"%@", [NSString stringWithFormat:@"host 链接地址%@   端口%d   信息",sock.connectedHost,sock.connectedPort,string]);
    _receiveTextView.text = [NSString stringWithFormat:@"客户端 链接地址%@   端口%d   信息%@",sock.connectedHost,sock.connectedPort,string];

    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
//断开链接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"链接断开");
    self.clientSocket.delegate = nil;
    self.clientSocket = nil;
    [_timer invalidate];
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
- (GCDAsyncSocket *)clientSocket
{
    if(!_clientSocket)
    {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _clientSocket;
}
@end
