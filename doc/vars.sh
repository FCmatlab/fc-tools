#!/bin/bash
# DON'T CHANGE THIS FILE if not in fc-example package
#   automaticaly updated from fc-example package with update_package command
# 

PYRUN=python3
PDFLATEX="pdflatex --synctex=1 -shell-escape "

MATLABVER=2019a
OCTAVEVER=5.1.0

OCTAVELIST="4.2.0 4.2.1 4.2.2 4.4.0 4.4.1 5.1.0"
MATLABLIST="2015b 2016a 2016b 2017a 2017b 2018a 2018b 2019a"

GIT_SSH_CONFIG=ssh://lagagit/MCS/Cuvelier/config
GIT_PYTHON_REP=ssh://lagagit/MCS/Cuvelier/Python
GIT_MATLAB_REP=ssh://lagagit/MCS/Cuvelier/Matlab


#COMPUTERSERVER=hercule
COMPUTERSERVER=zbook17


COMPUTERSERVER_DIR=${COMPUTERSERVER}/Travail/Recherch/Matlab/fc-config/build
COMPUTERSERVER_DOC_DIR=${COMPUTERSERVER_DIR}/doc
COMPUTERSERVER_DIST_DIR=${COMPUTERSERVER_DIR}/dist


WEBSERVER=macoui
WEB_CODES=http://www.math.univ-paris13.fr/~cuvelier/software/codes
WEBSERVER_DIR=/users/cuvelier/public_html/software/codes


TMP_NAME=tmpdir
TMP_DIR=$ROOT_DIR/$TMP_NAME
TMP_ARCHIVE=${TMP_DIR}/archive
TMP_DOC=${TMP_DIR}/doc
DIST_DIR=$ROOT_DIR/dist
DOC_DIR=$ROOT_DIR/doc 

LOGS_DIR=$ROOT_DIR/logs
LATEXFILE=cmd.tex

# List of directories generated with LaTeX compilation of docs
LDIR="codes results tabular benchs figures special"
