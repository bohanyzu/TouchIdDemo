//
//  AuthenticationWithBiometrics.h
//  TouchIDDemo
//
//  Created by Bohan on 11/17/15.
//  Copyright © 2015 ChinaUMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SHOW_PASSWORD_INPUT_TAG @"User selected to enter custom password"

typedef void (^AuthenticationWithBiometricsBlock)(BOOL isSuccess, NSString *errorInfo);




@interface AuthenticationWithBiometrics : NSObject

+(BOOL) isAuthenticationWithBiometricsEnable;



/*!
 @method
 @abstract   TouchID验证
 @discussion
 @param msg String explaining why app needs authentication
 @param block 回调block
 @result     void
 */
+ (void)evaluateMessage:(NSString *)msg withBlock:(AuthenticationWithBiometricsBlock)block;

/*!
 @method
 @abstract   是否越狱
 @discussion
 @result     BOOL
 */
+ (BOOL)isJailBreak;
@end
