//
//  ViewController.m
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/23.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import "ViewController.h"
#import "DLSuperKit/DLKit/DLKit.h"
@interface ViewController ()

@property(nonatomic,strong)UIView *testview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.testview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:self.testview];
//    [self.view dl_logTreeBackBlock:^NSArray *{
//        /**
//         *  这里返回你要在视图tree里面显示的视图属性,返回nil则默认打印 @[@"frame",@"hidden",@"backgroundColor",@"userInteractionEnabled"]
//         */
//        return @[@"frame",@"hidden",@"backgroundColor",@"userInteractionEnabled"];
//    }];
    /** 为所有子视图添加border*/
   
    [self.testviews dl_logTreeBackBlock:^NSArray *{
        return nil;
    }];
    [self.testview dl_setAllSubviewsBackgroundColorRandom:1];
   
    [self.testviews dl_setAllSubviewsBorderRed];
    
    
    

}


@end
