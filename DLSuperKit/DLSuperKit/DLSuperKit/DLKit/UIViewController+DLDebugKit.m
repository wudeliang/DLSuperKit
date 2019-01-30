//
//  UIViewController+DLDebugKit.m
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/24.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import "UIViewController+DLDebugKit.h"
#import "DLSuperKitConfigue.h"

#import <objc/runtime.h>
#import "NSObject+DLKit.h"
@implementation UIViewController (DLDebugKit)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(dl_debug_viewDidAppear:);
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
    
}

-(void)dl_debug_viewDidAppear:(BOOL)animated{
    
    DLLog(@"当前控制器:%@",NSStringFromClass([self class]));
    if([DLSuperKitConfigue shareInstance].DLDebug_VCDidAppearLogSubView)[self.view dl_setAllSubviewsBorderRed];
    if([DLSuperKitConfigue shareInstance].DLDebug_VCDidAppearLogVCName)DLLog(@"当前控制器:%@",NSStringFromClass([self class]));
    if([DLSuperKitConfigue shareInstance].DLDebug_VCDidAppearLogSubView)DLLog(@"%@-subviews:%@",NSStringFromClass([self class]),[self.view dl_getAllSubviews]);
    if([DLSuperKitConfigue shareInstance].DLDebug_VCDidAppearLogSubViewTree)[self.view dl_logTreeBackBlock:^NSArray *{return @[@"frame",@"hidden",@"backgroundColor",@"userInteractionEnabled"];}];
}
@end
