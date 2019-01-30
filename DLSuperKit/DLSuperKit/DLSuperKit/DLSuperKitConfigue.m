//
//  DLSuperKitConfigue.m
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/24.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import "DLSuperKitConfigue.h"

@implementation DLSuperKitConfigue
/**
 * 配置初值
 *
 */
-(instancetype)init{
    if (self = [super init]) {
#ifdef DEBUG
        /**
         * 调试工具配置
         * 调试时,打印NSArray是否将里面的中文转码至显示
         */
        self.DLDebug_NSArrayLogChinese = YES;
        
        /**
         * 调试工具配置
         * 调试时,打印NSDictionary是否将里面的中文转码至显示
         */
        self.DLDebug_NSDictionaryLogChinese = YES;
       
        /**
         * 调试工具配置
         * 调试时,在viewDidAppear中是否让view的子视图显示随机色
         */
        self.DLDebug_VCDidAppearSubViewRandomColor = NO;
       
        /**
         * 调试工具配置
         * 调试时,在viewDidAppear中是否让view的子视图显示边框
         */
        self.DLDebug_VCDidAppearSubViewDisplayBorder = NO;
       
        /**
         * 调试工具配置
         * 调试时,在viewDidAppear中是否打印控制器名称
         */
        self.DLDebug_VCDidAppearLogVCName = YES;
       
        /**
         * 调试工具配置
         * 调试时,在viewDidAppear中是否打印view所有子视图
         */
        self.DLDebug_VCDidAppearLogSubView = NO;
      
        /**
         * 调试工具配置
         * 调试时,在viewDidAppear中是否打印view视图树结构
         */
        self.DLDebug_VCDidAppearLogSubViewTree = NO;
        
#endif
    }
    return self;
}

@end
