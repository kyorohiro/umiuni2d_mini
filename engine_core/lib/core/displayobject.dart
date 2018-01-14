part of core;

class DisplayObject {
  String objectName = "none";
  List<DisplayObject> child = [];
  Matrix4 mat = new Matrix4.identity();
  double get x => this.mat.storage[12];
  double get y => this.mat.storage[13];
  double get z => this.mat.storage[14];
  double get sx => (new Vector3(mat.storage[0], mat.storage[4], mat.storage[8])).length;
  double get sy => (new Vector3(mat.storage[1], mat.storage[5], mat.storage[9])).length;
  double get sz => (new Vector3(mat.storage[2], mat.storage[6], mat.storage[10])).length;


  DisplayObject({this.child: null}) {
    if (child == null) {
      child = [];
    }
  }

  DisplayObject findObjectFromObjectName(String objectName) {
    if (this.objectName == objectName) {
      return this;
    }
    for (DisplayObject d in child) {
      DisplayObject t = d.findObjectFromObjectName(objectName);
      if (t != null) {
        return t;
      }
    }
    return null;
  }

  Future addChild(DisplayObject d) async {
    await new Future.value();
    child.add(d);
  }

  Future rmChild(DisplayObject d) async {
    await new Future.value();
    child.remove(d);
    d.unattach();
  }

  Future clearChild() async {
    await new Future.value();
    for(DisplayObject d in child) {
      rmChild(d);
    }
  }

  void onChangeStageStatus(TinyStage stage, DisplayObject parent) {}

  void changeStageStatus(TinyStage stage, DisplayObject parent) {
    onChangeStageStatus(stage, parent);
    for (DisplayObject d in child) {
      d.changeStageStatus(stage, this);
    }
  }

  void onInit(TinyStage stage) {}

  void init(TinyStage stage) {
    onInit(stage);
    for (DisplayObject d in child) {
      d.init(stage);
    }
  }

  void onTick(TinyStage stage, int timeStamp) {
//    print("--------A");
  }

  void tick(TinyStage stage, DisplayObject parent, int timeStamp) {
    attachCheck(stage, parent);
    onTick(stage, timeStamp);
    for (DisplayObject d in child) {
      d.tick(stage, this, timeStamp);
    }
  }

  void onPaint(TinyStage stage, Canvas canvas) {
//    print("--------B");
  }

  void paint(TinyStage stage, Canvas canvas) {
    //attachCheck();
    onPaint(stage, canvas);
    for (DisplayObject d in child) {
      canvas.pushMulMatrix(d.mat);
      d.paint(stage, canvas);
      canvas.popMatrix();
    }
  }

  bool touch(TinyStage stage, DisplayObject parent, int id, StagePointerType type, double x, double y) {
    attachCheck(stage, parent);
    onTouchStart(stage, id, type, x, y);
    for(int i=0;i<child.length;i++) {
      DisplayObject d = child[child.length-(i+1)];
      stage.pushMulMatrix(d.mat);
      bool r = d.touch(stage, this, id, type, x, y);
      stage.popMatrix();
      if(r == true) {
        return r;
      }
    }

    {
      bool ret = onTouch(stage, id, type, x, y);
      onTouchEnd(stage, id, type, x, y);
      return ret;
    }
  }

  bool onTouch(TinyStage stage, int id, StagePointerType type, double globalX, globalY) {
    return false;
  }

  void onTouchStart(TinyStage stage, int id, StagePointerType type, double x, double y) {
  }

  void onTouchEnd(TinyStage stage, int id, StagePointerType type, double x, double y) {
    ;
  }

  void onUnattach() {}

  void unattach() {
    onUnattach();
    for (DisplayObject d in child) {
      d.unattach();
    }
    isAttach = false;
  }

  void onAttach(TinyStage stage, DisplayObject parent) {}
  attachCheck(TinyStage stage, DisplayObject parent) {
    if(isAttach == false) {
      isAttach = true;
      onAttach(stage, parent);
    }
  }
  bool isAttach = false;

  //
  //
  bool checkFocus(double localX, double localY) {
    return false;
  }
}
