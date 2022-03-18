CUR_DIR=$(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
FRAME3D=$(CUR_DIR)/bin/MetricDrivenFrame3D
#######################################################################
ifeq ($(MESH), "")
$(shell echo "There is no mesh setting!!!" && exit)
endif
$(info INPUT MESH : $(MESH))
#######################################################################
IN_DIR=$(CUR_DIR)/example
OUT_DIR=$(CUR_DIR)/output
IN_TET=$(IN_DIR)/$(MESH).vtk


#######################################################################
IN_FFC3=$(IN_DIR)/$(MESH)_user.ffc3
FFC3=$(OUT_DIR)/$(MESH).ffc3
METRIC3=$(OUT_DIR)/$(MESH).s3
FF3=$(OUT_DIR)/$(MESH).ff3


ff: $(FF3)

# Consider boundary alignment along with given frame field constraints
$(FFC3): $(IN_TET) $(IN_FFC3)
	$(FRAME3D) prog=ffc3d in_tet=$< in_user_ffc=$(IN_FFC3) out_ffc3=$@

# generate metric with constraints
$(METRIC3): $(IN_TET) $(FFC3)
	$(FRAME3D) prog=metric3d_all in_tet=$< in_ffc3=$(FFC3) out_metric=$@

# generate frame field with metric
$(FF3): $(IN_TET) $(FFC3) $(METRIC3)
	$(FRAME3D) prog=frame3d in_tet=$< in_ffc3=$(FFC3) in_S3=$(METRIC3) out_ff3=$@

########################################################################
IN_METRIC3=$(IN_DIR)/$(MESH)_user.s3
BOUND_FFC3=$(OUT_DIR)/$(MESH)_bd.ffc3
FF3_WITH_M=$(OUT_DIR)/$(MESH)_with_metric.ff3

ff_with_metric: $(FF3_WITH_M)

$(BOUND_FFC3): $(IN_TET)
	$(FRAME3D) prog=ffc3d in_tet=$< out_ffc3=$@

$(FF3_WITH_M): $(IN_TET) $(BOUND_FFC3) $(IN_METRIC3)
	$(FRAME3D) prog=frame3d in_tet=$< in_ffc3=$(BOUND_FFC3) in_S3=$(IN_METRIC3) out_ff3=$@
