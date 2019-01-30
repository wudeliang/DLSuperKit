//
//  UIView+DLUIDevKit.m
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/23.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import "UIView+DLUIDevKit.h"

@implementation UIView (DLUIDevKit)

/**
 打印所有子视图
 block 回传需要打印的View的属性名列表
 @return 打印信息字典
 */
- (NSDictionary *)dl_logTreeBackBlock:(DLLogTreeBackBlock)block
{
    NSArray *ps = block();
    if (ps == nil || ps.count == 0) {
        ps = @[@"frame",@"hidden",@"backgroundColor",@"userInteractionEnabled"];
    }
    DLLogTreeContainer *container = [DLLogTreeContainer initWithView:self];
    NSDictionary *log = [container dlDescriptionContainer:ps];
    DLLog(@"\n\n\n\n\n%@\n\n\n\n\n",log);
    return log;
}

#pragma mark 视图操作
/**
 获取所有子视图
 
 @return 返回所有子视图
 */
- (NSMutableArray *)dl_getAllSubviews
{
    NSMutableArray *allSubviews = [NSMutableArray array];
    NSMutableArray *curSubviews = [NSMutableArray arrayWithArray:self.subviews];
    while (curSubviews.count!=0) {
        NSMutableArray *temSubviews = [NSMutableArray array];
        for (UIView *view in curSubviews) {
            [allSubviews addObject:view];
            if (view.subviews.count !=0) {
                [temSubviews addObjectsFromArray:view.subviews];
            }
        }
        [curSubviews removeAllObjects];
        [curSubviews addObjectsFromArray:temSubviews];
    }
    [allSubviews addObject:self];
    return allSubviews;
}

/**
 设置所有子视图随机色
 @param alpha 随机透明度
 @return 所有子视图
 */
- (NSMutableArray *)dl_setAllSubviewsBackgroundColorRandom:(CGFloat)alpha
{
    NSMutableArray *allSubviews = [self dl_getAllSubviews];
    for (UIView *view in allSubviews) {
        if ([view respondsToSelector:@selector(setBackgroundColor:)]) {
            view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0
                                                   green:arc4random()%255/255.0
                                                    blue:arc4random()%255/255.0
                                                   alpha:alpha];
        }
    }
    return allSubviews;
}

/**
 为所有子视图加上border red
 @return 所有带border 的子视图
 */
- (NSMutableArray *)dl_setAllSubviewsBorderRed
{
    NSMutableArray *allSubviews = [self dl_getAllSubviews];
    for (UIView *view in allSubviews) {
        if ([view isKindOfClass:[UIView class]]) {
            view.layer.borderColor = [UIColor redColor].CGColor;
            view.layer.borderWidth = 1.0;
        }
    }
    return allSubviews;
}

/**
 获取所有父视图
 @return 所有父视图集合
 */
- (NSMutableArray *)dl_getAllSuperViews
{
    NSMutableArray *allSuperviews = [NSMutableArray array];
    UIView *tmpView = self;
    while (tmpView.superview) {
        [allSuperviews addObject:tmpView.superview];
        tmpView = tmpView.superview;
    }
    return allSuperviews;
}

/**
 设置所有父视图为随机色
 @param alpha 随机透明度
 @return 所有的父视图
 */
- (NSMutableArray *)dl_setallSuperViewsBackgroundColorRandom:(CGFloat)alpha
{
    NSMutableArray *allSuperviews = [self dl_getAllSuperViews];
    for (UIView *view in allSuperviews) {
        if ([view respondsToSelector:@selector(setBackgroundColor:)]) {
            view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0
                                                   green:arc4random()%255/255.0
                                                    blue:arc4random()%255/255.0
                                                   alpha:alpha];
            view.layer.borderColor = [UIColor redColor].CGColor;
            view.layer.borderWidth = 1.0;
        }
    }
    return allSuperviews;
}

/**
 在所有子视图中获取视图树最上层的一个类型的View
 @param cls view 类型
 @return 获取到的View
 */
- (UIView *)dl_getSubviewOfClass:(Class)cls
{
    NSMutableArray *subs = [NSMutableArray arrayWithArray:self.subviews];
    while (subs.count) {
        NSArray *subsTmp = [NSArray arrayWithArray:subs];
        [subs removeAllObjects];
        for (UIView *subview in subsTmp) {
            if ([subview isKindOfClass:cls]) {
                return subview;
            }
            [subs addObjectsFromArray:subview.subviews];
        }
    }
    return nil;
}

/**
 获取上层控制器
 @return 获取到的控制器
 */
- (UIViewController *)dl_getSuperController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end


@implementation DLLogTreeContainer

+ (instancetype)initWithView:(UIView *)view
{
    DLLogTreeContainer *treeView = [[DLLogTreeContainer alloc]init];
    treeView.view = view;
    [treeView doWithSubViews];
    return treeView;
}

- (void)doWithSubViews
{
    [self.subviews removeAllObjects];
    NSArray *subviews = self.view.subviews;
    for (UIView *subview in subviews) {
        DLLogTreeContainer *container = [DLLogTreeContainer initWithView:subview];
        [self.subviews addObject:container];
    }
}

- (NSMutableDictionary *)dlDescriptionContainer:(NSArray *)propertyKeys
{
    [self.desCache removeAllObjects];
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithCapacity:propertyKeys.count];
    for (NSString *pkey in propertyKeys) {
        id pvalue = @"";
        @try {
            pvalue = [self.view valueForKey:pkey];
        } @catch (NSException *exception) {
            pvalue = [NSString stringWithFormat:@"unknow key(%@) for class(%@)",pkey,self.view];
        } @finally {
            if (pvalue == nil)pvalue = @"null";
        }
        [properties setObject:pvalue forKey:pkey];
    }
    NSMutableArray *subviews = [NSMutableArray arrayWithCapacity:self.subviews.count];
    for (DLLogTreeContainer *subview in self.subviews) {
        NSMutableDictionary *dic = [subview dlDescriptionContainer:propertyKeys];
        [subviews addObject:dic];
    }
    
    [self.desCache setObject:properties forKey:@"properties"];
    [self.desCache setObject:subviews forKey:@"subviews"];
    
    NSMutableDictionary *front = [NSMutableDictionary dictionary];
    [front setObject:self.desCache forKey:NSStringFromClass([self.view class])];
    return front;
}

-(NSMutableDictionary *)desCache
{
    if (_desCache == nil) {
        _desCache = [NSMutableDictionary dictionary];
    }
    return _desCache;
}
-(NSMutableArray *)subviews
{
    if (_subviews == nil) {
        _subviews = [NSMutableArray arrayWithCapacity:5];
    }
    return _subviews;
}

@end


