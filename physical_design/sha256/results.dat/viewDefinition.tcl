create_library_set -name max_lib\
   -timing\
    [list Downloads/gsclib045_all_v4.8/gsclib045/timing/fast_vdd1v0_basicCells.lib]
create_library_set -name min_lib\
   -timing\
    [list Downloads/gsclib045_all_v4.8/gsclib045/timing/slow_vdd1v0_basicCells.lib]
create_op_cond -name min -library_file Downloads/gsclib045_all_v4.8/gsclib045/timing/slow_vdd1v0_basicCells.lib -P 10 -V 10 -T 10
create_op_cond -name max -library_file Downloads/gsclib045_all_v4.8/gsclib045/timing/fast_vdd1v0_basicCells.lib -P 10 -V 10 -T 10
create_rc_corner -name min_rc\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0
create_rc_corner -name max_rc\
   -cap_table Downloads/gsclib045_all_v4.8/gsclib045/qrc/qx/gpdk045.tch\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0
create_delay_corner -name min\
   -library_set min_lib\
   -rc_corner min_rc
create_delay_corner -name max_delay\
   -library_set max_lib\
   -rc_corner max_rc
create_constraint_mode -name m\
   -sdc_files\
    [list /home/niorr/pj/project_7/physical_design/sha256/results.dat/mmmc/modes/m/m.sdc]
create_analysis_view -name apb -constraint_mode m -delay_corner min -latency_file /home/niorr/pj/project_7/physical_design/sha256/results.dat/mmmc/views/apb/latency.sdc
set_analysis_view -setup [list apb] -hold [list apb]
