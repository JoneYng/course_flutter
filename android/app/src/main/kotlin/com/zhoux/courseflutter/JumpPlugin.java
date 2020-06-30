package com.zhoux.courseflutter;

/**
 * @author zhouxiang
 * @fileName MobileStatePlugin
 * @date or  2020/6/28 2:07 PM
 * @describe TODO
 */

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import androidx.annotation.NonNull;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/** JumpPlugin */
public class JumpPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
    private static final int                MY_PERMISSIONS_REQUEST_READ_PHONE_STATE = 0;
    public static String CHANNEL = "com.kmf.jump/plugin";

    static       Activity activity;

    ///activity 生命周期
    @Override
    public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
        Log.e("onAttachedToActivity", "onAttachedToActivity");
        activity = activityPluginBinding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        Log.e("onDetachedFromActivityForConfigChanges", "onDetachedFromActivityForConfigChanges");

    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
        Log.e("onReattachedToActivityForConfigChanges", "onReattachedToActivityForConfigChanges");
    }

    @Override
    public void onDetachedFromActivity() {
        Log.e("onDetachedFromActivity", "onDetachedFromActivity");
    }


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), CHANNEL);
        channel.setMethodCallHandler(new JumpPlugin());
    }


    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new JumpPlugin());
        activity = registrar.activity();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("oneAct")) {
            //解析参数
            String text = call.argument("polyId");
            //带参数跳转到指定Activity
            Intent intent = new Intent(activity, OneActivity.class);
            intent.putExtra("polyId", text);
            activity.startActivity(intent);
            //返回给flutter的参数
            result.success("success");
        }
        else {
            result.notImplemented();
        }
    }


    public void onRequestPermissionsResult(int requestCode,
                                           String[] permissions, int[] grantResults) {
        switch (requestCode) {
            case MY_PERMISSIONS_REQUEST_READ_PHONE_STATE: {
                // If request is cancelled, the result arrays are empty.
                if (grantResults.length > 0
                        && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    // permission was granted, yay! Do the
                    // contacts-related task you need to do.
                } else {
                    // permission denied, boo! Disable the
                    // functionality that depends on this permission.
                }
                return;
            }

            // other 'case' lines to check for other
            // permissions this app might request.
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }


}
