class Circle extends Shape {
  private float radio;
  private color hue;
  
  Circle() {
    this.setRadio(20);
  }
  
  Circle(float diameter) {
     this.setRadio(diameter/2);
  }
  
  Circle(int x, int y, float diameter, color hue) {
    setPosition(new PVector(x, y));
    setRadio(diameter/2);
    setHue(hue);
  }
   
  @Override
  void aspect() {
    ellipse(0, 0, 2*radio, 2*radio);
  }
  
  boolean contains(int x, int y) {
    return Math.sqrt((x-_position.x)*(x-_position.x) + (y-_position.y)*(y-_position.y)) <= radio;
  }
  
  void setRadio(float radio) {
    this.radio = radio;
  }
  
  float getRadio() {
    return this.radio;
  }
  
  void setHue(color hue) {
    this.hue = hue;
  }
  
  color getHue() {
    return hue;
  }
}
