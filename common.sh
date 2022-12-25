
# Some common helper functions.
function print_list_str()
{
    local LIST=$1
    local DELIMITER=$2

    # Strip the input string.
    # https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
    STRIPPED=$(awk '{$1=$1;print}' <<< "${LIST}")

    # Convert the string to an arry.
    # https://stackoverflow.com/questions/66330363/split-comma-separated-string-by-ignoring-spaces-in-front-and-back-of-delimiter-a
    IFS=${DELIMITER} read -r -a array < <(sed 's/^ *//; s/ *$//; s/ *${DELIMITER} */${DELIMITER}/g' <<< "${STRIPPED}")
    for s in "${array[@]}"; do
        ss=$(awk '{$1=$1;print}' <<< "${s}")
        # Debug use.
        # echo ">>>${ss}<<<"
        echo "${ss}"
    done
}
