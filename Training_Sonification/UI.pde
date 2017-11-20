void setupP5() {
  
}

/* 
  Corners = {x1, y1, x2, y2}
  vert lines = x positions. 
    Red=0, orange=1, yellow=2, green=3, 
    center=4, 
    green=5, yellow=6, orange=7, red=8
  horiz lines = y positions.
    Red=0, orange=1, yellow=2, green=3, 
    center=4, 
    green=5, yellow=6, orange=7, red=8
  
*/
void drawGrid(int[] vertLines, int[] horizLines) {
  int lines = 20;
  stroke(255);
  for (int i = 0; i <lines; i++) {
    int y = i*(gridHeight/lines);
    int x = i*(gridWidth/lines);
    line(0,y,gridWidth,y);
    line(x,0,x,gridHeight);
  }
  strokeWeight(4);
  //TODO: Limit Lines
}