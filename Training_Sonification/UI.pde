void setupP5() {
  
}

/* 
  Corners = {x1, y1, x2, y2}
  vert lines = x bar. 
    Red=0, orange=1, yellow=2, green=3, 
    center=4, 
    green=5, yellow=6, orange=7, red=8
  horiz lines = y bar.
    Red=0, orange=1, yellow=2, green=3, 
    center=4, 
    green=5, yellow=6, orange=7, red=8
  
*/
void drawGrid(int cX, int cY, int[] vL, int[] hL) {
  int lines = 20;
  int squareWidth = gridWidth/lines;
  int squareHeight = gridHeight/lines;
  stroke(180);
  strokeWeight(1);
  for (int i = 0; i <=lines; i++) {
    int y = i*(squareHeight)+cX;
    int x = i*(squareWidth)+cY;
    line(cX,y,gridWidth+cX,y);
    line(x,cY,x,gridHeight+cY);
  }
  strokeWeight(7);
  //TODO: Limit Lines
  stroke(255,59,33); //Red
  line(vL[0]*squareHeight+cX,cY,vL[0]*squareHeight+cX,gridHeight+cY);
  line(vL[8]*squareHeight+cX,cY,vL[8]*squareHeight+cX,gridHeight+cY);
  
  strokeWeight(5);
  stroke(242,138,2); //Orange
  line(vL[1]*squareHeight+cX,cY,vL[1]*squareHeight+cX,gridHeight+cY);
  line(vL[7]*squareHeight+cX,cY,vL[7]*squareHeight+cX,gridHeight+cY);
  
  strokeWeight(3);
  stroke(255,242,12); //Yellow
  line(vL[2]*squareHeight+cX,cY,vL[2]*squareHeight+cX,gridHeight+cY);
  line(vL[6]*squareHeight+cX,cY,vL[6]*squareHeight+cX,gridHeight+cY);
  
  strokeWeight(1);
  stroke(53,229,0); //Green
  line(vL[3]*squareHeight+cX,cY,vL[3]*squareHeight+cX,gridHeight+cY);
  line(vL[5]*squareHeight+cX,cY,vL[5]*squareHeight+cX,gridHeight+cY);
  
  strokeWeight(9);
  stroke(255); //White
  line((lines/2)*squareHeight+cX,cY,(lines/2)*squareHeight+cX,gridHeight+cY);
  line(cX,(lines/2)*squareWidth+cY,gridWidth+cX,(lines/2)*squareWidth+cY);
  
  fill(255);
  textSize(30);
  textLeading(30);
  text("Balance",gridWidth/2+cX+5,gridHeight/2+cY+30);
  text("E\nx\nt\ne\nn\ns\ni\no\nn",gridWidth/2+cX-25,cY+squareHeight);
}