##NE İŞE YARAR?
> Hizmetinize sunulan iOS Kart Eşleme SDK paketi, kullanıcının BKMExpress ile yapacağı hızlı ödemeler için, işyeri uygulamasından çıkmadan, kart eşleme seçeneği sunmaktadır.

##SİSTEM GEREKSİNİMLERİ NELERDİR?

 *  Min iOS-7 desteklenmektedir.
 *  iPhone cihazlar desteklenmektedir. 

##NASIL ÇALIŞIR?

Işyerleri BKM Express entegrasyonlarını tamamlayarak gerekli **API Key**lerini almalıdırlar. Bu API Key daha sonra
iOS Kart Eşleme paketinin kullanılabilmesi için gerekmektedir. İşyeri servis uygulamaları, BKMExpress core servislerine bağlanarak kendileri için hazırlanan **TOKEN**'ı ve **API Key**'i sunulan methodlara parametrik olarak ileterek, Kart Ekleme akışı başlatılır.

##GRADLE ENTEGRASYONU

* SDK paketini gradle dependency ile eklemek için, uygulamanızın build.gradle dosyasındaki repositories kısmına aşağıdaki kod bloğunu ekleyiniz.

                repositories{
                    jcenter()
                    maven{
                          url 'https://dl.bintray.com/bkmexpress/maven'
                    }
                 }

* Daha sonra yine aynı dosyadaki dependencies kısmına aşağıdaki gradle bağlantısını ekleyiniz.

                compile 'com.bkm.bexandroidsdk:bexandroidsdk:1.0.0_Test'

* Yukarıdaki eklemeleri yapıp, projenizi gradle ile sync ettikten sonra Kart Eşleme Paketinin BEXStarter sınıfına erişebilirsiniz. **BEXStarter** sınıfı, sunulan servis paketinin çalışmasını sağlamakta, ve parametrik olarak verilen **BEXSubmitConsumerListener** interface i ile de asynchrone olarak sonucu işyerine iletmektedir. (Ayrıntılı bilgi için lütfen Örnek Projeye Bakınız!)

###BEXStarter

                public static void startSDKForSubmitConsumer(Context context, String token, String api_key,BEXSubmitConsumerListener bexSubmitConsumerListener);

***

###BEXSubmitConsumerListener

                 public void onSuccess(); //BAŞARILI EŞLEŞME 
                 public void onCancelled(); //KULLANICI İŞLEMİ İPTAL ETTİ
                 public void onFailure(int errorId,String errorMsg); //İŞLEM VERİLEN HATA YÜZÜNDEN İPTAL EDİLDİ


###ÖRNEK KULLANIM
                  BEXStarter.startSDKForSubmitConsumer(MainActivity.this, "MERCHANT-TOKEN", getString(R.string.dummyApiKey), new BEXSubmitConsumerListener() {

                                @Override
                                public void onSuccess() {
                                    Toast.makeText(MainActivity.this,"Sync Completed!!!",Toast.LENGTH_LONG).show();
                                }

                                @Override
                                public void onCancelled() {
                                    Toast.makeText(MainActivity.this,"Sync Cancelled By User!!!",Toast.LENGTH_LONG).show();
                                }

                                @Override
                                public void onFailure(int errorId, String errorMsg) {
                                    Toast.makeText(MainActivity.this,"Sync failed!!! Cause :: "+errorMsg,Toast.LENGTH_LONG).show();
                                }
                            });

##ORTAMLAR

Kart eşleme paketi iki farklı ortamda çalışmaktadır. 
* PROD
* TEST

**Her ortamın API KEY i diğerlerinden farklıdır.**

**NOT:** Entegrasyon sırasında işyerlerine verilen anahtarların sorumluluğu, **işyerine** aittir.




