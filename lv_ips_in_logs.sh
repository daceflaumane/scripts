#!/bin/bash

# skripts, kas parbauda vai ip adrese ir LV

### Atkomentet aizkomentetas rindas pirmajam execution
# # Lejupladet LV IPV4 adresu sarakstu
# curl -o io_files/full_lv_ips.txt https://www.nic.lv/local.net

### Saskirot rezultatus no NIC un esosa IP adr.saraksta
# Unikalo IP input fails / I
unique_ips_inp_file="io_files/results.txt"

# Unikalo IP output fails / O
echo "" > io_files/sorted_ips_from_results.txt
unique_ips_outp_file="io_files/sorted_ips_from_results.txt"

# Izvakt lieko no unikalo IP saraksta
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" "$unique_ips_inp_file" | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 > "$unique_ips_outp_file"

# Filter the IPs from lv_ip_file.txt and save to acct_ips_reg.txt
lv_ip_file="io_files/full_lv_ips.txt"

# ACCT saraksts no NIC / O
acct_ips_file="io_files/acct_ip_reg.txt"

# Iztirit ACCT IP failu
echo "" > io_files/acct_ip_reg.txt
grep -v "^#" "$lv_ip_file" > "$acct_ips_file"

### Atrast, kuras IP adreses ir LV
# LV IP adreses / O
matched_ips_file="io_files/matched_ips.txt"

# Iztirit unikalo IP adresu failu
echo "" > io_files/matched_ips.txt

grepcidr io_files/sorted_ips_from_results.txt -f io_files/acct_ip_reg.txt >> io_files/matched_ips.txt

echo "Rezultats saglabats: $matched_ips_file"
echo "LV IP adreses no log failiem:"
cat $matched_ips_file

