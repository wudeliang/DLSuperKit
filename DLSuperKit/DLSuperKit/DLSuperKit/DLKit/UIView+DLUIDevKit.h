//
//  UIView+DLUIDevKit.h
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/23.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLSuperKitConst.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSArray *(^DLLogTreeBackBlock)(void);

@interface UIView (DLUIDevKit)

#pragma mark 打印视图树状图

/**
 打印所有子视图
 block 回传需要打印的View的属性名列表
 @return 打印信息字典
 */
- (NSDictionary *)dl_logTreeBackBlock:(DLLogTreeBackBlock)block;

#pragma mark 视图操作
/**
 获取所有子视图

 @return 返回所有子视图
 */
- (NSMutableArray *)dl_getAllSubviews;


/**
 设置所有子视图随机色
 @param alpha 随机透明度
 @return 所有子视图
 */
- (NSMutableArray *)dl_setAllSubviewsBackgroundColorRandom:(CGFloat)alpha;

/**
 为所有子视图加上border red
 @return 所有带border 的子视图
 */
- (NSMutableArray *)dl_setAllSubviewsBorderRed;

/**
 获取所有父视图
 @return 所有父视图集合
 */
- (NSMutableArray *)dl_getAllSuperViews;


/**
 设置所有父视图为随机色
 @param alpha 随机透明度
 @return 所有的父视图
 */
- (NSMutableArray *)dl_setallSuperViewsBackgroundColorRandom:(CGFloat)alpha;


/**
 在所有子视图中获取视图树最上层的一个类型的View
 @param cls view 类型
 @return 获取到的View
 */
- (UIView *)dl_getSubviewOfClass:(Class)cls;

/**
 获取上层控制器
 @return 获取到的控制器
 */
- (UIViewController *)dl_getSuperController;

@end


@interface DLLogTreeContainer : NSObject
@property (nonatomic,strong)UIView *view;
@property (nonatomic,strong)NSMutableDictionary *properties;
@property (nonatomic,strong)NSMutableArray      *subviews;
@property (nonatomic,strong)NSMutableDictionary *desCache;

+(instancetype)initWithView:(UIView *)view;
- (NSMutableDictionary *)dlDescriptionContainer:(NSArray *)propertyKeys;

@end


NS_ASSUME_NONNULL_END
