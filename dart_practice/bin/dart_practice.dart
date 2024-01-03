void main() {

  Point aPoint=Point(11, 22);
  print('${aPoint.x}, ${aPoint.y}');
  print('se');

}

class Point {
  int x;
  int? y;

  Point(this.x, this.y ?? 0);
}
