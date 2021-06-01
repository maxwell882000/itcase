package com.itcase.itcase

import androidx.annotation.NonNull; 
import io.flutter.embedding.android.FlutterActivity; 
import io.flutter.embedding.engine.FlutterEngine; 
import io.flutter.plugins.GeneratedPluginRegistrant; 
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    
     override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("a4c4f2a7-efb4-4e77-805b-c79426d402b2")
        super.configureFlutterEngine(flutterEngine)
    }
}
