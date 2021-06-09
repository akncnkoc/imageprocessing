int rectX, rectY;
int rectSize = 90;
color rectColor,baseColor;
color rectHighlight;
color currentColor;
boolean rectOver = false;
void setup() {
  size(500,500);
  rectColor = color(0);
  rectHighlight = color(51);
  baseColor = color(102);
  //height/2-rectSize/2
  rectY = -200;
}

void draw() {
  update(mouseX, mouseY);
  background(currentColor);
  
  rectX = (width/2) - rectSize / 2;
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  
  rect(rectX, rectY, rectSize, rectSize);
  if(rectY <= height/2-rectSize/2){
    rectY += millis() * 0.003;
  }
  
  textSize(32);
  fill(0, 102, 153);
  text("akın", rectX + 10,rectY + (rectSize / 2) + 10);
}

void update(int x, int y) {
  if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  if (rectOver) {
    print("tıklandı");
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
