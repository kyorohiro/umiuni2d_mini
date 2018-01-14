part of core;

class Size {
  double w;
  double h;
  Size(this.w, this.h) {}

  @override
  bool operator ==(o) => o is Size && o.w == w && o.h == h;

  @override
  int get hashCode => JenkinsHash.calc([w.hashCode, h.hashCode]);

  @override
  String toString() {
    return "w:${w}, h:${h}";
  }
}
