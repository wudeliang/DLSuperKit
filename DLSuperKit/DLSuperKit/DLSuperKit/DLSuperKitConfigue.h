//
//  DLSuperKitConfigue.h
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/24.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DLKit.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLSuperKitConfigue : NSObject



/**
 * 调试工具配置
 * 调试时，打印NSArray是否将里面的中文转码至显示
 */
@property(nonatomic,assign) BOOL DLDebug_NSArrayLogChinese;

/**
 * 调试工具配置
 * 调试时，打印NSDictionary 是否将里面的中文转码至显示
 */
@property(nonatomic,assign) BOOL DLDebug_NSDictionaryLogChinese;

/**
 * 调试工具配置
 * 调试时,在viewDidAppear中是否让view的子视图显示随机色
 */
@property(nonatomic,assign) BOOL DLDebug_VCDidAppearSubViewRandomColor;

/**
 * 调试工具配置
 * 调试时,在viewDidAppear中是否让view的子视图显示边框
 */
@property(nonatomic,assign) BOOL DLDebug_VCDidAppearSubViewDisplayBorder;

/**
 * 调试工具配置
 * 调试时,在viewDidAppear中是否打印控制器名称
 */
@property(nonatomic,assign) BOOL DLDebug_VCDidAppearLogVCName;

/**
 * 调试工具配置
 * 调试时,在viewDidAppear中是否打印view所有子视图
 */
@property(nonatomic,assign) BOOL DLDebug_VCDidAppearLogSubView;

/**
 * 调试工具配置
 * 调试时,在viewDidAppear中是否打印view视图树结构
 */
@property(nonatomic,assign) BOOL DLDebug_VCDidAppearLogSubViewTree;


@end


NS_ASSUME_NONNULL_END
