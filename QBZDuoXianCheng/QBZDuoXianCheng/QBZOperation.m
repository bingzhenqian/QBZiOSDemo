//
//  QBZOperation.m
//  QBZDuoXianCheng
//
//  Created by qianbingzhen on 2018/3/1.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "QBZOperation.h"

@implementation QBZOperation
-(void)main
{
    for(int i = 0;i<2;i++)
    {
        NSLog(@"%d    %@",i,[NSThread currentThread]);
    }
}
@end
