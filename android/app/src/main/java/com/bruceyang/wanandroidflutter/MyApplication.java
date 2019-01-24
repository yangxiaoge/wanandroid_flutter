package com.bruceyang.wanandroidflutter;
import io.flutter.app.FlutterApplication;
import com.facebook.stetho.Stetho;
public class MyApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        // Stetho Chrome 查看手机数据库
        Stetho.initializeWithDefaults(this);
    }
}