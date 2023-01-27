#!/bin/sh


# Izveido vai iztira results.txt failu (darbojas atrak neka glabat un saskirot atmina)
echo "" > results.txt

# Ludz lietotajam ievadit log failu direktoriju
read -p "Ievadiet log failu direktoriju: " folder_path

# Loop cauri visiem .log failiem direktorija
for file in $folder_path/*.log
do
    # Meklet IP adresi faila
    grep -oE "\b^([0-9]{1,3}\.){3}[0-9]{1,3}\s" $file | while read ip
    do
        # Parbauda vai IP adrese jau ir results faila (control case 42.156.138.3 29 vs 30)
        ip=$ip-
        if grep -q "^$ip" results.txt; then
            # Ja ir, skaitam pieskaita 1
            sed -i "s/^$ip.*/$ip $(($(grep "^$ip" results.txt | awk '{print $2}') + 1))/g" results.txt
        else
            # Ja nav, tad pievienot ar indeksu 1
            echo "$ip 1" >> results.txt
        fi
    done
done

# Iztira vai izveido sorted_results failu.
echo "" > sorted_results.txt
# Saskiro pec biezuma (.txt fails ir atrak neka darit to atmina)
sort -nr -k2 results.txt > sorted_results.txt


# Saskaita cik unikalo IP
unique_ips=$(awk '{print $1}' sorted_results.txt | sort -u | wc -l)
echo "Number of unique IPs: $unique_ips"

# Parada Top 10 rezultatus
echo "Top 10 results:"
head -10 sorted_results.txt

# Parbauda vai 10.rezultats ir vienads ar 11.
if [ $(head -10 sorted_results.txt | tail -1 | awk '{print $2}') -eq $(head -11 sorted_results.txt | tail -1 | awk '{print $2}') ]
then
    # Ja ta, tad saskaita cik daudz IP ir tas pats rezultats
    count=$(awk '$2=="'$(head -10 sorted_results.txt | tail -1 | awk '{print $2}')'"' sorted_results.txt | wc -l)
    echo "Tik daudzam citam IP ir tads pats paradisanas biezums ka 10.vietas IP: $count"
    # echo "IPs ar tadu pasu paradisanas biezumu, ka IP 10.vieta:"
    # awk '$2=="'$(head -10 sorted_results.txt | tail -1 | awk '{print $2}')'"' sorted_results.txt
fi


echo "Pilns rezultats pieejams: sorted_results.txt"
