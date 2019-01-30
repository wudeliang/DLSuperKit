//
//  NSArray+DLLogChinese.m
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/25.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import "NSArray+DLLogChinese.h"
#import <objc/runtime.h>
#import "DLSuperKitConfigue.h"
@implementation NSArray (DLLogChinese)


+(void)load
{
    if ([DLSuperKitConfigue shareInstance].DLDebug_NSArrayLogChinese) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class cls = [self class];
            SEL originalSelector = @selector(descriptionWithLocale:);
            SEL swizzledSelector = @selector(dl_descriptionWithLocale:);
            Method originalMethod = class_getInstanceMethod(cls, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
            method_exchangeImplementations(originalMethod, swizzledMethod);
        });
    }
}


/**
 网络json 文件终端输出文字

 @param locale 输出文字格式
 @return 输出文字
 */
-(NSString *)dl_descriptionWithLocale:(id)locale{
    NSString *dataString = nil;
    @try {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
        dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        dataString = nil;
    } @finally {
        if (dataString) {
            return dataString;
        }
        return [self dl_descriptionWithLocale:locale];
    }
}

@end

