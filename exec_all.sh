#!/bin/bash

# Cik unikālu IP adrešu ir web access žurnālfailos kopā?
# Norādīt top 10 ar visbiežāk pieminētajām IP adresēm. Cik reizes katra no top 10 IP 
# adresēm tika pieminēta žurnālfailā?
echo "Uzsak ips_in_log.sh"
./ips_in_log.sh

# Identificēt, cik LV IP adrešu ir web access žurnālfailos?
echo "Uzsak lv_ips_in_logs.sh"
./lv_ips_in_logs.sh

# Izveidot skriptu, kas iepriekš identificētās LV IP adreses sagrupētu pēc to ISP un parādītu, 
# uz kādu no publiski zināmiem e-pasta kontaktiem teorētiski varētu sūtīt paziņojumu!
echo "Uzsak notify_ip_holders.sh"
./notify_ip_holders.sh

# End of the script
echo ""
echo "Skriptu izpilde pabeigta"
echo "Lai izdzestu visus failus, izmantot komandu:"
echo "./rm_io_files.sh"
