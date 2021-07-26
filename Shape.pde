// Implementar:
// 1. El estilo del shape (e.g., stroke, stroke weight). done!
// 2. El método contains(int x, int y) que diga si un punto de coordenadas
// (x,y) se encuentra o no al interior del shape. Observe que esta
// función puede servir para la selección de la pieza con un puntero. done!
// 3. El resto de shapes que se requieran para el Tangram, como se
// hace con la clase Rect (ver Rect.pde). done!

abstract class Shape {
  float _rotation;
  float _scaling;
  PVector _position;
  color _hue;
  boolean mirror;

  Shape() {
    this(new PVector(random(0, width), random(0, height)),
         0,
         1,
         color(random(1, 254), random(1, 254), random(1, 254)));
  }

  Shape(PVector position, float rotation, float scaling, color hue) {
    setPosition(position);
    setRotation(rotation);
    setScaling(scaling);
    setHue(hue);
    setMirror(false);
  }

  void draw() {
    push();
    fill(getHue());
    noStroke();
    translate(getPosition().x, getPosition().y);
    rotate(getRotation());
    scale(getScaling(), getScaling());
    aspect();
    pop();
  }

  abstract void aspect();

  boolean contains(color currentColor) {
    return currentColor == _hue;
  }

  float getScaling() {
    return _scaling;
  }

  void setScaling(float scaling) {
    _scaling = scaling;
  }

  float getRotation() {
    return _rotation;
  }

  void setRotation(float rotation) {
    _rotation = rotation;
  }

  PVector getPosition() {
    return _position;
  }

  void setPosition(PVector position) {
    _position = position;
  }

  color getHue() {
    return _hue;
  }

  void setHue(color hue) {
    _hue = hue;
  }
  
  void setMirror(boolean mirror) {
    this.mirror = mirror;
  }
  
  boolean getMirror() {
    return this.mirror;
  }
  
  void reset() {
    setPosition(new PVector(0, 0));
    setRotation(0);
    setScaling(1);
    setMirror(false);
  }
}
