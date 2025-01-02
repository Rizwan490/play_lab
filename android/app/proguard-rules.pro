# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn android.media.LoudnessCodecController$OnLoudnessCodecUpdateListener
-dontwarn android.media.LoudnessCodecController
-dontwarn org.slf4j.impl.StaticLoggerBinder
# Keep GMS and Ads classes
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Keep SLF4J Logger
-keep class org.slf4j.** { *; }
-dontwarn org.slf4j.**

-keep class android.media.LoudnessCodecController$* { *; }

# Keep annotations
-keepattributes *Annotation*

# Retain Lambda expressions
-dontwarn java.lang.invoke.*

# Retain references to missing classes
-ignorewarnings
