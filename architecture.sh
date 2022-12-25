
# Some functions that help to deal with different architectures.

function is_in_list()
{
    local LIST=$1
    local DELIMITER=$2
    local VALUE=$3
    [[ "$LIST" =~ ($DELIMITER|^)$VALUE($DELIMITER|$) ]]
}

function get_sys_arch() 
{
    uname -m
}

function get_docker_arch()
{
    local ARCH=$(get_sys_arch)
    local SUPPORTED_ARCHS="x86_64,aarch64"

    if [[ ! 'is_in_list "${SUPPORTED_ARCHS}" "," "${ARCH}"' ]]; then
        >&2 echo "Unsupported architecture: ${ARCH}"
        >&2 echo "Supported are: ${SUPPORTED_ARCHS}. "
        exit 1
    fi

    if [ "${ARCH}" == "x86_64" ]; then
        echo "x86"
    elif [ "${ARCH}" == "aarch64" ]; then
        echo "arm"
    fi
}

function get_docker_nvidia_option()
{
    local ARCH=$(get_sys_arch)
    local SUPPORTED_ARCHS="x86_64,aarch64"

    if [[ ! 'is_in_list "${SUPPORTED_ARCHS}" "," "${ARCH}"' ]]; then
        >&2 echo "Unsupported architecture: ${ARCH}"
        >&2 echo "Supported are: ${SUPPORTED_ARCHS}. "
        exit 1
    fi

    if [ "${ARCH}" == "x86_64" ]; then
        echo "--gpus=all"
    elif [ "${ARCH}" == "aarch64" ]; then
        echo "--runtime nvidia"
    fi
}