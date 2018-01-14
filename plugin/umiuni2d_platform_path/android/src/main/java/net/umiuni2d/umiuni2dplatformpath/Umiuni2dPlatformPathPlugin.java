package net.umiuni2d.umiuni2dplatformpath;

import android.app.Application;
import android.os.Environment;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.util.PathUtils;

/**
 * Umiuni2dPlatformPathPlugin
 */
public class Umiuni2dPlatformPathPlugin implements MethodCallHandler {
  private final Registrar mRegistrar;
  Umiuni2dPlatformPathPlugin(Registrar registrar){
    mRegistrar = registrar;
  }

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "umiuni2d_platform_path");
    channel.setMethodCallHandler(new Umiuni2dPlatformPathPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getApplicationDirectory")) {
      result.success(mRegistrar.context().getFilesDir().getPath());
    } else if (call.method.equals("getCacheDirectory")) {
      result.success(mRegistrar.context().getCacheDir().getPath());
    } else if (call.method.equals("getDocumentDirectory")) {
      result.success(Environment.getExternalStorageDirectory().getAbsolutePath());
    } else {
      result.success(call.method);
//      result.notImplemented();
    }
  }
}
