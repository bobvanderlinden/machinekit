# Regular comps
hal_comp_add_module(bldc)
hal_comp_add_module(charge_pump)
hal_comp_add_module(logic)
hal_comp_add_module(message)
hal_comp_add_module(rtfault)
hal_comp_add_module(rtmon)
hal_comp_add_module(sim_axis_hardware)
hal_comp_add_module(sim_parport)
hal_comp_add_module(sim_spindle)
hal_comp_add_module(steptest)
hal_comp_add_module(timedelta)
hal_comp_add_module(xhc_hb04_util)

# Generated comps from conv.comp.in
hal_conv_comp_add_module(conv_float_s32 float s32 -2147483647-1 2147483647)
hal_conv_comp_add_module(conv_float_u32 float u32             0 2147483647)
hal_conv_comp_add_module(conv_bit_s32   bit   s32                         )
hal_conv_comp_add_module(conv_bit_u32   bit   u32                         )
hal_conv_comp_add_module(conv_s32_float s32   float                       )
hal_conv_comp_add_module(conv_s32_bit   s32   bit             0          1)
hal_conv_comp_add_module(conv_s32_u32   s32   u32             0          0)
hal_conv_comp_add_module(conv_u32_float u32   float                       )
hal_conv_comp_add_module(conv_u32_bit   u32   bit            -1          1)
hal_conv_comp_add_module(conv_u32_s32   u32   s32            -1 2147483647)

# TODO:
#
# Executables:  halsampler halstreamer
# Modules:  delayline
