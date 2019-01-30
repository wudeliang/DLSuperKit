//
//  NSObject+DLKit.h
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/24.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLSuperKitConst.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DLKit)
/**
 *  快速创建实例
 */
+(instancetype)creatInstance;
/**
 *  快速创建实例
 */
+(instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
