part of tinygame_webgl;

class TinyWebglCanvas extends TinyCanvasRoze {

  RenderingContext GL;
  TinyWebglContext glContext;
  int maxVertexTextureImageUnits = 3;
  double get contextWidht => glContext.widht;
  double get contextHeight => glContext.height;

  //-2.0 / glContext.height

  TinyWebglCanvas(TinyWebglContext c, {int numOfCircleElm:16}) {
    GL = c.GL;
    glContext = c;
    this.numOfCircleElm = numOfCircleElm;
    init();
    clear();
  }
  Program programShape;

  void init() {
    maxVertexTextureImageUnits = GL.getParameter(RenderingContext.MAX_VERTEX_TEXTURE_IMAGE_UNITS);
    print("#[A] MAX_VERTEX_TEXTURE_IMAGE_UNITS # ${GL.getParameter(RenderingContext.MAX_VERTEX_TEXTURE_IMAGE_UNITS)}");
    print("#[B] ALIASED_POINT_SIZE_RANGE       # ${GL.getParameter(RenderingContext.ALIASED_POINT_SIZE_RANGE)}");
    print("#[B] ALIASED_POINT_SIZE_RANGE       # ${GL.getParameter(RenderingContext.ALIASED_POINT_SIZE_RANGE)}");
    {
      String vs = [
        "attribute vec3 vp;",
        "attribute vec4 color;",
        "attribute float useTex;",
        "varying float v_useTex;",
        "attribute vec2 a_tex;",
        "varying vec2 v_tex;",
        "uniform mat4 u_mat;",
        "varying vec4 vColor;",
        "",
        "void main() {",
        "  v_useTex = useTex;",
        "  gl_Position = u_mat*vec4(vp.x,vp.y,vp.z,1.0);",
        "  if(useTex < 0.0){",
        "    vColor = color;",
        "  }",
        "  else {",
        "    vColor = color;",
        "    v_tex = a_tex;",
        "  }",
        "  gl_PointSize = 1.0;//u_point_size;",
        "",
        "}"
      ].join("\n");
      String fs = [
        "precision mediump float;",
        "varying vec2 v_tex;",
         "varying vec4 vColor;",
         "varying float v_useTex;",
         "uniform sampler2D u_image;",
         "void main() {",
         "  if(v_useTex < 0.0){",
         "    gl_FragColor = vColor;", "  }",
         "  else {",
         "    gl_FragColor = vColor * texture2D(u_image, v_tex);",
         "  }",
         "}"].join("\n");
      programShape = TinyWebglProgram.compile(GL, vs, fs);
    }
    {

    }
  }

  void clear() {
    stencilV = 1;
    flZ = -0.5;
    double r = 0.0;
    double g = 0.0;
    double b = 0.0;
    double a = 1.0;
    // GL.enable(RenderingContext.DEPTH_TEST);
    GL.enable(RenderingContext.STENCIL_TEST);
    GL.depthFunc(RenderingContext.LEQUAL);
    GL.clearColor(r, g, b, a);
    GL.clearDepth(1.0);
    GL.clearStencil(0);
    GL.enable(RenderingContext.BLEND);
    GL.viewport(0, 0, glContext.widht.toInt(), glContext.height.toInt());

    //
    GL.blendEquation(RenderingContext.FUNC_ADD);
    GL.blendFuncSeparate(RenderingContext.SRC_ALPHA, RenderingContext.ONE_MINUS_SRC_ALPHA, RenderingContext.SRC_ALPHA, RenderingContext.ONE_MINUS_CONSTANT_ALPHA);

    GL.clear(RenderingContext.COLOR_BUFFER_BIT | RenderingContext.STENCIL_BUFFER_BIT | RenderingContext.DEPTH_BUFFER_BIT);
    flVert.clear();
    flInde.clear();
    flTex.clear();
    flImg = null;
  }

  void flush() {
    if (flVert.length != 0) {
      drawVertex(flVert, flInde, new TinyColor.argb(0xaa, 0xff, 0xaa, 0xaa));
      flVert.clear();
      flInde.clear();
      flTex.clear();
      flImg = null;
    }
  }

  void drawVertex(List<double> svertex, List<int> index, TinyColor color) {
    //
    //
    GL.useProgram(programShape);
    int texLocation = 0;

    texLocation = GL.getAttribLocation(programShape, "a_tex");
    Buffer texBuffer = GL.createBuffer();
    GL.bindBuffer(RenderingContext.ARRAY_BUFFER, texBuffer);

    GL.bufferData(RenderingContext.ARRAY_BUFFER, new Float32List.fromList(flTex), RenderingContext.STATIC_DRAW);
    GL.enableVertexAttribArray(texLocation);

    GL.vertexAttribPointer(texLocation, 2, RenderingContext.FLOAT, false, 0, 0);
    if (flImg != null) {
      {
        Texture tex = (flImg as TinyWebglImage).getTex(GL);
        GL.bindTexture(RenderingContext.TEXTURE_2D, tex);

        GL.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_S, RenderingContext.CLAMP_TO_EDGE);
        GL.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_T, RenderingContext.CLAMP_TO_EDGE);
        GL.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MIN_FILTER, RenderingContext.NEAREST);
        GL.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MAG_FILTER, RenderingContext.NEAREST);
      }
    }
    //
    // vertex
    Buffer rectBuffer = TinyWebglProgram.createArrayBuffer(GL, svertex);
    GL.bindBuffer(RenderingContext.ARRAY_BUFFER, rectBuffer);

    Buffer rectIndexBuffer = TinyWebglProgram.createElementArrayBuffer(GL, index);
    GL.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, rectIndexBuffer);

    //

    //
    // draw
    int locationAttributeUseTex;
    {
      TinyWebglProgram.setUniformMat4(GL, programShape, "u_mat", baseMat);
      int colorAttribLocation = GL.getAttribLocation(programShape, "color");
      int locationVertexPosition = GL.getAttribLocation(programShape, "vp");
      locationAttributeUseTex = GL.getAttribLocation(programShape, "useTex");

      GL.vertexAttribPointer(locationVertexPosition, 3, RenderingContext.FLOAT, false, 4 * 8, 0);
      GL.vertexAttribPointer(colorAttribLocation, 4, RenderingContext.FLOAT, false, 4 * 8, 4 * 3);
      GL.vertexAttribPointer(locationAttributeUseTex, 1, RenderingContext.FLOAT, false, 4 * 8, 4 * 7);
      GL.enableVertexAttribArray(locationVertexPosition);
      GL.enableVertexAttribArray(colorAttribLocation);
      GL.enableVertexAttribArray(locationAttributeUseTex);
      GL.drawElements(
          RenderingContext.TRIANGLES,
          //RenderingContext.LINE_STRIP,
          index.length, //svertex.length ~/ 3,
          RenderingContext.UNSIGNED_SHORT,
          0);
    }
    if (texLocation != 0) {
      GL.disableVertexAttribArray(texLocation);
      GL.bindTexture(RenderingContext.TEXTURE_2D, null);
    }
    GL.useProgram(null);
  }


  void clearClip(TinyStage stage) {
    flush();
    stencilV = 1;
    GL.clearStencil(0);
  }

  void clipRect(TinyStage stage, TinyRect rect, {Matrix4 m:null}) {
    flush();
    GL.colorMask(false, false, false, false);
    GL.depthMask(false);
    GL.stencilOp(RenderingContext.KEEP, RenderingContext.REPLACE, RenderingContext.REPLACE);
    GL.stencilFunc(RenderingContext.ALWAYS, stencilV, 0xff);

    //

    TinyPaint p = new TinyPaint();
    p.color = new TinyColor.argb(0xff, 0xff, 0xff, 0xff);
    drawFillRect(null, rect, p, m:m);
    flush();
    //

    // GL.disable(RenderingContext.STENCIL_TEST);
    //
    GL.colorMask(true, true, true, true);
    GL.depthMask(true);
    GL.stencilOp(RenderingContext.KEEP, RenderingContext.KEEP, RenderingContext.KEEP);
    // todo
    GL.stencilFunc(RenderingContext.LEQUAL, stencilV, 0xff);
    stencilV++;
  }

  //bool a = false;
  void drawImageRect(TinyStage stage, TinyImage image, TinyRect src, TinyRect dst, TinyPaint paint,
    {TinyCanvasTransform transform: TinyCanvasTransform.NONE, List<Object> cache: null}) {

    if (flImg != null && flImg != image) {
      //TinyImage tmp = flImg;
      flush();
      // todo
      //flImg.dispose();
    }
    flImg = image;

    double xs = src.x / flImg.w;
    double ys = src.y / flImg.h;
    double xe = (src.x + src.w) / flImg.w;
    double ye = (src.y + src.h) / flImg.h;
    //print("############### ${xs} ${ys} ${xe} ${ye} ##############");
    switch (transform) {
      case TinyCanvasTransform.NONE:
        flTex.addAll([xs, ys, xs, ye, xe, ys, xe, ye]);
        break;
      case TinyCanvasTransform.ROT90:
        flTex.addAll([xs, ye, xe, ye, xs, ys, xe, ys]);
        break;
      case TinyCanvasTransform.ROT180:
        flTex.addAll([xe, ye, xe, ys, xs, ye, xs, ys]);
        break;
      case TinyCanvasTransform.ROT270:
        flTex.addAll([xe, ys, xs, ys, xe, ye, xs, ye]);
        break;
      case TinyCanvasTransform.MIRROR:
        flTex.addAll([xe, ys, xe, ye, xs, ys, xs, ye]);
        break;
      case TinyCanvasTransform.MIRROR_ROT90:
        flTex.addAll([xs, ys, xe, ys, xs, ye, xe, ye]);
        break;
      case TinyCanvasTransform.MIRROR_ROT180:
        flTex.addAll([xs, ye, xs, ys, xe, ye, xe, ys]);
        break;
      case TinyCanvasTransform.MIRROR_ROT270:
        flTex.addAll([xe, ye, xs, ye, xe, ys, xs, ys]);
        break;
      default:
        flTex.addAll([xs, ys, xs, ye, xe, ys, xe, ye]);
    }

    //
    //
    //
    Matrix4 m = calcMat();
    double sx = dst.x;
    double sy = dst.y;
    double ex = dst.x + dst.w;
    double ey = dst.y + dst.h;

    Vector3 ss1 = m * new Vector3(sx, sy, 0.0);
    Vector3 ss2 = m * new Vector3(sx, ey, 0.0);
    Vector3 ss3 = m * new Vector3(ex, sy, 0.0);
    Vector3 ss4 = m * new Vector3(ex, ey, 0.0);

    int b = flVert.length ~/ 8;
    double colorR = paint.color.r / 0xff;
    double colorG = paint.color.g / 0xff;
    double colorB = paint.color.b / 0xff;
    double colorA = paint.color.a / 0xff;
    flVert.addAll([
      ss1.x, ss1.y, flZ, // 7
      colorR, colorG, colorB, colorA, // color
      1.0,
      ss2.x, ss2.y, flZ, // 1
      colorR, colorG, colorB, colorA, // color
      1.0,
      ss3.x, ss3.y, flZ, // 9
      colorR, colorG, colorB, colorA, // color
      1.0,
      ss4.x, ss4.y, flZ, //3
      colorR, colorG, colorB, colorA, // color
      1.0
    ]);
    flZ += 0.0001;
    //b= 0;
    flInde.addAll([b + 0, b + 1, b + 2, b + 1, b + 3, b + 2]);
  }

  void updateMatrix() {}

  Matrix4 calcMat() {
    cacheMatrix.setIdentity();
    //cacheMatrix =
    cacheMatrix.translate(-1.0, 1.0, 0.0);
    //cacheMatrix =
    cacheMatrix.scale(2.0 / glContext.widht, -2.0 / glContext.height, 1.0);
    cacheMatrix = cacheMatrix * getMatrix();
    return cacheMatrix;
  }
}
