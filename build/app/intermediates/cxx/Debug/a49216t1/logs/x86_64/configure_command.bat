@echo off
"D:\\Android\\SDK\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HD:\\Android\\flutter_windows_3.29.0-stable\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=21" ^
  "-DANDROID_PLATFORM=android-21" ^
  "-DANDROID_ABI=x86_64" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86_64" ^
  "-DANDROID_NDK=D:\\Android\\SDK\\ndk\\26.3.11579264" ^
  "-DCMAKE_ANDROID_NDK=D:\\Android\\SDK\\ndk\\26.3.11579264" ^
  "-DCMAKE_TOOLCHAIN_FILE=D:\\Android\\SDK\\ndk\\26.3.11579264\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=D:\\Android\\SDK\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=E:\\IMP Projects\\Portfolio v2\\port_folio\\build\\app\\intermediates\\cxx\\Debug\\a49216t1\\obj\\x86_64" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=E:\\IMP Projects\\Portfolio v2\\port_folio\\build\\app\\intermediates\\cxx\\Debug\\a49216t1\\obj\\x86_64" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BE:\\IMP Projects\\Portfolio v2\\port_folio\\android\\app\\.cxx\\Debug\\a49216t1\\x86_64" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
