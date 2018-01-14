part of core;



class TExpansionBase {
  DisplayObject target;
  TExpansionBase(this.target) {
    ;
  }
  void onChangeStageStatus(TinyStage stage, DisplayObject parent) {}
  void onInit(TinyStage stage) {}
  void onTick(TinyStage stage, int timeStamp) {}
  void onPaint(TinyStage stage, Canvas canvas){}
  bool onTouch(TinyStage stage, int id, StagePointerType type, double globalX, globalY){return false;}
  void onTouchStart(TinyStage stage, int id, StagePointerType type, double x, double y){}
  void onTouchEnd(TinyStage stage, int id, StagePointerType type, double x, double y){}
  void onUnattach() {}
  void onAttach(TinyStage stage, DisplayObject parent) {}
}
