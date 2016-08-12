#import "ViewController.h"
#import "BKMExpressPairViewController.h"

#define BKM_EXPRESS_SDK_API_KEY @"given by BKM"
#define TOKEN @"token will be taken after the merchant integration"

@interface ViewController () <BKMExpressPairingDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)tapLoginButton:(id)sender {
    BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithToken:TOKEN withApiKey:BKM_EXPRESS_SDK_API_KEY delegate:self];
    [vc setEnableDebugMode:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma Pairing delegate methods

- (void)bkmExpressDidCompletePairing{
}

- (void)bkmExpressDidCancel{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end