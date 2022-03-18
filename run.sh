#! /bin/bash

cd `dirname $0`
chmod +x ./bin/MetricDrivenFrame3D


# one case for flat-metric
make -f test.mk ff_with_metric MESH=kittenhex

# one case for designed metric
# make -f test.mk ff MESH=cuboid95k


# results of metric (.S3) and ff (.ff3) are stored with binary,
# they can be transformed into ascii format by below cmd
#./bin/MetricDrivenFrame3D prog=mat_b2a in_mat=<...> out_mat=<...>
# also reversed
#./bin/MetricDrivenFrame3D prog=mat_a2b in_mat=<...> out_mat=<...>
