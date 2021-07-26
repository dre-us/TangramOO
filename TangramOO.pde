// Implementar:
// 1. La creación de las siete distintas piezas (por ahora son todas Rect) done!
// 2. La interacción: selección y manipulación de las piezas (ratón, teclas, touch...) done!
// 3. La evaluacion de la solucion. done!
// 4. El modo de creacion de nuevos problemas. done!

Shape[] shapes;
final float RATIO = 200;
final float SCALE = 25;
final int SIZE_MENU = 220;
final color EMPTY = color(255, 255, 255);
final color GREY = color(200, 200, 200);
final color GREEN = color(0, 255, 0);
final color RED = color(255, 0, 0);
final color BLACK = color(0, 0, 0);

int level, blackPixels;
PImage currLevel;
Shape activeShape;
boolean drawGrid, creativeMode;
Circle levelsButton, creativeButton, saveButton;
Term next, creative, save;

void setup() {
  size(920, 700);
  level = 1;
  drawGrid = true;
  activeShape = null;
  creativeMode = false;
  shapes = new Shape[7];
  currLevel = loadImage("lv_" + level + ".png");
  blackPixels = countBlackPixels();
  saveButton = new Circle(100, 550, 100, GREY);
  levelsButton = new Circle(100, 150, 100, GREY);
  creativeButton = new Circle(100, 350, 100, GREY);
  next = new Term("Next", new PVector(70, 160), 2);
  creative = new Term("Creative", new PVector(53, 360), 2);
  save = new Term("Save", new PVector(70, 560), 2);
  shapes[0] = new Triangle((float) (RATIO*Math.sqrt(2)/2), color(191, 5, 84));
  shapes[1] = new Triangle((float) (RATIO*Math.sqrt(2)/2), color(18, 106, 239));
  shapes[2] = new Triangle(RATIO/2, color(89, 33, 177));
  shapes[3] = new Rect((float) (RATIO*Math.sqrt(2)/4), color(34, 159, 28));
  shapes[4] = new Triangle((float) (RATIO*Math.sqrt(2)/4), color(228, 47, 30));
  shapes[5] = new Triangle((float) (RATIO*Math.sqrt(2)/4), color(18, 142, 149));
  shapes[6] = new Parallelogram(RATIO/2, (float) (RATIO*Math.sqrt(2)/4), RATIO/4, color(250, 120, 9));
  orderShapes();
}

void drawGrid(float scale) {
  push();
  strokeWeight(1);
  for (int i = SIZE_MENU; i <= width; i += scale) {
    stroke(0, 0, 5);
    line(i, 0, i, height);
  }
  for (int i = 0; i <= height; i += scale) {
    stroke(0, 0, 5);
    line(SIZE_MENU, i, width, i);
  }
  pop();
}

void orderShapes() {
  for (int i = 0; i < shapes.length; ++i) {
    shapes[i].reset();
    shapes[i].setPosition(new PVector(random(SIZE_MENU + 10, width-RATIO-10), random(10, height-RATIO-10)));
  }
}

void menu() {
  if(levelCompleted() && !creativeMode){
    levelsButton.setHue(GREEN);
  } else levelsButton.setHue(GREY);
  levelsButton.draw();
  next.draw();
  if(creativeButton.contains(mouseX, mouseY)){
    creativeButton.setHue(GREEN);
  } else creativeButton.setHue(GREY);
  if (creativeMode){
    creativeButton.setHue(RED);
    if(saveButton.contains(mouseX, mouseY)){
      saveButton.setHue(GREEN);
    } else saveButton.setHue(GREY);
    saveButton.draw();
    save.draw();
  }
  creativeButton.draw();
  creative.draw();
}

int countBlackPixels() {
  int cont = 0;
  for (int i = 0; i < currLevel.pixels.length; ++i)
    if (currLevel.pixels[i] == BLACK) ++cont;
  return cont;
}

boolean levelCompleted() {
  background(255, 255, 255);
  if (!creativeMode) showLevel();
  for (Shape shape : shapes)
    shape.draw();
  loadPixels();
  int cont = 0;
  for (int i = 0; i < pixels.length; ++i)
    if (pixels[i] == BLACK) ++cont;
  background(255, 255, 255);
  if (!creativeMode) showLevel();
  if (drawGrid) drawGrid(SCALE);
  for (Shape shape : shapes)
    shape.draw();
  return cont <= blackPixels*0.01;
}

void draw() {
  background(255, 255, 255);
  if (!creativeMode) showLevel();
  if (drawGrid)
    drawGrid(SCALE);
  for (Shape shape : shapes)
    shape.draw();
  menu();
}

void showLevel() {
   image(currLevel, SIZE_MENU, 0);
   
}

void mouseClicked() {
  activeShape = null;
  color currentColor = get(mouseX, mouseY);
  if (currentColor != EMPTY)
    for (Shape shape : shapes)
      if (shape.contains(currentColor))
        activeShape = shape;
  if (levelsButton.contains(mouseX, mouseY)) {
    if (get(mouseX, mouseY) == GREEN){
      level = (level + 1)%7;
      currLevel = loadImage("lv_" + level + ".png");
      blackPixels = countBlackPixels();
      orderShapes();
    }
  }
  if (creativeButton.contains(mouseX, mouseY)) {
    creativeMode = !creativeMode;
  }
  if (saveButton.contains(mouseX, mouseY)) {
    boolean tempDrawGrid = drawGrid;
    drawGrid = false;
    draw();
    loadPixels();
    PImage level = createImage(width-SIZE_MENU, height, RGB);
    for (int i = 0; i < width*height; ++i) {
      if (i % width >= SIZE_MENU) {
        int j = (i/width)*height + i%width - SIZE_MENU;
        int r = (int) red(pixels[i]);
        int g = (int) green(pixels[i]);
        int b = (int) blue(pixels[i]);
        if (r != 0 && g != 0 && b != 0 &&
          r != 255 && g != 255 && b != 255){
          level.pixels[j] = BLACK;
        } else level.pixels[j] = EMPTY;
      }
    }
    level.save("own_lv.png");
    background(0, 0, 0);
    drawGrid = tempDrawGrid;
  }
}

void mousePressed() {
  if (activeShape == null) {
    color currentColor = get(mouseX, mouseY);
    for (Shape shape : shapes)
      if (shape.contains(currentColor))
        activeShape = shape;
  } else {
    color currentColor = get(mouseX, mouseY);
    if (currentColor == EMPTY)
      activeShape = null;
    else if (currentColor != activeShape.getHue())
      for (Shape shape : shapes)
        if (shape.contains(currentColor))
          activeShape = shape;
  }
}

void mouseDragged() {
  PVector position = new PVector(mouseX, mouseY);
  if (activeShape != null)
    activeShape.setPosition(position);
}

void keyPressed() {
  if (key == 'g' || key == 'G')
    drawGrid = !drawGrid;
  if (activeShape != null) {
    if (key == 'e' || key == 'E')
      activeShape.setMirror(!activeShape.getMirror());
    if (key == 'd' || key == 'D')
      activeShape.setRotation(activeShape.getRotation() + QUARTER_PI);
    if (key == 'a' || key == 'A')
      activeShape.setRotation(activeShape.getRotation() - QUARTER_PI);
    if (key == CODED) {
      PVector currentPosition = activeShape.getPosition();
      if (keyCode == LEFT)
        activeShape.setPosition(new PVector(currentPosition.x-1, currentPosition.y));
      else if (keyCode == RIGHT)
        activeShape.setPosition(new PVector(currentPosition.x+1, currentPosition.y));
      else if (keyCode == UP)
        activeShape.setPosition(new PVector(currentPosition.x, currentPosition.y-1));
      else if (keyCode == DOWN)
        activeShape.setPosition(new PVector(currentPosition.x, currentPosition.y+1));
    }
  }
}
