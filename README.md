##NE İŞE YARAR?
> BKM Express iOS SDK paketi, kullanıcının BKMExpress ile yapacağı ödemeler için, işyeri uygulamasından çıkmadan, kart eşleme ve güvenli ödeme yapma seçeneklerini sunmaktadır.

##SİSTEM GEREKSİNİMLERİ NELERDİR?

 *  Min iOS-7 desteklenmektedir.
 *  iPhone cihazlar desteklenmektedir. 

##NASIL ÇALIŞIR?

Işyerleri BKM Express entegrasyonlarını tamamlayarak gerekli **API Key**lerini almalıdırlar. Bu API Key daha sonra
BKM Express iOS SDK paketinin kullanılabilmesi için gerekmektedir. İşyeri servis uygulamaları, BKMExpress core servislerine bağlanarak kendileri için hazırlanan **TOKEN**'ı ve **API Key**'i sunulan methodlara parametrik olarak ileterek, kart eşleştirme ve güvenli ödeme akışını başlatabilirler.

##ORTAMLAR

Kart eşleme paketi iki farklı ortamda çalışmaktadır. 
* PROD
* PREPROD

**Her ortamın API KEY i diğerlerinden farklıdır. Debug mod aktif edildiğinde SDK preprod ortamına bağlanacaktır.**

     [vc setEnableDebugMode:YES];

**NOT:** Entegrasyon sırasında işyerlerine verilen anahtarların sorumluluğu, **işyerine** aittir.



###IOS OBJECTIVE-C SDK ENTEGRASYONU

 SDK kullanmak için şu sıra ile uygulamaya eklenmelidir:

* BEX.bundle, include klasörü ve libBKMExpressSDK.a  dosyaları projeye eklenmelidir.

* Eklenecek uygulamanın Build Settings ayarlarından Other Linker Flags anahtarına –ObjC değeri yazılmalıdır.

* BKMExpress SDK arayüzlerinden geri haber alabilmek için BKMExpressPairingDelegate ve BKMExpressPaymentDelegate protokollerinin kullanılması gerekmektedir.


### BKMExpressPairingDelegate

    -  (void)bkmExpressPairingDidComplete:(NSString *)first6Digits withLast2Digits:(NSString *)last2Digits; //Success 

    -  (void)bkmExpressPairingDidCancel; //Cancel

    -  (void)bkmExpressPairingDidFail:(NSError *)error; //Fail

### BKMExpressPaymentDelegate

    -  (void)bkmExpressPaymentDidCompleteWithPOSResult:(BKMPOSResult *)posResult; //Success 

    -  (void)bkmExpressPaymentDidCancel; //Cancel

    -  (void)bkmExpressPaymentDidFail:(NSError *)error; //Fail

###ÖRNEK OBJECTIVE-C ÖDEME AKIŞI KULLANIMI
      

    #define BKM_EXPRESS_SDK_API_KEY @"Given by BKM"
    #define PAYMENT_TOKEN @"Payment token will be given by BKM after the merchant integration"

    @interface ViewController () <BKMExpressPaymentDelegate>

  
    - (IBAction)tapPaymentButton:(id)sender {
       BKMExpressPaymentViewController *vc = [[BKMExpressPaymentViewController alloc] initWithPaymentToken:PAYMENT_TOKEN withApiKey:BKM_EXPRESS_SDK_API_KEY delegate:self];
       [vc setEnableDebugMode:YES];
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


###ÖRNEK EŞLEŞME AKIŞI KULLANIMI
      

    #define BKM_EXPRESS_SDK_API_KEY @"Given by BKM"
    #define QUICK_PAY_TOKEN @"Quick pay token will be given by BKM after the merchant integration"

    @interface ViewController () <BKMExpressPairingDelegate>

  
    - (IBAction)tapPairButton:(id)sender {
       BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithToken:QUICK_PAY_TOKEN  withApiKey:BKM_EXPRESS_SDK_API_KEY delegate:self];
       [vc setEnableDebugMode:YES];
       [self presentViewController:vc animated:YES completion:nil];
    }

    #pragma Pairing delegate methods

   -  (void)bkmExpressPairingDidComplete:(NSString *)first6Digits withLast2Digits:(NSString *)last2Digits;{
           NSLog(@"%@",[NSString stringWithFormat:@"it was paired successfully the card which first six digit is %@ and last   two number is %@", first6Digits, last2Digits]);
    }
    
    - (void)bkmExpressPairingDidFail:(NSError *)error{
       NSLog(@"An error has occurred on card pairing = %@",error.localizedDescription);
    }

    - (void)bkmExpressPairingDidCancel{
       NSLog(@"Card pairing is canceled by user");
    }



###IOS SWIFT SDK ENTEGRASYONU

 SDK kullanmak için şu sıra ile uygulamaya eklenmelidir:

* BEX.bundle, include klasörü ve libBKMExpressSDK.a  dosyaları projeye eklenmelidir.

* Objective C ile geliştiren SDK'yı kullanabilmek icin Bridge yapılmalıdır. Aşağıdaki adreste daha detaylı bilgiler bulabilirsiniz:
  https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html

* Eklenecek uygulamanın Build Settings ayarlarından Other Linker Flags anahtarına –ObjC değeri yazılmalıdır.

* BKMExpress SDK arayüzlerinden geri haber alabilmek için BKMExpressPairingDelegate ve BKMExpressPaymentDelegate protokollerinin kullanılması gerekmektedir.


### BKMExpressPaymentDelegate

    -  func bkmExpressPaymentDidComplete(with posResult: BKMPOSResult!); //Success 

    -  func bkmExpressPaymentDidCancel(); //Cancel

    -  func bkmExpressPaymentDidFail(_ error: Error!) { //Fail


###ÖRNEK SWIFT ÖDEME AKIŞI KULLANIMI
      
    let kBKM_EXPRESS_SDK_API_KEY:String = "given by BKM"
    let kQUICK_PAY_TOKEN:String = "Quick pay token will be given by BKM after the merchant integration"
    let kPAYMENT_TOKEN:String = "Payment token will be given by BKM after the merchant integration"

    class ViewController: UIViewController , BKMExpressPaymentDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        let instanceOfCustomObject: BKMExpressPaymentViewController = BKMExpressPaymentViewController(paymentToken: kPAYMENT_TOKEN, withApiKey: kBKM_EXPRESS_SDK_API_KEY, delegate: self)

        instanceOfCustomObject.setEnableDebugMode(true)
        
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



