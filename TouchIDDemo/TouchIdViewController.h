//
//  TouchIdViewController.h
//  TouchIDDemo
//
//  Created by Bohan on 11/17/15.
//  Copyright © 2015 ChinaUMS. All rights reserved.
//

#import "ViewController.h"
#import "AuthenticationWithBiometrics.h"



@protocol TouchIdDelegate <NSObject>

- (void)authenticDidSuccess;

- (void)authenticDidFailWithInfo:(NSString *)info;

- (void) didCancel;

- (void)didSelecteCustomPassword;

@end

@interface TouchIdViewController : UIViewController

//String explaining why app needs authentication
@property (nonatomic, copy) NSString *strAuthReason;

@property (nonatomic, assign) id<TouchIdDelegate> delegate;

@end
