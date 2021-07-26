import java.lang.Math;

class Parallelogram extends Shape {
  private float a, b, h;
  
  Parallelogram() {
    this(100, 100, 0, color(0, 0, 0));
  }
  
  Parallelogram(float a, float b, float h, color hue) {
    this.a = a;
    this.b = b;
    this.h = h;
    setHue(hue);
  }
  
  @Override
  void aspect() {
    float x = (float) Math.sqrt((b*b - h*h));
    beginShape();
    vertex(0, 0);
    if (mirror) {
      vertex(h, x);
      vertex(h, x+a);
      vertex(0, a);
    } else {
      vertex(x, h);
      vertex(a+x, h);
      vertex(a, 0);
    }
    endShape();
  }
}
