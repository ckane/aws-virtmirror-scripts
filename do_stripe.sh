#!/bin/bash
cur_pcap=`date --date='10 minutes ago' '+/buffer/pcap-%Y-%m-%d-%H-%M.pcap'`
mkdir -p -m 775 /buffer/striped /buffer/stripe_staging /buffer/tmp
find /buffer/ -maxdepth 1 -type f | (while read pcap_file; do
  if [[ "${cur_pcap}" > "${pcap_file}" ]]; then
    #echo "Older: ${pcap_file}"
    base_name=$(basename "${pcap_file}")
    /home/ec2-user/aws-virtmirror-scripts/stripe/stripe -r "${pcap_file}" -w /buffer/stripe_staging/"${base_name}" && \
	    rm -f "${pcap_file}" && \
	    mv /buffer/stripe_staging/"${base_name}" /buffer/striped/
  #else
    #echo "Newer: ${pcap_file}"
  fi
done)
