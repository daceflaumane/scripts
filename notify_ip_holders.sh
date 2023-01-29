#!/bin/bash


# Atrast liniju "######DYNAMIC PART######" un izdzest visu pec tas
sed '/######DYNAMIC PART######/,$d' io_files/full_lv_ips.txt > io_files/subnet_holders.txt

# Parrakstit failu no pedejas uz pirmo liniju subnet_holders.txt
tac io_files/subnet_holders.txt > io_files/subnet_holders_reversed.txt

# Izdzest tuksas rindas no matched_ips
sed -i '/^$/d' io_files/matched_ips.txt

echo "" > io_files/notify_list.txt
# Loop caur matched_ips.txt
while read ip; do
  # saglabat pirmo ip adreses dalu $partial_ip
  partial_ip="$(echo "$ip" | cut -d . -f 1-2)"

  # Atrast subnetus subnet_holders_reversed.txt, kas sakas ar $partial_ip
  subnets=$(grep "^#$partial_ip" io_files/subnet_holders_reversed.txt | sed 's/#//g')

  # Parbaudit vai $ip darr kadam no atrastajiem subnetiem
  for subnet in $subnets; do
    if echo "$ip" | grepcidr "$subnet" > /dev/null; then
      # Saglabat atbilstoso subnetu $found_subnet
      found_subnet="$subnet"
      break
    fi
  done

  # Atrast saglabata subneta rindu subnet_holders_reversed.txt
  line=$(grep -n "$found_subnet" io_files/subnet_holders_reversed.txt)
  line_num=${line%%:*}

  # Atrast nakamo rindu, kas sakas ar "##"
  line_contents=$(sed -n "$line_num,\$p" io_files/subnet_holders_reversed.txt | awk '/^##/ { print; exit }')

  # No atrasas rindas panemt nosaukumu un AS id
  holder_name=$(echo "$line_contents" | sed -E 's/##([^:]+).*/\1/')
  sub_id=$(echo "$line_contents" | grep -o "AS[0-9]\+\(,AS[0-9]\+\)*$" | awk -F, '{print $NF}')

  
  # Parbaudit vai nosaukums jau atrodas notify_list.txt
  if grep -q "$holder_name" io_files/notify_list.txt; then
    # Ja atrodas, tad zem nosaukuma rindas pievienot jaunu rindu un $ip
    sed -i "/$holder_name/a $ip" io_files/notify_list.txt
  else
    # Ja neatrotas, tad ar whois atrast Abuse contact un saglabat epastu
    holder_email=$(whois $sub_id | grep "Abuse contact" | grep -Eo '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b')

    # Pieveinot sarakstam tuksu rindu, un nosaukumu, epastu un jauna rinda - IP
    echo -e "\n$holder_name $holder_email" >> io_files/notify_list.txt
    echo "$ip" >> io_files/notify_list.txt
  fi
done < io_files/matched_ips.txt

echo "Rezultats saglabats: io_files/notify_list.txt"
echo "LV IP adreses sagrupetas pec ISP ar abuse e-pasta kontaktiem:"
cat io_files/notify_list.txt
