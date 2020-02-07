#!/bin/bash
exec tcpdump -i eth0 -w '/buffer/pcap-%Y-%m-%d-%H-%M.pcap' -G 600 udp port 4789
