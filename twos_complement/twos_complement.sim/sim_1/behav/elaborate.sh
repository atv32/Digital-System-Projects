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
ExecStep $xv_path/bin/xelab -wto f8bd797ab82d42789fc0abe17529e4d9 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot twos_c_behav xil_defaultlib.twos_c -log elaborate.log
