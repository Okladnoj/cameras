#include "include/cameras/cameras_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "cameras_plugin.h"

void CamerasPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  cameras::CamerasPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
