# MetricDrivenFrame3D

Executable file of the paper [Metric-Driven 3D Frame Field Generation](https://doi.org/10.1109/TVCG.2021.3136199)

Author: Xianzhong Fang , Email: xzfangcs@163.com

Compilation Environment: Ubuntu 20.04.1 (Linux)

Install Third Libraries in Ubuntu 20.04
```console
sudo apt install gfortran libalglib-dev libblas-dev libcholmod3 libgomp1 minpack-dev petsc-dev
```


A simple test
```
bash run.sh
```

## File Format
### Frame field file format  (ff3)
N is the number of tetrahedra, the frame in each tet is defined as a 3x3 matrix.
```
9 N
F11 F21 F31 F21 F22 F23 F31 F32 F33
...
...
...
```

### Metric field file format (s3)
N is the number of tetrahedra, S=g^{-1/2} in each tet is defined as a 3x3 SPD.
In order to save space, store each metric with half of SPD.
```
6 N
S11 S21 S31 S22 S32 S33
...
...
...
```

### Frame field constraints file format (ffc3)
```
number-of-constraints
tet-id plane v1 v2 v3 weight
tet-id frame x1 y1 z1 x2 y2 z2 weight
tet-id size s weight
...
...
```

### Format transformation
The results are stored with binary, can be transformed into ASCII by
```
./bin/MetricDrivenFrame3D prog=mat_b2a in_mat=<...> out_mat=<...>
```
also reversed by
```console
./bin/MetricDrivenFrame3D prog=mat_a2b in_mat=<...> out_mat=<...>
```
