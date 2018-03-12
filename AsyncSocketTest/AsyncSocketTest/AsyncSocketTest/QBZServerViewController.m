//
//  QBZServerViewController.m
//  AsyncSocketTest
//
//  Created by qianbingzhen on 2018/3/6.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "QBZServerViewController.h"
#import "GCDAsyncSocket.h"
@interface QBZServerViewController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
@property (weak, nonatomic) IBOutlet UITextView *sendTextView;
@property (weak, nonatomic) IBOutlet UITextView *receiveTextView;
@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
@property (nonatomic, strong) NSMutableArray *socketArray;
@end

@implementation QBZServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _socketArray = [NSMutableArray arrayWithCapacity:1];
    // Do any additional setup after loading the view.
}

#pragma mark - IBAction
- (IBAction)accept:(id)sender
{
    //开启socket服务 Port 端口号
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:[_portTextField.text integerValue] error:&error];
    result?NSLog(@"开启成功"):NSLog(@"开启失败");

}

- (IBAction)sendMessage:(id)sender
{
    
    [self sendMessage:_sendTextView.text socket:nil :sender];
}

- (void)sendMessage:(NSString *)str socket:(GCDAsyncSocket *)newSocket :(id)sender
{
    if(!str){
        str = @"123";
    }
    //将数据转化为二进制
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    if(newSocket)
    {
        //把数据发送给newSocket
        [newSocket writeData:data withTimeout:-1 tag:0];
        return;
    }else{
        [_socketArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [(GCDAsyncSocket *)obj writeData:data withTimeout:-1 tag:0];
        }];
    }
    
}

#pragma mark - GCDAsyncSocketDelegate
//有新的socket链接
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    [_socketArray addObject:newSocket];
    NSLog(@"链接成功");
    NSLog(@"%@", [NSString stringWithFormat:@"客户端 链接地址%@   端口%d",newSocket.connectedHost,newSocket.connectedPort]);
    //链接之后开始读取数据
    [newSocket readDataWithTimeout:-1 tag:0];
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到信息");
    NSLog(@"%@", [NSString stringWithFormat:@"客户端 链接地址%@   端口%d   信息%@",sock.connectedHost,sock.connectedPort,string]);
    _receiveTextView.text = [NSString stringWithFormat:@"客户端 链接地址%@   端口%d   信息%@",sock.connectedHost,sock.connectedPort,string];
    //读取下一次数据 -1表示一直等待数据
    [sock readDataWithTimeout:-1 tag:0];
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

- (GCDAsyncSocket *)serverSocket
{
  if(!_serverSocket)
  {
      _serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
  }
    return _serverSocket;
}
@end
