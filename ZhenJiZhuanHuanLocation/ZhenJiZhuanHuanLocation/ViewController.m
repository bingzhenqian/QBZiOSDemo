//
//  ViewController.m
//  ZhenJiZhuanHuanLocation
//
//  Created by qianbingzhen on 2018/3/13.
//  Copyright © 2018年 qian. All rights reserved.
//
#import "ViewController.h"
#import "QBZlocationTransform.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    QBZlocationTransform *gdLocation = [[QBZlocationTransform alloc]initWithLatitude:23.132295 andLongitude:113.32254];
    QBZlocationTransform *iosLocation = [gdLocation transformFromGDToGPS];
    NSLog(@"转化后肯德基iOS坐标:%f, %f", iosLocation.latitude, iosLocation.longitude);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
