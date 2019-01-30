//
//  NSObject+DLKit.m
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/24.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import "NSObject+DLKit.h"

@implementation NSObject (DLKit)
/**
 *  快速创建实例
 */
+(instancetype)creatInstance{
    return [[[self class]alloc]init];
}
/**
 *  快速创建实例
 */
static id _shareInstance;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[[self class] alloc]init];
        
    });
    return _shareInstance;
}

@end
