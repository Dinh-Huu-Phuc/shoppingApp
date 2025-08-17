plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")         // ✅ đúng cho .kts
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")    // Flutter plugin để sau Android & Kotlin
}

android {
    namespace = "com.example.shopping_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions { jvmTarget = JavaVersion.VERSION_11.toString() }

    defaultConfig {
        applicationId = "com.example.shopping_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release { signingConfig = signingConfigs.getByName("debug") }
    }
}

flutter { source = "../.." }
