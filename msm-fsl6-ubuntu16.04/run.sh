export FSLDIR=/usr/local/fsl
. $FSLDIR/etc/fslconf/fsl.sh
export PATH=$FSLDIR/bin:$PATH

msm --levels=3 \
  --conf=config_strain_NEWSTRAIN_SPHERE_LONGITUDINAL_new \
  --inmesh=Conte69.L.sphere.AFFINE.surf.gii \
  --refmesh=Conte69.L.sphere.32k_fs_LR.surf.gii \
  --indata=sub-CC00692XX17_ses-200301_left_sulc.shape.gii \
  --refdata=Conte69.L.32k_fs_LR.shape.gii \
  --out=test-L. \
  --verbose

