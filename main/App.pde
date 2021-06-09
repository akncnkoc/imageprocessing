//orjinal resim için
PImage img;
//orjinal resmin piksel piksel renk verileri
float[][] visualData;
//yeni oluşturulacak resim için
PImage nImage;
//yeni oluşturulacak resim kaç kat büyütülecek
int ratio = 3;
void setupA() {
  //açılan pencereyi gizle
  surface.setVisible(false);
  //resmi dosyadan yükle
  img = loadImage("image.jpg");
  // yeni oluşturulacak resmi orjinal resmin orana çarpılmış şekilde ayarlar
  nImage = createImage(img.width * ratio,img.height * ratio,ARGB);
  //görsel verileri yüklenen resmin genişlik ve yükseklik ile başlatıyoruz 
  visualData = new float[img.width * img.height][];
  //yüklenen resmin piksellerini al
  img.loadPixels();
  //piksellerin her biri için dön
  for(int i = 0;i<img.pixels.length;i++){
    // o anki pikselin kırmızı değerini al
    float r = red(img.pixels[i]);
    // o anki pikselin yeşil değerini al
    float g = green(img.pixels[i]);
    // o anki pikselin mavi değerini al
    float b = blue(img.pixels[i]);
    // o anki pikselin transparan değerini al
    float a = alpha(img.pixels[i]);
    float[] c = {r,g,b,a};
    // yeni oluşturulan diziyi görsel veriye aktar
    visualData[i] = c; 
  }
  // x konumu
  int x = 0;
  // y konumu
  int y = 0;
  // sonraki piksel
  int nextPixel = 0;
  // j döngü değeri
  int j = 0;
  // işlenen değer
  float proccess = 0;
  // işlenen eski değer
  float oldProccess = 0;
  //sonsuz döngü kuruyoruz
  while(true){
    try{
      // kırmızı değeri alıyoruz
      float r = visualData[nextPixel][0];
      // yeşil değeri alıyoruz
      float g = visualData[nextPixel][1];
      // mavi değeri alıyoruz
      float b = visualData[nextPixel][2];
      // transparan değeri alıyoruz
      float a = visualData[nextPixel][3];
      //yeni oluşturulan resmin yatay düzlemde 3 piksel ekliyoruz
      nImage.set(x,y, color(r,g,b,a));
      nImage.set(x + 1,y, color(r,g,b,a));
      nImage.set(x + 2,y, color(r,g,b,a));
      
      
      //yeni oluşturulan resmin yatay ve dikey + 1 düzlemde 3 piksel ekliyoruz
      nImage.set(x, y +1 , color(r,g,b,a));
      nImage.set(x + 1,y + 1, color(r,g,b,a));
      nImage.set(x + 2,y + 1, color(r,g,b,a));
      
      //yeni oluşturulan resmin yatay ve dikey + 2 düzlemde 3 piksel ekliyoruz
      nImage.set(x, y + 2 , color(r,g,b,a));
      nImage.set(x + 1,y + 2, color(r,g,b,a));
      nImage.set(x + 2,y + 2, color(r,g,b,a));
      
      //eğer x konumu 3 piksel'den fazlaysa
      if(x % 3 == 0){
        // yeni piksele geç
        nextPixel += 1;
      }
      // eğer o anki döngü değeri genişlik bölümü değerinden kalan 0 ise ve j eşit değilse sıfıra
      if (j % img.width == 0 && j != 0) {
          //dikey düzlemde 3 piksel aşağı git
          y += 3;
          //yatay düzlemi sıfırla
          x = 0;
      } else {
        // yatay düzlemi 3 arttır
          x += 3;
      }
      
      //resmin piksel boyutu
      float imgLength = (img.width * img.height);
      // resmin işlenen yüzdesel değeri
      float n = (nextPixel / imgLength) * 100;
      // eğer işlenen değer büyükse
      if(n > 0.1){
        // o anki işlem değeri n
        proccess = n;
      }else{
        // o anki eski işlem değeri n
        oldProccess = n;
      }
      
      if(round(proccess) > round(oldProccess)){
        oldProccess = proccess;
        println("Proccessing image : %",oldProccess);
      }
     
     //bütün pikseller bittiyse
      if(nextPixel >= img.width * img.height){
        // yeni resmin piksellerini güncelle
        nImage.updatePixels();
        println("saving image");
        // oluşturulan resmi 
        nImage.save("image_big.jpg");
        println("done");
        //sonsuz döngüden çık
        break;
      }
      j++;
    }catch(Exception e){
      e.printStackTrace(System.out);
      break;
    }
  }
  //programı kapat
  exit();
}
  
  
