//
//  UINavigationController+DLKit.h
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/25.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (DLKit)



/**
 Description pop 到指定控制器

 @param cls 控制器的class
 @param animated 是否动画
 */
- (BOOL)dl_popToClass:(Class)cls animated:(BOOL)animated;
+ (BOOL)dl_popToClass:(Class)cls animated:(BOOL)animated nav:(UINavigationController *)nav;


@end

NS_ASSUME_NONNULL_END
