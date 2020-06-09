//
//  ViewController.m
//  BKMExpressSDK
//
//  Created by BKM
//  Copyright © 2016-2018 Bankalararası Kart Merkezi. All rights reserved.
//

#import "ViewController.h"
#import <BKMExpressSDK/BKMExpressSDK.h>

#define kQUICK_PAY_TOKEN     @"Quick pay token will be given by BKM after the merchant integration"
#define kPAIRING_TICKET      @"Ticket will be given by BKM after the merchant integration"
#define kPAYMENT_TOKEN       @"Payment token will be given by BKM after the merchant integration"

@interface ViewController () <BKMExpressPairingDelegate,BKMExpressPaymentDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)tapPairButton:(id)sender {
    BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithToken:kQUICK_PAY_TOKEN delegate:self];
    [vc setEnableDebugMode:NO];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)tapChangeCardButton:(id)sender {
    BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithTicket:kPAIRING_TICKET withDelegate:self];
    [vc setEnableDebugMode:NO];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma Pairing delegate methods

- (void)bkmExpressPairingDidComplete:(NSString *)first6Digits withLast2Digits:(NSString *)last2Digits{
    NSLog(@"%@",[NSString stringWithFormat:@"it was paired successfully the card which first six digit is %@ and last two number is %@", first6Digits, last2Digits]);
}

- (void)bkmExpressPairingDidFail:(NSError *)error{
    NSLog(@"An error has occurred on card pairing = %@",error.localizedDescription);
}

- (void)bkmExpressPairingDidCancel{
    NSLog(@"Card pairing is canceled by user");
}

- (IBAction)tapPaymentButton:(id)sender {
    BKMExpressPaymentViewController *vc = [[BKMExpressPaymentViewController alloc] initWithPaymentToken:kPAYMENT_TOKEN delegate:self];
    [vc setEnableDebugMode:YES];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma Payment delegate methods

- (void)bkmExpressPaymentDidCompleteWithPOSResult:(BKMPOSResult *)posResult{
    NSLog(@"Successful payment with POS message");
}

- (void)bkmExpressPaymentDidCancel{
    NSLog(@"Payment is canceled by user");
}

- (void)bkmExpressPaymentDidFail:(NSError *)error{
    NSLog(@"An error has occurred on payment = %@", error.localizedDescription);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
