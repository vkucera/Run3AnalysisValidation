#!/bin/bash
# shellcheck disable=SC2034 # Ignore unused parameters.

# Input specification for runtest.sh
# (Modifies input parameters.)

INPUT_CASE=2            # Input case

NFILESMAX=1             # Maximum number of processed input files. (Set to -0 to process all; to -N to process all but the last N files.)

# Number of input files per job (Automatic optimisation on if < 1.)
NFILESPERJOB_CONVERT=0  # Conversion
NFILESPERJOB_ALI=0      # AliPhysics
NFILESPERJOB_O2=1       # O2

# Maximum number of simultaneously running O2 jobs
NJOBSPARALLEL_O2=$(python3 -c "print(min(10, round($(nproc) / 2)))")

JSONRUN3="dpl-config_run3.json"  # Run 3 tasks parameters
JSONRUN3="dpl-config_test.json"  # Run 3 tasks parameters
# Run 5 tasks parameters for open HF study
JSONRUN5_HF="dpl-config_run5_hf.json"
# Run 5 tasks parameters for onia studies:
# J/psi and X (higher pt cut on 2-prong decay tracks and no DCA cut on single track)
JSONRUN5_ONIAX="dpl-config_run5_oniaX.json"
JSON="$JSONRUN3"

INPUT_FILES="AliESDs.root"  # Input file pattern
INPUT_SYS=""
INPUT_RUN=0

case $INPUT_CASE in
  1)
    INPUT_LABEL="Run 2, p-p real LHC17p"
    INPUT_DIR="/mnt/data/Run2/LHC17p_pass1_CENT_woSDD/282341"
    INPUT_SYS="pp"
    INPUT_RUN=2;;
  2)
    INPUT_LABEL="Run 2, p-p MC LHC17p"
    INPUT_DIR="/mnt/data/Run2/LHC18a4a2_cent/282099"
    INPUT_SYS="pp"
    INPUT_RUN=2
    ISMC=1;;
  3)
    INPUT_LABEL="Run 2, p-p MC LHC17p"
    INPUT_DIR="/mnt/data/Run2/LHC18a4a2_cent/282341"
    INPUT_SYS="pp"
    INPUT_RUN=2
    ISMC=1;;
  4)
    INPUT_LABEL="Run 2, Pb-Pb real LHC15o"
    INPUT_DIR="/mnt/data/Run2/LHC15o/246751/pass1"
    INPUT_SYS="PbPb"
    INPUT_RUN=2
    TRIGGERSTRINGRUN2="CV0L7-B-NOPF-CENT"
    TRIGGERBITRUN3=5;; #FIXME
  5)
    INPUT_LABEL="Run 2, Pb-Pb MC LHC15o"
    INPUT_DIR="/mnt/data/Run2/LHC15k1a3/246391"
    INPUT_SYS="PbPb"
    INPUT_RUN=2
    ISMC=1;;
  6)
    INPUT_LABEL="Run 2, p-p MC LHC16p, dedicated Ξc"
    INPUT_DIR="/mnt/data/Run2/LHC19g6f3/264347"
    INPUT_SYS="pp"
    INPUT_RUN=2
    ISMC=1;;
  7)
    INPUT_LABEL="Run 5, p-p MC 14 TeV MB, Layout v1, HF analysis"
    INPUT_DIR="/data/Run5/MC/pp_14TeV/MB_v1"
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_HF"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  8)
    INPUT_LABEL="Run 5, p-p MC 14 TeV MB, Layout v1, onia analysis"
    INPUT_DIR="/home/auras/simulations/delphes/pp_MB_2021_06_10" # OBSOLETE
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_ONIAX"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  9)
    INPUT_LABEL="Run 5, p-p MC 14 TeV OniaX-enriched, Layout v1, oniaX analysis"
    INPUT_DIR="/data/Run5/MC/pp_14TeV/OniaX_v1"
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_ONIAX"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  10)
    INPUT_LABEL="Run 5, p-p MC 14 TeV ccbar-enriched, Layout v1, HF analysis"
    INPUT_DIR="/data/Run5/MC/pp_14TeV/CCBarLcPKPi_v1"
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_HF"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  11)
    INPUT_LABEL="Run 5, Kr-Kr MC 6.460 TeV MB, Layout v1, HF analysis"
    INPUT_DIR="/data/Run5/MC/KrKr_6p460TeV/MB_v1" # OBSOLETE
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_HF"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  12)
    INPUT_LABEL="Run 5, p-p MC 14 TeV OniaX-enriched, Layout v1, oniaX analysis MUON ID"
    INPUT_DIR="/home/auras/simulations/delphes/pp_ONIA_X_2021_06_10/run_002" # OBSOLETE
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_ONIAX"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  13)
    INPUT_LABEL="Run 5, Pb-Pb MC 5.520 TeV MB, Layout v1, HF analysis"
    INPUT_DIR="/data/Run5/MC/PbPb_5p520TeV/MB_v1"
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_HF"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  14)
    INPUT_LABEL="Run 5, p-p MC 14 TeV Xicc-enriched, Layout v1, HF analysis"
    INPUT_DIR="/home/mmazzill/pp14TeV_XiccGun_20M_geometry_v1_19082021"
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_HF"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  15)
    INPUT_LABEL="Run 5, p-p MC 14 TeV OniaX-enriched, Layout v1, oniaX analysis MUON ID and ECAL"
    INPUT_DIR="/home/kharlov/ECAL+PCM/delphes/pp_onia_X_2021_10_10"
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_ONIAX"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  16)
    INPUT_LABEL="Run 5, PbPb 5.5 TeV, Layout v1, MB MUON ID and ECAL"
    INPUT_DIR="/home/mmazzill/PbPb_100K_inel_2T_rmin100_11102021"
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_ONIAX"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
  17)
    INPUT_LABEL="Run 5, pp 14 TeV, Layout v1, MB MUON ID and ECAL"
    INPUT_DIR="/home/mmazzill/pp14TeV_inel_20M_2T_rmin100_geometry_v1_11102021"
    INPUT_FILES="AODRun5.*.root"
    JSON="$JSONRUN5_ONIAX"
    ISINPUTO2=1
    ISALICE3=1
    ISMC=1;;
esac
