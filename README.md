# scripts

lv_ips_in_logs.sh un notify_ip_holders.sh ir nepieciesama grepcidr komanda
http://www.pc-tools.net/unix/grepcidr/

*Instalet grepcidr*:
```
sudo apt-get install grepcidr
sudo apt update && sudo apt upgrade grepcidr
```

## Izpildit visus skriptus
Lai izpilditu visus skriptus:
```
./exec_all.sh
```

## Izveidoto rezultatu direktorija
Skriptu palaisanas laika tiek uzgenereta direktorija io_files
Lai to izdzestu:
```
./rm_io_files.sh
```


## Ieteicama izpildes seciba izpildot atseviski
Skripti izmanto failus, kas tiek genereti citos skriptos, ieteicams izpildit sada seciba:
```
./ips_in_log.sh
./lv_ips_in_logs.sh
./notify_holders.sh
```

## Faili

### ips_in_log.sh
ips_in_log.sh ir nepieciesams noradit log failu direktoriju relativi pret .sh faila atrasanas vietu, to bus iespejams noradit pec skripta palaisanas. 
Piem.: log_files

### lv_ips_in_logs.sh
lv_ips_in_logs.sh ir nepieciesams:

* *io_files/results.txt* fails, kas tiek uzgenerets ips_in_log.sh izpildes laika, bet iespejams ari pievienot failu, kas satur ip adreses sada formata

```
34.217.34.27- 1
190.42.145.178- 1
```

### notify_ip_holders.sh
notify_ip_holders.sh ir nepieciesami:

* *io_files/full_lv_ips.txt* fails, kas tiek uzgenerets lv_ips_in_logs.sh izpildes laika, bet iespejams ari pievienot failu, to lejupieladejot no https://www.nic.lv/lix


* *io_files/matched_ips.txt* fails, kas tiek uzgenerets lv_ips_in_logs.sh izpildes laika, bet iespejams ari pievienot failu ar LV IP adresem sada formata:

```
91.190.36.8
91.228.7.63
```

## screenme.py
screenme.py izmantosanai ir nepieciesami:

*python3
```
sudo apt-get update
sudo apt-get install python3.9
```

*pip
```
python -m ensurepip --upgrade
```

*selenium
```
pip3 install selenium
```

*geckodriver
```
pips install webdrivermanager
webdrivermanager firefox chrome --linkpath /usr/local/bin
```

*pyautogui
```
python3 -m pip install pyautogui
sudo apt-get install scrot
sudo apt-get install python3-tk
sudo apt-get install python3-dev
```

## Izpildit screenme.py
Ka pirmais komandrinadas arguments janorada URL, no kura uznemt ekransavinu
```
python3 screenme.py https://example.com
```
