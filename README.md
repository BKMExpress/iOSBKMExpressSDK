##NE İŞE YARAR?
> iOS Kart Eşleme SDK paketi, kullanıcının BKMExpress ile yapacağı hızlı ödemeler için, işyeri uygulamasından çıkmadan, kart eşleme seçeneği sunmaktadır.

##SİSTEM GEREKSİNİMLERİ NELERDİR?

 *  Min iOS-7 desteklenmektedir.
 *  iPhone cihazlar desteklenmektedir. 

##NASIL ÇALIŞIR?

Işyerleri BKM Express entegrasyonlarını tamamlayarak gerekli **API Key**lerini almalıdırlar. Bu API Key daha sonra
iOS Kart Eşleme paketinin kullanılabilmesi için gerekmektedir. İşyeri servis uygulamaları, BKMExpress core servislerine bağlanarak kendileri için hazırlanan **TOKEN**'ı ve **API Key**'i sunulan methodlara parametrik olarak ileterek, Kart Ekleme akışı başlatılır.

##ORTAMLAR

Kart eşleme paketi iki farklı ortamda çalışmaktadır. 
* PROD
* PREPROD

**Her ortamın API KEY i diğerlerinden farklıdır. Debug mod aktif edildiğinde sdk preprod ortamına bağlanacaktır.**

     [vc setEnableDebugMode:YES];

**NOT:** Entegrasyon sırasında işyerlerine verilen anahtarların sorumluluğu, **işyerine** aittir.



###IOS SDK ENTEGRASYONU

 SDK kullanmak için şu sıra ile uygulamaya eklenmelidir:

* BEX.bundle, include klasörü ve libBKMExpressSDK.a  dosyalarını projeye eklenmelidir.

* Eklenecek uygulamanın Build Settings ayarlarından Other Linker Flags anahtarına –ObjC değeri yazılmalıdır.

* BKMExpress SDK arayüzlerinden geri haber alabilmek için BKMExpressPairingDelegate protokolunun kullanılması gerekmektedir.


###<BKMExpressPairingDelegate>
        
    -  (void)bkmExpressDidCompletePairing; //Success 

    -  (void)bkmExpressDidCancel;; //Cancel
              

###ÖRNEK KULLANIM
      

    #define BKM_EXPRESS_SDK_API_KEY @"given by BKM"
    #define TOKEN @"token will be taken after the merchant integration"

    - (IBAction)tapBEXPaymentButton:(id)sender {
       BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithToken:TOKEN withApiKey:BKM_EXPRESS_SDK_API_KEY delegate:self];
       [vc setEnableDebugMode:YES];
       [self presentViewController:vc animated:YES completion:nil];
    }

    #pragma Pairing delegate methods
    - (void)bkmExpressDidCompletePairing{
    }

    - (void)bkmExpressDidCancel{
    }

