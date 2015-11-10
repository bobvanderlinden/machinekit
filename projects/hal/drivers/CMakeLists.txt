hal_driver_comp_add_module(mesa_7i65)
# target_include_directories(mesa_7i65 PRIVATE
#   ${MACHINEKIT_SOURCE_DIR}/rtapi/userpci/include)

hal_driver_comp_add_module(mesa_uart)
hal_driver_comp_add_module(pcl720)
# FIXME pull in pluto_servo_rbf.h, pluto_step_rbf.h rules
# hal_driver_comp_add_module(pluto_servo)
# hal_driver_comp_add_module(pluto_step)
hal_driver_comp_add_module(serport)
