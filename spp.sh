#!/bin/bash
#
# basic preprocessor for shellscript
#
# supports following C-style macros:
#
# include:
#  #include "somefile.sh.in"
#
# conditional for environment variables:
#  #ifdef VAR
#  #else
#  #endif # comment here allowed
#
set -o nounset
set -o errexit
set -o pipefail
IFS=$'\n\t'

ifdef_re="^#ifdef (\w+)$"
else_re="^#else$"
endif_re="^#endif"
include_re="^#include \"(.*)\"$"

process_file() {
    local includeline=true

    while read -r line; do
        # recursively process includes
        if [[ "${line}" =~ ${include_re} ]]; then
            process_file "${BASH_REMATCH[1]}"
        # include lines if the #ifdef VAR is set
        elif [[ "${line}" =~ ${ifdef_re} ]]; then
            defvar=${BASH_REMATCH[1]}
            [[ -n "${!defvar:-}" ]] \
                && includeline=true || includeline=false
        # if the define was true, drop lines
        # after the #else
        elif [[ "${line}" =~ ${else_re} ]]; then
            [[ "${includeline}" = true ]] \
                && includeline=false || includeline=true
        # include lines after the #endif
        elif [[ "${line}" =~ ${endif_re} ]]; then
            includeline=true
        else
        # print the line
            [[ "${includeline}" = true ]] \
                && echo "${line}"
        fi
    done < "${1}"
}

# define the target shell
# TARGETSHELL=bash --> BASHSHELL=1
[ -n "${TARGETSHELL:-}" ] \
    && printf -v "${TARGETSHELL^^}SHELL" "1"

process_file "${1}"