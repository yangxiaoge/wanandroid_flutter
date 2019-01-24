package com.bruceyang.wanandroidflutter;
import io.flutter.app.FlutterApplication;
import com.facebook.stetho.Stetho;
import com.tencent.bugly.crashreport.CrashReport;
public class MyApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        // Stetho Chrome 查看手机数据库
        Stetho.initializeWithDefaults(this);
        // Bugly 异常收集
        CrashReport.initCrashReport(getApplicationContext(), "f1b8f07168", BuildConfig.DEBUG);
    }
}