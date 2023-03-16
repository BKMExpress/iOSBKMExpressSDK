## NE İŞE YARAR?
> BKM Express iOS SDK paketi, kullanıcının BKMExpress ile yapacağı ödemeler için, işyeri uygulamasından çıkmadan, kart eşleme, hızlı kart değiştirme ve güvenli ödeme yapma seçeneklerini sunmaktadır.

## SİSTEM GEREKSİNİMLERİ NELERDİR?

 *  iOS 9.0 ve üzeri versiyonlarda desteklenmektedir.
 *  iPhone cihazlar desteklenmektedir. 

## NASIL ÇALIŞIR?

BKM Express iOS SDK paketinin kullanılabilmesi için işyerleri BKM Express entegrasyonlarını tamamlaması gerekmektedir. Daha sonra işyeri servis uygulamaları BKMExpress core servislerine bağlanarak kendilerine verilen **TOKEN**'ı SDK tarafından sunulan methodlara parametrik olarak ileterek kart eşleştirme, değiştirme ve güvenli ödeme akışını başlatabilirler.

## ORTAMLAR

Kart eşleme paketi iki farklı ortamda çalışmaktadır. 
* PROD
* PREPROD

**Debug mod aktif edildiğinde SDK preprod ortamına bağlanacaktır. Aksi halde prod ortama bağlanacaktır.**

     [vc setEnableDebugMode:YES];

**NOT:** Entegrasyon sırasında işyerlerine verilen anahtarların sorumluluğu, **işyerine** aittir.



### IOS OBJECTIVE-C SDK ENTEGRASYONU

* SDK Cocoapods kullanılarak aşağıdaki komut ile projeye eklenmelidir.

        pod 'BKMExpressSDK', '1.2.10'

* BKMExpress SDK arayüzlerinden geri haber alabilmek için kullandığınız akışa göre BKMExpressPairingDelegate, BKMExpressPaymentDelegate ve BKMExpressOTPVerifyDelegate protokollerinin kullanılması gerekmektedir.


### BKMExpressPairingDelegate

    -  (void)bkmExpressPairingDidComplete:(NSString *)first6Digits withLast2Digits:(NSString *)last2Digits; //Success 

    -  (void)bkmExpressPairingDidCancel; //Cancel

    -  (void)bkmExpressPairingDidFail:(NSError *)error; //Fail

### BKMExpressPaymentDelegate

    -  (void)bkmExpressPaymentDidCompleteWithPOSResult:(BKMPOSResult *)posResult; //Success 

    -  (void)bkmExpressPaymentDidCancel; //Cancel

    -  (void)bkmExpressPaymentDidFail:(NSError *)error; //Fail

### BKMExpressOTPVerifyDelegate

    -  (void)bkmExpressOTPVerified; //Success 

    -  (void)bkmExpressOTPCanceled; //Cancel

    -  (void)bkmExpressOTPFailed:(NSError *)error; //Fail    


### ÖRNEK OBJECTIVE-C ÖDEME AKIŞI KULLANIMI
      

    #define PAYMENT_TOKEN @"Payment token will be given by BKM after the merchant integration"

    @interface ViewController () <BKMExpressPaymentDelegate>
  
    - (IBAction)tapPaymentButton:(id)sender {
       BKMExpressPaymentViewController *vc = [[BKMExpressPaymentViewController alloc] initWithPaymentToken:PAYMENT_TOKEN delegate:self];
       // YES:PreProd, NO:Prod
       [vc setEnableDebugMode:YES];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
       [self presentViewController:vc animated:YES completion:nil];
    }

    #pragma Payment delegate methods

    - (void)bkmExpressPaymentDidCompleteWithPOSResult:(BKMPOSResult *)posResult{
       NSLog(@"Successful payment");
    }

    - (void)bkmExpressPaymentDidFail:(NSError *)error{
       NSLog(@"An error has occurred on payment = %@", error.localizedDescription);
    }

    - (void)bkmExpressPaymentDidCancel{
       NSLog(@"Payment is canceled by user");
    }


### ÖRNEK EŞLEŞME AKIŞI KULLANIMI
      
    #define QUICK_PAY_TOKEN @"Quick pay token will be given by BKM after the merchant integration"
    #define PAIRING_TICKET @"Ticket will be given by BKM after the merchant integration"
    
    @interface ViewController () <BKMExpressPairingDelegate>

    - (IBAction)tapPairButton:(id)sender {
       BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithToken:QUICK_PAY_TOKEN delegate:self];
        // YES:PreProd, NO:Prod
       [vc setEnableDebugMode:YES];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
       [self presentViewController:vc animated:YES completion:nil];
    }
    
    - (IBAction)tapChangeCardButton:(id)sender {
       BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithTicket:PAIRING_TICKET withDelegate:self];
       [vc setEnableDebugMode:NO];
       [self presentViewController:vc animated:YES completion:nil];
    }

    #pragma Pairing delegate methods

     - (void)bkmExpressPairingDidComplete:(NSString *)first6Digits withLast2Digits:(NSString *)last2Digits;{
        NSLog(@"%@",[NSString stringWithFormat:@"it was paired successfully the card which first six digit is %@ and last   two number is %@", first6Digits, last2Digits]);
    }
    
    - (void)bkmExpressPairingDidFail:(NSError *)error{
        NSLog(@"An error has occurred on card pairing = %@",error.localizedDescription);
    }

    - (void)bkmExpressPairingDidCancel{
        NSLog(@"Card pairing is canceled by user");
    }

### ÖRNEK OTP'Lİ HIZLI ÖDEME DOĞRULAMA AKIŞI KULLANIMI
      
    #define kOTP_PAYMENT_VERIFY_TICKET  @"OTP Payment ticket will be given by BKM after the merchant integration"
    
    @interface ViewController () <BKMExpressOTPVerifyDelegate>

    - (IBAction)tapOTPPaymentButton:(id)sender {
       BKMExpressOTPVerifyController *vc = [[BKMExpressOTPVerifyController alloc] initWithTicket:kOTP_PAYMENT_VERIFY_TICKET withDelegate:self];
        // YES:PreProd, NO:Prod
       [vc setEnableDebugMode:YES];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
       [self presentViewController:vc animated:YES completion:nil];
    }
    
	#pragma Otp payment verification delegate methods

	- (void)bkmExpressOTPVerified {
	     NSLog(@"Successful OTP payment verification");
	}

	- (void)bkmExpressOTPCanceled {
	     NSLog(@"OTP Payment verification is canceled by user");
	}

	- (void)bkmExpressOTPFailed:(NSError *)error {
	     NSLog(@"An error has occurred on payment = %@", error.localizedDescription);
	}




### IOS SWIFT SDK ENTEGRASYONU

* SDK Cocoapods kullanılarak aşağıdaki komut ile projeye eklenmelidir.

        pod 'BKMExpressSDK', '1.2.10'

* Objective C ile geliştiren SDK'yı kullanabilmek icin Bridge yapılmalıdır. Aşağıdaki adreste daha detaylı bilgiler bulabilirsiniz:
  https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html

* BKMExpress SDK arayüzlerinden geri haber alabilmek için BKMExpressPairingDelegate ve BKMExpressPaymentDelegate protokollerinin kullanılması gerekmektedir.


### BKMExpressPaymentDelegate

    -  func bkmExpressPaymentDidComplete(with posResult: BKMPOSResult!); //Success 

    -  func bkmExpressPaymentDidCancel(); //Cancel

    -  func bkmExpressPaymentDidFail(_ error: Error!) { //Fail


### ÖRNEK SWIFT ÖDEME AKIŞI KULLANIMI
      
    let kQUICK_PAY_TOKEN:String = "Quick pay token will be given by BKM after the merchant integration"
    let kPAYMENT_TOKEN:String = "Payment token will be given by BKM after the merchant integration"

    class ViewController: UIViewController , BKMExpressPaymentDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        let instanceOfCustomObject: BKMExpressPaymentViewController = BKMExpressPaymentViewController(paymentToken: kPAYMENT_TOKEN, delegate: self)

        // True:PreProd, False:Prod
        instanceOfCustomObject.setEnableDebugMode(true)
        instanceOfCustomObject.modalPresentationStyle = .fullScreen
        
        self.present(instanceOfCustomObject , animated:true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bkmExpressPaymentDidComplete(with posResult: BKMPOSResult!) {
        NSLog("Successful payment with POS message")
    }
    
    func bkmExpressPaymentDidFail(_ error: Error!) {
        NSLog("An error has occurred on payment %@", error.localizedDescription)
    }
    
    func bkmExpressPaymentDidCancel() {
        NSLog("Payment is cancelled by user")
    }
