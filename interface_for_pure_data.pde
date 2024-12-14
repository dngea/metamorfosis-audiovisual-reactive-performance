import oscP5.*;  // download and import
import netP5.*;  // download and import
  
OscP5 oscP5;
NetAddress myRemoteLocation;
  
  
  int windowX = 800;
  int windowY = 800;
  
  int inputX;
  int inputY;
  
  int hover1 = 15;
  int hover2 = 15;
  int hover3 = 15;
  int hover4 = 15;
  
  float chapter1;
  float chapter2;
  float chapter3;
  float chapter4;
  
  float volume = 1;
  
void setup(){
  size(800, 800);
  
  oscP5 = new OscP5(this,8001);
  
  inputX = windowX/2;
  inputY = windowY/2;
  
  // OSC IP and location
  myRemoteLocation = new NetAddress("192.168.1.122",7001);  // CHANGE IP  <-----------
  oscP5.plug(this,"test","/test");
}

void draw(){
  background(15);
  
  // CHAPTERS
  stroke(18);
  strokeWeight(8);
  line(windowX/2, 0, windowX/2, windowY);
  line(0, windowY/2, windowX, windowY/2);
  
  fill(hover1);
  rect(0, 0, windowX/2, windowY/2);
  
  fill(hover2);
  rect(windowX/2, 0, windowX/2, windowY/2);
  
  fill(hover3);
  rect(0, windowY/2, windowX/2, windowY/2);
  
  fill(hover4);
  rect(windowX/2, windowY/2, windowX/2, windowY/2);
  

  
  // MOUSE INPUT
  if (mousePressed == true) {
    noCursor();
    
    inputX = mouseX;
    inputY = mouseY;
    
    if(inputX > windowX){
      inputX = windowX;
    }
    if(inputY > windowY){
      inputY = windowY;
    }
    if(inputX < 0){
      inputX = 0;
    }
    if(inputY < 0){
      inputY = 0;
    }
      
    // LINES
    stroke(180);
    strokeWeight(2);
    line(inputX, 0, inputX, windowY);
    line(0, inputY, windowX, inputY);
    
    // CIRCLE
    fill(180);
    noStroke();
    circle(inputX, inputY, 30); 
    
    
    // BOXES HOVER
    if(inputX < windowX/2 && inputX > 0 && inputY < windowY/2 && inputY > 0){
      hover1 = 10;
    } else {
      hover1 = 15;
    }
    
    if(inputX > windowX/2 && inputX < windowX && inputY < windowY/2 && inputY > 0){
      hover2 = 10;
    } else {
      hover2 = 15;
    }
    
    if(inputX < windowX/2 && inputX > 0 && inputY > windowY/2 && inputY < windowY){
      hover3 = 10;
    } else {
      hover3 = 15;
    }
    
    if(inputX > windowX/2 && inputX < windowX && inputY > windowY/2 && inputY < windowY){
      hover4 = 10;
    } else {
      hover4 = 15;
    }
    
  } else {
    cursor(HAND);
    
    stroke(150);
    strokeWeight(1);
    line(inputX, 0, inputX, windowY);
    line(0, inputY, windowX, inputY);
    
    fill(150);
    noStroke();
    circle(inputX, inputY, 25);
  }
  
  // VALUES Calculated
  float x = map(inputX, 0, windowX, 0, 1);
  float y = map(inputY, 0, windowY, 0, 1);
  

  
  // CHAPTER 1
  if( x < 0.6 && y < 0.6){
    float tempX = map(x, 0.1, 0.5, 1, 0);
    float tempY = map(y, 0.1, 0.5, 1, 0);
    chapter1 = ((tempX + tempY)/2.3);
    if(chapter1 > 1){
      chapter1 = 1;
    } else if (chapter1 < 0){
      chapter1 = 0;
    }
    
  } else if(x > 0.6 || y > 0.6){
    chapter1 = chapter1 - 0.0025;
    if(chapter1 < 0){
      chapter1 = 0;
    }
  }
  
  
  // CHAPTER 2
  if(0.4 < x && y < 0.6){
    float tempX = map(x, 0.5, 0.9, 0, 1);
    float tempY = map(y, 0.1, 0.5, 1, 0);
    chapter2 = ((tempX + tempY)/2.3);
    if (chapter2 > 1){
      chapter2 = 1;
    } else if(chapter2 < 0){
      chapter2 = 0;
    }
    
  } else if(x < 0.4 || y > 0.6){
    chapter2 = chapter2 - 0.0025;
    if(chapter2 < 0){
      chapter2 = 0;
    }
  }
  
  
  // CHAPTER 3
  if(x < 0.6 && y > 0.4){
    float tempX = map(x, 0.1, 0.5, 1, 0);
    float tempY = map(y, 0.5, 0.9, 0, 1);
    chapter3 = (tempX+tempY)/2.3;
    
    if (chapter3 > 1){
      chapter3 = 1;
    } else if(chapter3 < 0){
      chapter3 = 0;
    }
    
  } else if(x > 0.6 || y < 0.4){
    chapter3 = chapter3 - 0.0025;
    
    if(chapter3 < 0){
      chapter3 = 0;
    }
  }
  
  
  // CHAPTER 4
  if(x > 0.4 && y > 0.4){
    float tempX = map(x, 0.5, 0.9, 0, 1);
    float tempY = map(y, 0.5, 0.9, 0, 1);
    chapter4 = (tempX+tempY)/2.3;
    if (chapter4 > 1){
      chapter4 = 1;
    } else if(chapter4 < 0){
      chapter4 = 0;  
    }
    
   } else if(x < 0.6 || y < 0.6){
    chapter4 = chapter4 - 0.0025;
    if(chapter4 < 0){
      chapter4 = 0;
    }
  }
  
  
  // Turn OFF all
  if(0.48 < x && x < 0.52 && 0.48 < y && y < 0.52){
    volume = volume - 0.005;
    if(volume < 0){
      volume = 0;
    }
      
  } else {
    volume = volume + 0.005;
    if(volume > 1){
      volume = 1;
    }
  }
  
  
    
  // Draw the values at the top right
  // textSize(20);
  // text("x " + x, 50, 50);
  // text("y " + y, 50, 75);
  
  
  // SEND THE MESSAGE
  OscMessage myMessage = new OscMessage("/message");
  myMessage.add(x);
  myMessage.add(y);
  myMessage.add(chapter1);
  myMessage.add(chapter2);
  myMessage.add(chapter3);
  myMessage.add(chapter4);
  myMessage.add(volume);
  

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
  
  float valor = (x+y)/2.3;
  
  println(valor);
  println("chapter1: " + chapter1);
  println("chapter2: " + chapter2);
  println("chapter3: " + chapter3);
  println("chapter4: " + chapter4);
  println("volume: " + volume);
  println("------------");
}
