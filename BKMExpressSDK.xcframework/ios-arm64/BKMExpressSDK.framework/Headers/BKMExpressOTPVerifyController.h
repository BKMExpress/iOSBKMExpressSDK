//
//  BKMExpressOTPVerifyController.h
//  BKMExpressSDK
//
//  Created by Kadir Guzel on 5.04.2021.
//  Copyright © 2021 BEX IOS SDK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BKMExpressOTPVerifyDelegate <NSObject>

@required
- (void)bkmExpressOTPVerified;
- (void)bkmExpressOTPCanceled;
- (void)bkmExpressOTPFailed:(NSError *) error;
@end


@interface BKMExpressOTPVerifyController : UINavigationController

@property (nonatomic, weak, readonly) id<BKMExpressOTPVerifyDelegate> otpVerifyDelegate;

- (void)setEnableDebugMode:(BOOL)isEnableDebugMode;

- (instancetype)initWithTicket:(NSString *)ticket withDelegate:(id<BKMExpressOTPVerifyDelegate>)delegate;

@end

