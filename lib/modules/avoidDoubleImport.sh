#!/usr/bin/env bash

moduleFile=`basename "$0"`

# avoid double inclusion
if test "${BashInclude__imported+defined}" == "defined"
then
    echo "module File $moduleFile already imported"
    return 0
fi
BashInclude__imported=1


