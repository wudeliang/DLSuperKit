//
//  NSString+DLKit.m
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/23.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import "NSString+DLKit.h"
//用于获取mac地址
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
//用于获取ip地址
#import <ifaddrs.h>
#include <arpa/inet.h>
@implementation NSString (DLKit)


#pragma mark 字符串字符处理

/**
 *  字符串去除多余空格 净化字符串
 *
 */
+ (NSString *)dl_clearString:(NSString *)string
{
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *parts = [string componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    string = [filteredArray componentsJoinedByString:@" "];
    return string;
}
-(NSString *)dl_clearString{
    return  [NSString dl_clearString:self];
}

/**
 *  获取NSobject 的描述字符串
 *
 */
+ (NSString *)dl_objtString:(NSString *)obj
{
    NSString *string = [NSString stringWithFormat:@"%@",obj.description];
    string = [string stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    return string;
}

#pragma mark URL 编解码
/**
 字符串的url编码和解码
 
 @param string 编解码的字符串
 @return 编码完成的字符串
 */
+ (NSString *)dl_urlEncodeString:(NSString *)string
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)string,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",                                                              kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)dl_urlEncodedString
{
    return [NSString dl_urlEncodeString:self];
}

+ (NSString *)dl_urlDecodedString:(NSString *)string
{
    NSString *decodedString=(__bridge_transfer NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)string,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (NSString *)dl_urlDecodedString
{
    return [NSString dl_urlDecodedString:self];
}

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
                contentSringWidth:(CGFloat )contentWidth
{
    CGSize boundingSize = CGSizeMake(contentWidth ,MAXFLOAT);
    NSDictionary *attribute = @{NSFontAttributeName:font};
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    CGSize contentSize = [string boundingRectWithSize:boundingSize
                                              options:options
                                           attributes:attribute
                                              context:nil].size;
    return contentSize;
}

#pragma mark 沙盒路径
/**
 NSHomeDirectory 路径
 @return NSHomeDirectory 路径
 */
+ (NSString *)dl_homePath
{
    return NSHomeDirectory();
}
- (NSString *)dl_homePath
{
    return [NSString dl_homePath];
}

+ (NSString *)dl_appPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}
- (NSString *)dl_appPath
{
    return [NSString dl_appPath];
}

+ (NSString *)dl_documentsPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}
- (NSString *)dl_documentsPath
{
    return [NSString dl_documentsPath];
}

+ (NSString *)dl_libraryPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths.firstObject stringByAppendingFormat:@"/Preference"];
}

- (NSString *)dl_libraryPath
{
    return [NSString dl_libraryPath];
}

+(NSString *)dl_cachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths.firstObject stringByAppendingFormat:@"/Caches"];
}
- (NSString *)dl_cachePath
{
    return [NSString dl_cachePath];
}

+ (NSString *)dl_tmpPath
{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}
- (NSString *)dl_tmpPath
{
    return [NSString dl_tmpPath];
}

+ (BOOL)dl_existPath:(NSString *)path{
    if ( NO == [[NSFileManager defaultManager]fileExistsAtPath:path]){
        return [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return NO;
}
- (BOOL)dl_existPath{
    return [NSString dl_existPath:self];
    
}



/** 表情符号判断*/
+ (BOOL)dl_stringContainsEmoji:(NSString *)dlEmoji
{
    __block BOOL returnValue = NO;
    
    [dlEmoji enumerateSubstringsInRange:NSMakeRange(0, [dlEmoji length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        if (0x278b <= hs && hs <= 0x2792) {
                                            //自带九宫格拼音键盘
                                            returnValue = NO;;
                                        }else if (0x263b == hs) {
                                            returnValue = NO;;
                                        }else {
                                            returnValue = YES;
                                        }
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
    
}

/** 手机号判断*/
+ (BOOL)dl_stringMobilePhone:(NSString *)dlMobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|47|(3[5-9]|5[0127-9]|78|8[23478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,166
     17         */
    NSString * CU = @"^1(3[0-2]|45|5[256]|66|76|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181,180,177,153,133
     22         */
    NSString * CT = @"^1((33|7[079]|53|8[019])[0-9]|349)\\d{7}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:dlMobileNum] == YES)
        || ([regextestcm evaluateWithObject:dlMobileNum] == YES)
        || ([regextestct evaluateWithObject:dlMobileNum] == YES)
        || ([regextestcu evaluateWithObject:dlMobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


/** 数字必须2位小数点*/
+ (BOOL)dl_stingNumFloatTwo:(NSString *)dlFloat
{
    if (dlFloat.length)
    {
        unichar single = [dlFloat characterAtIndex:0]; // 当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.'){
            // 数据正确
            // 首位不能为小数点
            if (!dlFloat.length){
                // 还没有输入，首位
                if (single == '.'){
                    return NO;
                }else if(single == '0'){
                    return NO;
                }
                return YES;
            }else{
                // 不是首位，判断其他
                NSRange pointRange = [dlFloat rangeOfString:@"."];
                if (pointRange.length){
                    // 存在点，小数点之后2位
                    if (dlFloat.length - pointRange.location == 3 || single == '.'){
                        return NO;
                    }
                    return YES;
                }else{
                    // 不存在点
                    if (![dlFloat floatValue]){
                        // 等于0，只能输入点
                        if (single == '.'){
                            return YES;
                        }
                        return NO;
                    }else{
                        return YES;
                    }
                }
            }
        }
        return NO;
    }
    return YES;
}

/** 数字必须1位小数点*/
+ (BOOL)dl_stringNumFloatOne:(NSString *)dlFloat{
    if (dlFloat.length)
    {
        unichar single = [dlFloat characterAtIndex:0]; // 当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.'){
            // 数据正确
            // 首位不能为小数点
            if (!dlFloat.length){
                // 还没有输入，首位
                if (single == '.'){
                    return NO;
                }else if(single == '0'){
                    return NO;
                }
                return YES;
            }else{
                // 不是首位，判断其他
                NSRange pointRange = [dlFloat rangeOfString:@"."];
                if (pointRange.length){
                    // 存在点，小数点之后2位
                    if (dlFloat.length - pointRange.location == 2 || single == '.'){
                        return NO;
                    }
                    return YES;
                }else{
                    // 不存在点
                    if (![dlFloat floatValue]){
                        // 等于0，只能输入点
                        if (single == '.'){
                            return YES;
                        }
                        return NO;
                    }else{
                        return YES;
                    }
                }
            }
        }
        return NO;
    }
    return YES;
}


/**
 mac 地址

 @return 获取mac 地址
 */
+ (NSString *)dl_setMacAddress
{
    int                 mib[6];
    
    size_t              len;
    
    char                *buf;
    
    unsigned char       *ptr;
    
    struct if_msghdr    *ifm;
    
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    
    mib[1] = AF_ROUTE;
    
    mib[2] = 0;
    
    mib[3] = AF_LINK;
    
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        
        printf("Error: if_nametoindex error\n");
        
        return NULL;
        
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 1\n");
        
        return NULL;
        
    }
    
    if((buf = malloc(len)) == NULL) {
        
        printf("Could not allocate memory. Rrror!\n");
        
        return NULL;
        
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        
        printf("Error: sysctl, take 2");
        
        return NULL;
        
    }
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",*ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

/**
 获取ip 地址
 
 @return 返回ip 地址
 */
+ (NSString *)dl_getIPAddress
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 获取字符串中的数字
 
 @param dlstr 带数字的字符串
 @return 获取字符串中的数字
 */
+ (NSString *)dl_getNumberFormString:(NSString *)dlstr
{
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    return [[dlstr componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}

@end
