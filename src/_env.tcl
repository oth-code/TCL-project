# ============================================================
# _env.tcl - Configuration des adresses VISA et paramètres
# ============================================================

# Adresse VISA du générateur de signaux
# Remplace par l’adresse trouvée dans Keysight Connection Expert
# Exemple : "USB0::0x2A8D::0x1301::MY12345678::INSTR"
set ::GEN_ADDR   "USB0::XXXX::YYYY::MYGEN12345678::INSTR"

# Adresse VISA de l’oscilloscope
# Remplace par l’adresse trouvée dans Keysight Connection Expert
# Exemple : "USB0::0x2A8D::0x1797::MY87654321::INSTR"
set ::SCOPE_ADDR "USB0::XXXX::ZZZZ::MYSCOPE87654321::INSTR"

# Timeout VISA (en millisecondes)
set ::VISA_TIMEOUT 5000

# Répertoire de sortie pour les résultats
set ::OUT_DIR "../data"
file mkdir $::OUT_DIR

# Répertoire pour les logs
set ::LOG_DIR "../logs"
file mkdir $::LOG_DIR