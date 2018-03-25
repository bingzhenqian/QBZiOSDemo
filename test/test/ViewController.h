//
//  ViewController.h
//  test
//
//  Created by qianbingzhen on 2018/3/20.
//  Copyright © 2018年 qian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong,setter=setObj:,getter=obj) NSObject *object;
//@property (nonatomic, strong) NSObject *_object;
@property (nonatomic, copy) NSString *title1;

@end

