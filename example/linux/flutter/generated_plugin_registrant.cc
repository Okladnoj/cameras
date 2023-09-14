//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <cameras/cameras_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) cameras_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CamerasPlugin");
  cameras_plugin_register_with_registrar(cameras_registrar);
}
