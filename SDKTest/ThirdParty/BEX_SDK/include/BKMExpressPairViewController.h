//
//  BKMExpressPairViewController.h
//  BKMExpressSDK
//
//  Created by BKM
//  Copyright © 2016 Bankalararası Kart Merkezi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BKMExpressPairingDelegate <NSObject>

@required
- (void)bkmExpressDidCompletePairing;
- (void)bkmExpressDidCancel;

@end

@interface BKMExpressPairViewController : UINavigationController

@property (nonatomic, weak, readonly) id<BKMExpressPairingDelegate> pairingDelegate;

-(void)setEnableDebugMode:(BOOL)isEnableDebugMode;

- (instancetype)initWithToken:(NSString *)token withApiKey:(NSString *)apiKey  delegate:(id<BKMExpressPairingDelegate>)delegate;

@end
