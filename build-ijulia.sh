#!/bin/bash
source /root/env.sh
julia -E 'Pkg.add("IJulia")'
julia -E 'Pkg.add("PyPlot")'
julia -E 'using IJulia;using PyPlot;using ZMQ'
