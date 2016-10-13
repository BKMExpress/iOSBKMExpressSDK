#import "ViewController.h"
#import "BKMExpressPairViewController.h"
#import "BKMExpressPaymentViewController.h"


#define BKM_EXPRESS_SDK_API_KEY @"given by BKM"
#define QUICK_PAY_TOKEN @"Quick pay token will be given by BKM after the merchant integration"
#define PAYMENT_TOKEN @"Payment token will be given by BKM after the merchant integration"

@interface ViewController () <BKMExpressPairingDelegate,BKMExpressPaymentDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)tapLoginButton:(id)sender {
    BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithToken:QUICK_PAY_TOKEN withApiKey:BKM_EXPRESS_SDK_API_KEY delegate:self];
    [vc setEnableDebugMode:YES];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma Pairing delegate methods

- (void)bkmExpressPairingDidComplete{
    NSLog(@"Card pairing is success");
}

- (void)bkmExpressPairingDidFail:(NSError *)error{
    NSLog(@"An error has occurred on card pairing = %@",error.localizedDescription);
}

- (void)bkmExpressPairingDidCancel{
    NSLog(@"Card pairing is canceled by user");
}


- (IBAction)tapPaymentButton:(id)sender {
    BKMExpressPaymentViewController *vc = [[BKMExpressPaymentViewController alloc] initWithPaymentToken:PAYMENT_TOKEN withApiKey:BKM_EXPRESS_SDK_API_KEY delegate:self];
    [vc setEnableDebugMode:YES];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma Payment delegate methods

- (void)bkmExpressPaymentDidComplete{
    NSLog(@"Successful payment");
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
