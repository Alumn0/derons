NAMES=( "${PARAM1NAME}" "${PARAM2NAME}" "${PARAM3NAME}" "${PARAM4NAME}" )
TYPES=( "${PARAM1TYPE}" "${PARAM2TYPE}" "${PARAM3TYPE}" "${PARAM4TYPE}" )
VALUES=( "${PARAM1}" "${PARAM2}" "${PARAM3}" "${PARAM4}" )

COMMAND=(
	'curl'
	'-s'
	'-X POST "http://'"${WALLET}"'/json_rpc"'
	'-H "content-type: application/json"'
	$'-d \'{"jsonrpc":"2.0","id":"0","method":"scinvoke","params":{"scid":"'"${SCID}"'","ringsize":'"${RINGSIZE}"',"sc_dero_deposit":'"${DEROVALUE}"',"sc_rpc": [{"name":"entrypoint","datatype":"S","value":"'"${ENTRYPOINT}"'"}'
)
for (( i=0; i<${#NAMES[@]}; i++ )); do
    if [[ -n ${NAMES[$i]} ]]; then
        COMMAND+=(',{"name":"'"${NAMES[$i]}"'","datatype":"'"${TYPES[$i]}"'","value":'"${VALUES[$i]}"'}')
    fi
done

COMMAND+=( $']}}\'' )
