package com.apteka.nevis

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("6127076d-e153-4873-be2b-1e927e3730d4") // Замените на свой API-ключ
        MapKitFactory.initialize(this)
    }
}