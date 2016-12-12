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



###IOS SDK ENTEGRASYONU

 SDK kullanmak için şu sıra ile uygulamaya eklenmelidir:

* BEX.bundle, include klasörü ve libBKMExpressSDK.a  dosyaları projeye eklenmelidir.

* Eklenecek uygulamanın Build Settings ayarlarından Other Linker Flags anahtarına –ObjC değeri yazılmalıdır.

* BKMExpress SDK arayüzlerinden geri haber alabilmek için BKMExpressPairingDelegate ve BKMExpressPaymentDelegate protokollerinin kullanılması gerekmektedir.


### BKMExpressPairingDelegate

    -  (void)bkmExpressPairingDidComplete; //Success 

    -  (void)bkmExpressPairingDidCancel; //Cancel

    -  (void)bkmExpressPairingDidFail:(NSError *)error; //Fail

### BKMExpressPaymentDelegate

    -  (void)bkmExpressPaymentDidComplete; //Success 

    -  (void)bkmExpressPaymentDidCancel; //Cancel

    -  (void)bkmExpressPaymentDidFail:(NSError *)error; //Fail

###ÖRNEK ÖDEME AKIŞI KULLANIMI
      

    #define BKM_EXPRESS_SDK_API_KEY @"Given by BKM"
    #define PAYMENT_TOKEN @"Payment token will be given by BKM after the merchant integration"

    @interface ViewController () <BKMExpressPaymentDelegate>

  
    - (IBAction)tapPaymentButton:(id)sender {
       BKMExpressPaymentViewController *vc = [[BKMExpressPaymentViewController alloc] initWithPaymentToken:PAYMENT_TOKEN withApiKey:BKM_EXPRESS_SDK_API_KEY delegate:self];
       [vc setEnableDebugMode:YES];
       [self presentViewController:vc animated:YES completion:nil];
    }

    #pragma Payment delegate methods

    - (void)bkmExpressPaymentDidComplete{
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

    - (void)bkmExpressPairingDidComplete{
       NSLog(@"Successful pairing");
    }
    
    - (void)bkmExpressPairingDidFail:(NSError *)error{
       NSLog(@"An error has occurred on card pairing = %@",error.localizedDescription);
    }

    - (void)bkmExpressPairingDidCancel{
       NSLog(@"Card pairing is canceled by user");
    }
