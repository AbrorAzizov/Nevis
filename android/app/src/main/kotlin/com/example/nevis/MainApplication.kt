package com.example.nevis

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("39a54941-0819-4ad3-bec0-ea83ea36e655") // Замените на свой API-ключ
        MapKitFactory.initialize(this)
    }
}