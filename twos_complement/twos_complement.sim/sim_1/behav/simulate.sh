#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2017.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim twos_c_behav -key {Behavioral:sim_1:Functional:twos_c} -tclbatch twos_c.tcl -log simulate.log
