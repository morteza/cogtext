#!/bin/bash

#SBATCH --job-name=cogtext_topic_embedding
#SBATCH --chdir=/work/projects/acnets/repositories/
#SBATCH --output=/work/projects/acnets/logs/%x_%A.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=24gb
#SBATCH --partition=batch
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=morteza.ansarinia@uni.lu


echo "SLURM_JOB_ID: " $SLURM_JOB_ID


# enable access to the `module` and install conda.
[ -f /etc/profile ] && source /etc/profile
module purge
module load lang/Anaconda3

# purge old stuff (conda env, codes, data, outputs, etc)
conda deactivate
conda env remove -n cogtext

if [ ! -d "cogtext/" ]
then 
  git clone --recurse-submodules -j8 ssh://git@gitlab.uni.lu:8022/xcit/efo/cognitive-tests-text-analysis.git
  cd cogtext/
else
  cd cogtext/
  git pull --recurse-submodules -j8
fi


# create and prepare a new conda environment (also installs git and git-lfs via conda)
conda create -n cogtext python=3.9 --yes
source activate cogtext
conda install -c conda-forge git git-lfs

# install dependencies and ipython to run the notbooks
pip install pip -U
pip install -r requirements_hpc.txt
# pip install ipython jupyter

# run the code
python jobs/topic_embedding.py

# push the BIDS changes back to the gitlab repository
git add -A .
git commit -m "CI/HPC/topic_embedding.sh auto-commit (SLURM_JOB_ID: ${SLURM_JOB_ID})"
git push origin dev

# That's it!