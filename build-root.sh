#!/bin/bash
source /root/env.sh
/opt/julia/bin/julia -E 'Pkg.add("ROOT")'
cd /root/.julia/v0.4/ROOT
git checkout v0.0.2
/opt/julia/bin/julia -E 'Pkg.build("ROOT")'
