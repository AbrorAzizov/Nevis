package com.example.nevis

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setLocale("ru_RU") // Установи нужный язык (например, русский)
        MapKitFactory.setApiKey("39a54941-0819-4ad3-bec0-ea83ea36e655") // Вставь свой API-ключ
    }
}
