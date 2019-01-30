//
//  UINavigationController+DLKit.m
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/25.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import "UINavigationController+DLKit.h"

@implementation UINavigationController (DLKit)

/**
 Description pop 到指定控制器
 
 @param cls 控制器的class
 @param animated 是否动画
 */
+ (BOOL)dl_popToClass:(Class)cls animated:(BOOL)animated nav:(UINavigationController *)nav
{
    for (UIViewController *vc in nav.viewControllers) {
        if ([vc isKindOfClass:cls]) {
            [nav popToViewController:vc animated:animated];
            return YES;
        }
    }
    return NO;
}

- (BOOL)dl_popToClass:(Class)cls animated:(BOOL)animated
{
    return [UINavigationController dl_popToClass:cls animated:animated nav:self];
}

@end


