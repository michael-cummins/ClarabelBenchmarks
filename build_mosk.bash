#!/bin/bash
#PBS -l select=1:ncpus=2:mem=16gb
#PBS -l walltime=00:30:00
#PBS -N mosek_build

cp -r $HOME/ $TMPDIR/

# 1. Move to your home directory
cd $TMPDIR

# 2. Download the MOSEK Linux 64-bit x86 tarball
# (Check mosek.com/downloads/ for the exact latest version number, e.g., 11.2.2)
wget https://download.mosek.com/stable/11.2.2/mosektoolslinux64x86.tar.bz2

# 3. Extract the archive (this creates a 'mosek' directory)
tar -xvf mosektoolslinux64x86.tar.bz2

# 4. Clean up the tarball
rm mosektoolslinux64x86.tar.bz2

# 5. Add MOSEK binaries to your PATH (Append this to your ~/.bashrc for persistence)
export PATH=$HOME/mosek/11.2/tools/platform/linux64x86/bin:$PATH

cp $TMPDIR/ $HOME/
