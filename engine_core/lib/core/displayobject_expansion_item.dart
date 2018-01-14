part of core;



class TExpansionBase {
  DisplayObject target;
  TExpansionBase(this.target) {
    ;
  }
  void onChangeStageStatus(Stage stage, DisplayObject parent) {}
  void onInit(Stage stage) {}
  void onTick(Stage stage, int timeStamp) {}
  void onPaint(Stage stage, Canvas canvas){}
  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY){return false;}
  void onTouchStart(Stage stage, int id, StagePointerType type, double x, double y){}
  void onTouchEnd(Stage stage, int id, StagePointerType type, double x, double y){}
  void onUnattach() {}
  void onAttach(Stage stage, DisplayObject parent) {}
}
