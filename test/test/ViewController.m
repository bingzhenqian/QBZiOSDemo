//
//  ViewController.m
//  test
//
//  Created by qianbingzhen on 2018/3/20.
//  Copyright © 2018年 qian. All rights reserved.
//

#import "ViewController.h"
#import "Son.h"
#import <CommonCrypto/CommonCrypto.h>

@interface ViewController ()
@property (nonatomic, assign) int a;
@property (nonatomic, weak) NSNumber *b;
@property (nonatomic, assign) NSUInteger c;
@property (nonatomic, strong) NSString *str1;
@property (nonatomic, copy) NSString *str2;
@property (nonatomic, strong) NSArray *arr1;
@property (nonatomic, copy) NSArray *arr2;
@property (nonatomic, strong) NSDictionary *dic1;
@property (nonatomic, copy) NSDictionary *dic2;

@property (nonatomic, copy) NSMutableArray *arr3;

@end

@implementation ViewController{
//    NSString *_title;
}
@synthesize title1 = _title1;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableString *mstr = [NSMutableString stringWithString:@"abcdefg"];
    self.str1 = mstr;
    self.str2 = mstr;
    [mstr appendString:@"hijklmn"];
    NSLog(@"self.str1  %@  \n self.str2 %@",_str1,_str2);
    
    NSMutableArray *marr = [NSMutableArray arrayWithObjects:@1,@2,@3, nil];
    self.arr1 = marr;
    self.arr2 = marr;
    [marr addObject:@4];
    NSLog(@"self.arr1  %@  \n self.arr2 %@",self.arr1,self.arr2);

    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"one",@1,@"two",@2, nil];
    self.dic1 = mdic;
    self.dic2 = mdic;
    [mdic setObject:@"three" forKey:@3];
    NSLog(@"self.dic1  %@  \n self.dic2 %@",self.dic1,self.dic2);
    
    self.arr3 = marr;
    NSLog(@"self.arr3  %@  ",self.arr3);

//    NSString *stringg = [NSString stringWithFormat:@"123"];
//    NSString *stringg1 = [stringg copy];
//    NSString *stringg2 = [stringg mutableCopy];
//    NSLog(@"string %@  \n  string1 %@  \n  string2 %@",stringg,stringg1,stringg2);
//    stringg = [NSString stringWithFormat:@"1234"];
//    NSLog(@"string %@  \n  string1 %@  \n  string2 %@",stringg,stringg1,stringg2);
//    NSMutableString *string = [NSMutableString stringWithFormat:@"123"];
//    NSMutableString *string1 = [string copy];
//    NSMutableString *string2 = [string mutableCopy];
    
    NSArray *array = @[@[@"a", @"b"], @[@"c", @"d"]];
    NSArray *copyArray = [array copy];
    NSMutableArray *mCopyArray = [array mutableCopy];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *ar = nil;
    [ar count];
 
    [[Son alloc] init];
    [self willChangeValueForKey:@"now"];
    [self didChangeValueForKey:@"now"];
    NSString *str111 = @"123";
    NSData *data = [str111 dataUsingEncoding:NSUTF8StringEncoding];
    NSString  *str = [data base64EncodedDataWithOptions:0];
    
    NSData *deData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSString *sre = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
}
- (NSString *)md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)title1 {
    return _title1;
}

- (void)setTitle1:(NSString *)title {
    _title1 = [title copy];
}



@end
