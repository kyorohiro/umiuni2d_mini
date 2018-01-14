part of core;


//typedef LittleUIPaintFunc (TinyStage stage, TinyCanvas canvas);

class DisplayObjectEx extends DisplayObject {
  List<TExpansionBase> extensions = [];
  addExtension(TExpansionBase ex) {
    extensions.add(ex);
  }

  removeExtension(TExpansionBase ex){
    extensions.remove(ex);
  }

  clearExtension() {
    extensions.clear();
  }

  @override
  void onChangeStageStatus(Stage stage, DisplayObject parent) {
    for(TExpansionBase b in extensions) {
      b.onChangeStageStatus(stage, parent);
    }
  }

  @override
  void onInit(Stage stage) {
    for(TExpansionBase b in extensions) {
      b.onInit(stage);
    }
  }

  @override
  void onTick(Stage stage, int timeStamp) {
    for(TExpansionBase b in extensions) {
      b.onTick(stage, timeStamp);
    }
  }

  @override
  void onPaint(Stage stage, Canvas canvas){
    for(TExpansionBase b in extensions) {
      b.onPaint(stage, canvas);
    }
  }

  @override
  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY){
    bool ret = false;
    for(TExpansionBase b in extensions) {
      ret = ret ||  b.onTouch(stage, id, type, globalX, globalY);
    }
    return ret;
  }

  @override
  void onTouchStart(Stage stage, int id, StagePointerType type, double x, double y){
    for(TExpansionBase b in extensions) {
      b.onTouchStart(stage, id, type, x, y);
    }
  }

  @override
  void onTouchEnd(Stage stage, int id, StagePointerType type, double x, double y){
    for(TExpansionBase b in extensions) {
      b.onTouchEnd(stage, id, type, x, y);
    }
  }

  @override
  void onUnattach() {
    for(TExpansionBase b in extensions) {
      b.onUnattach();
    }
  }

  @override
  void onAttach(Stage stage, DisplayObject parent) {
    for(TExpansionBase b in extensions) {
      b.onAttach(stage, parent);
    }
  }
}
