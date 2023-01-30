#!/bin/sh


# Parbauda vai ir io_files direktorija, ja nav, tad izveido
if [ ! -d "io_files" ]; then
  mkdir io_files
fi

# Izveido vai iztira results.txt failu (darbojas atrak neka glabat un saskirot atmina)
echo "" > io_files/results.txt

# Ludz lietotajam ievadit log failu direktoriju
read -p "Ievadiet log failu direktoriju: " folder_path


# Apkopo IP adreses rindu sakuma
cat log_files/*.log | grep -o "^[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+" > io_files/results.txt

# Apkopo IO adreses citviet log failos
cat log_files/*.log | grep -o "//[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+" | grep -o "[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+"  >> io_files/results.txt

# Izvac dublikatus un saskaita cik reizes IP paradijas failos
cat io_files/results.txt | sort | uniq -c | sort -n > io_files/sorted_results.txt

# Rezultati otrada kartiba
tac io_files/sorted_results.txt > io_files/results.txt

# Sakarto parskatami
cat io_files/results.txt | awk '{print $2 "- " $1}' > io_files/sorted_results.txt


# Saskaita cik unikalo IP
unique_ips=$(awk '{print $1}' io_files/sorted_results.txt | sort -u | wc -l)
echo "Unikalas adreses log failos: $unique_ips"

# Parada Top 10 rezultatus
echo "Top 10 rezultati:"
head -10 io_files/sorted_results.txt

# Parbauda vai 10.rezultats ir vienads ar 11.
if [ $(head -10 io_files/sorted_results.txt | tail -1 | awk '{print $2}') -eq $(head -11 io_files/sorted_results.txt | tail -1 | awk '{print $2}') ]
then
    # Ja ta, tad saskaita cik daudz IP ir tas pats rezultats
    count=$(awk '$2=="'$(head -10 io_files/sorted_results.txt | tail -1 | awk '{print $2}')'"' io_files/sorted_results.txt | wc -l)
    echo "Tik daudzam citam IP ir tads pats paradisanas biezums ka 10.vietas IP: $count"
    # echo "IPs ar tadu pasu paradisanas biezumu, ka IP 10.vieta:"
    # awk '$2=="'$(head -10 io_files/sorted_results.txt | tail -1 | awk '{print $2}')'"' io_files/sorted_results.txt
fi


echo "Pilns rezultats pieejams: io_files/sorted_results.txt"
echo ""
echo ""
