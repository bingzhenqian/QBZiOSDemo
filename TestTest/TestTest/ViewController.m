//
//  ViewController.m
//  TestTest
//
//  Created by qianbingzhen on 2018/3/9.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressed:(id)sender {
    NSLog(@"button pressed");
    sleep(5);
    [self performSegueWithIdentifier:@"detail" sender:nil];
}

@end
