//
//  AuthenticationWithBiometrics.m
//  TouchIDDemo
//
//  Created by Bohan on 11/17/15.
//  Copyright © 2015 ChinaUMS. All rights reserved.
//

#import "AuthenticationWithBiometrics.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation AuthenticationWithBiometrics

+ (BOOL) isAuthenticationWithBiometricsEnable
{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (void)evaluateMessage:(NSString *)msg withBlock:(AuthenticationWithBiometricsBlock)block
{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:msg
                            reply:^(BOOL success, NSError *error) {
                                
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        block(YES, @"");
                                    });
                                } else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                    NSString *errorInfo;
                                    // Error codes
                                    //#define kLAErrorAuthenticationFailed                       -1
                                    //#define kLAErrorUserCancel                                 -2
                                    //#define kLAErrorUserFallback                               -3
                                    //#define kLAErrorSystemCancel                               -4
                                    //#define kLAErrorPasscodeNotSet                             -5
                                    //#define kLAErrorTouchIDNotAvailable                        -6
                                    //#define kLAErrorTouchIDNotEnrolled                         -7
                                    //#define kLAErrorTouchIDLockout                             -8
                                    //#define kLAErrorAppCancel                                  -9
                                    //#define kLAErrorInvalidContext                            -10
                                    switch (error.code) {
                                        case LAErrorAuthenticationFailed:
                                        {
                                            errorInfo = @"认证失败";
                                            break;
                                        }
                                        case LAErrorUserCancel:
                                        {
                                            errorInfo =  @"用户取消验证Touch ID";
                                            //用户取消验证Touch ID
                                            break;
                                        }
                                        case LAErrorSystemCancel:
                                        {
                                            errorInfo = @"认证中断";
                                            break;
                                        }
                                        case LAErrorTouchIDLockout:
                                        {
                                            errorInfo = @"要输入passcode才能启用touchId";
                                            break;
                                        }
                                        case LAErrorUserFallback:
                                        {
                                            errorInfo = SHOW_PASSWORD_INPUT_TAG;
                                            break;
                                        }
                                        case LAErrorAppCancel:
                                        {
                                            errorInfo = @"Touch ID繁忙，请稍后重试";
                                            break;
                                        }
                                        case LAErrorInvalidContext:
                                        {
                                            errorInfo = @"内部错误，请重试";
                                            break;
                                        }
                                        default:
                                        {
                                            errorInfo = @"未知错误，请重试";
                                            break;
                                        }
                                            
                                    }
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        if (error.code == LAErrorTouchIDLockout) {
                                            [AuthenticationWithBiometrics evaluateMessage:msg withBlock:block];
                                        }
                                        else
                                        {
                                            block(NO, errorInfo);
                                        }
                                    });
                                }
                                
                            }];
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
        NSString *errorInfo;
        switch (authError.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                errorInfo = @"没有录入指纹";
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                errorInfo = @"没有设置passcode";
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                errorInfo = @"TouchID不可用";
                NSLog(@"TouchID not available");
                break;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(NO, errorInfo);});
    }
}

@end
