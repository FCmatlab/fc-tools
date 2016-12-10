#!/bin/python3
# rsync -a --files-from=:/path/file-list src:/ /tmp/copy
# git archive --remote=ssh://lagagit/MCS/Cuvelier/mVecFEMP1Light.git HEAD FILES.TXT  
import os
import shutil
import sys

filename = sys.argv[1]

with open(filename) as f:
    for line in f:
        line = line.split('#', 1)[0]
        line = line.rstrip()
        if len(line)>0:
            print(line)
            
