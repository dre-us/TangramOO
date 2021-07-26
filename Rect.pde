class Rect extends Shape {
  float _edge;

  Rect() {
    this(100, color(0, 0, 0));
  }

  Rect(float edge, color hue) {
    setEdge(edge);
    setHue(hue);
  }

  @Override
  void aspect() {
    rect(0, 0, getEdge(), getEdge());
  }

  public float getEdge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
