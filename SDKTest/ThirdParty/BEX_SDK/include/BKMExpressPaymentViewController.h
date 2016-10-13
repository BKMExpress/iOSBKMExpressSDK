//
//  BKMExpressPaymentViewController.h
//  BKMExpressSDK
//
//  Created by Kadir Guzel on 8/18/16.
//  Copyright © 2016 Bankalararası Kart Merkezi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BKMExpressPaymentDelegate <NSObject>

@required
- (void)bkmExpressPaymentDidComplete;
- (void)bkmExpressPaymentDidCancel;
- (void)bkmExpressPaymentDidFail:(NSError *)error;

@end

@interface BKMExpressPaymentViewController : UINavigationController

@property (nonatomic, weak, readonly) id<BKMExpressPaymentDelegate> paymentDelegate;

-(void)setEnableDebugMode:(BOOL)isEnableDebugMode;

- (instancetype)initWithPaymentToken:(NSString *)token withApiKey:(NSString *)apiKey  delegate:(id<BKMExpressPaymentDelegate>)delegate;

@end
