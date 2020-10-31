#!/bin/bash

set -x
set -e

export MIRTKHOME=/usr/local/mirtk
export WBHOME=/usr/local/workbench
export PATH=$MIRTKHOME/bin:$WBHOME/bin:/bin:$PATH

subject=CC00692XX17
session=200301
scan=$subject-$session
week=42

in_volume=sub-${subject}_ses-${session}_T2w_restore_brain.nii.gz
in_sphere=sub-${subject}_ses-${session}_left_sphere.surf.gii
vol_template=t$week.nii.gz
surf_transform=week40_toFS_LR_rot.L.txt
intermediate_sphere=tmp_rot.surf.gii

# the file we generate
out_dof=$scan.dof
out_doftxt=$(echo $out_dof | sed 's/\.dof/\.txt/g')
out_sphere=left_sphere.rot.surf.gii

echo ::before we start
# gifti_test -infile $in_sphere -show

mirtk register \
  $vol_template \
  $in_volume \
  -model Rigid \
  -sim NMI \
  -bins 64 \
  -dofout $out_dof

mirtk convert-dof \
  $out_dof \
  $out_doftxt \
  -target $vol_template \
  -source $in_volume \
  -output-format flirt

wb_command -surface-apply-affine \
  $in_sphere $out_doftxt $intermediate_sphere

echo ::after surface-apply-affine
# gifti_test -infile $intermediate_sphere -show

wb_command -surface-modify-sphere \
  $intermediate_sphere 100 $intermediate_sphere -recenter

echo ::after surface-modify-sphere
# gifti_test -infile $intermediate_sphere -show

wb_command -surface-apply-affine \
  $intermediate_sphere $surf_transform $out_sphere

echo ::after surface-apply-affine 2
# gifti_test -infile $out_sphere -show

wb_command -surface-modify-sphere \
  $out_sphere 100 $out_sphere -recenter

echo ::after surface-modify-sphere 2
# gifti_test -infile $out_sphere -show

