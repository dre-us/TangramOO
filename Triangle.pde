class Triangle extends Shape {
  
  private float edge;
  
  Triangle() {
    this(100, color(0, 0, 0));
  }
  
  Triangle(float edge, color hue) {
    setEdge(edge);
    setHue(hue);
  }
  
  @Override
  void aspect() {
    beginShape();
    vertex(0, 0);
    vertex(getEdge(), 0);
    vertex(0, getEdge());
    endShape();
  }
  
  float getEdge() {
    return this.edge;
  }
  
  void setEdge(float edge) {
    this.edge = edge;
  }
}
