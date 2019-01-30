//
//  NSString+DLKit.h
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/23.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (DLKit)

#pragma mark 字符串字符处理
/**
 *  字符串去除多余空格 净化字符串
 *
 */
+ (NSString *)dl_clearString:(NSString *)string;
- (NSString *)dl_clearString;

/**
 *  获取NSobject 的描述字符串
 *
 */
+ (NSString *)dl_objtString:(NSString *)obj;

#pragma mark URL 编解码
/**
 字符串的url编码和解码

 @param string 编解码的字符串
 @return 编码完成的字符串
 */
+ (NSString *)dl_urlEncodeString:(NSString *)string;
@property(nonatomic,copy,readonly)NSString *dl_urlEncodedString;

+ (NSString *)dl_urlDecodedString:(NSString *)string;
@property(nonatomic,copy,readonly)NSString *dl_urlDecodedString;

#pragma mark 字符串尺寸
/**
 获取字符串的 CGSize

 @param font 字符串字体大小
 @param string 内容字符串
 @param contentWidth 字符串的宽度
 @return 字符串size
 */
+ (CGSize)dl_stringSizeWithUIFont:(UIFont *)font
                           string:(NSString *)string
                contentSringWidth:(CGFloat )contentWidth;

#pragma mark 沙盒路径
/**
 NSHomeDirectory 路径
 @return NSHomeDirectory 路径
 */
+ (NSString *)dl_homePath;
@property (nonatomic, copy, readonly)NSString *dl_homePath;

+ (NSString *)dl_appPath;
@property (nonatomic, copy, readonly)NSString *dl_appPath;

+ (NSString *)dl_documentsPath;
@property (nonatomic, copy, readonly)NSString *dl_documentsPath;

+ (NSString *)dl_libraryPath;
@property (nonatomic, copy, readonly)NSString *dl_libraryPath;

+ (NSString *)dl_cachePath;
@property (nonatomic, copy, readonly)NSString *dl_cachePath;

+ (NSString *)dl_tmpPath;
@property (nonatomic, copy, readonly)NSString *dl_tmpPath;

+ (BOOL)dl_existPath:(NSString *)path;
@property (nonatomic, assign, readonly)BOOL dl_existPath;


#pragma mark 正则表达
/** 表情符号判断*/
+ (BOOL)dl_stringContainsEmoji:(NSString *)dlEmoji;

/** 手机号判断*/
+ (BOOL)dl_stringMobilePhone:(NSString *)dlMobileNum;

/** 数字必须2位小数点*/
+ (BOOL)dl_stingNumFloatTwo:(NSString *)dlFloat;

/** 数字必须1位小数点*/
+ (BOOL)dl_stringNumFloatOne:(NSString *)dlFloat;


/**
 获取设备mac 地址
 @return mac 地址
 */
+ (NSString *)dl_setMacAddress;

/**
 获取ip 地址
 @return 返回ip 地址
 */
+ (NSString *)dl_getIPAddress;

/**
 获取字符串中的数字
 @param dlstr 带数字的字符串
 @return 获取字符串中的数字
 */
+ (NSString *)dl_getNumberFormString:(NSString *)dlstr;


@end

NS_ASSUME_NONNULL_END
