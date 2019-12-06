# DON'T CHANGE THIS FILE if not in fc-tools package
#   automaticaly updated from fc-tools package with update_package command
# 
PYRUN=python3
MATLABVER=2017a
OCTAVEVER=4.2.1

OCTAVELIST="4.2.0 4.2.1 4.2.2 4.4.0"
MATLABLIST="2015b 2016a 2016b 2017a 2017b 2018a 2018b"

GIT_SSH_CONFIG=ssh://lagagit/MCS/Cuvelier/config
GIT_PYTHON_REP=ssh://lagagit/MCS/Cuvelier/Python
GIT_MATLAB_REP=ssh://lagagit/MCS/Cuvelier/Matlab
WEB_CODES=http://www.math.univ-paris13.fr/~cuvelier/software/codes
HERCULE_DIR=/home/cuvelier/Travail/Recherch/Matlab/fc-config/build
HERCULE_DOC_DIR=$HERCULE_DIR/doc
HERCULE_DIST_DIR=$HERCULE_DIR/dist
MACOUI_DIR=/users/cuvelier/public_html/software/codes
TMP_NAME=tmpdir
TMP_DIR=$ROOT_DIR/$TMP_NAME
TMP_ARCHIVE=${TMP_DIR}/archive
TMP_DOC=${TMP_DIR}/doc
DIST_DIR=$ROOT_DIR/dist
DOC_DIR=$ROOT_DIR/doc 

LOGS_DIR=$ROOT_DIR/logs
LATEXFILE=special/cmd.tex

# List of directories generated with LaTeX compilation of docs
LDIR="codes results tabular benchs figures special"
