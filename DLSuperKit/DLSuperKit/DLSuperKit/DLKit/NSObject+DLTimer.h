//
//  NSObject+DLTimer.h
//  DLSuperKit
//
//  Created by 武得亮 on 2019/1/25.
//  Copyright © 2019 武得亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DLTimerDelegate <NSObject>

@required
-(void)timerRun:(NSTimer *)timer target:(id)tareget;

@end


@interface NSObject (DLTimer)





@end

NS_ASSUME_NONNULL_END
