package com.flutter.volume.flutter_volume_control;

import android.content.Context;

import com.flutter.volume.flutter_volume_control.utils.AudioMngHelper;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterVolumeControlPlugin
 */
public class FlutterVolumeControlPlugin implements MethodCallHandler {

    private static AudioMngHelper audioMngHelper;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_volume_control");
        channel.setMethodCallHandler(new FlutterVolumeControlPlugin());
        audioMngHelper = new AudioMngHelper(registrar.activity());
        audioMngHelper.setVoiceStep100(10);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getVolume")) {
            result.success("" + (audioMngHelper.get100CurrentVolume() * 0.01));
        } else if (call.method.equals("setVolumeLarge")) {
            result.success("" + (audioMngHelper.addVoice100() * 0.01));
        } else if (call.method.equals("setVolumeSmall")) {
            result.success("" + (audioMngHelper.subVoice100() * 0.01));
        }
    }
}
