# ============================================================
# measure_scope.tcl - Mesure filtre RC avec oscilloscope
# ============================================================

package require Tcl 8.6
catch {package require visa}

source [file join [file dirname [info script]] "_env.tcl"]

# --- Fonctions utilitaires ---
proc scpi_write {s c} { visa::write $s "$c\n" }
proc scpi_query {s q} { scpi_write $s $q; return [string trim [visa::read $s]] }

proc log {msg} {
    set ts [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"]
    puts "[$ts] $msg"
}

proc openInstr {addr} {
    set s [visa::open $addr]
    visa::settimeout $s $::VISA_TIMEOUT
    return $s
}

# --- Ouverture des instruments ---
set gen   [openInstr $::GEN_ADDR]
set scope [openInstr $::SCOPE_ADDR]

log "GEN IDN:   [scpi_query $gen *IDN?]"
log "SCOPE IDN: [scpi_query $scope *IDN?]"

# --- Config générateur ---
scpi_write $gen "*RST"
scpi_write $gen "FUNC SIN"
scpi_write $gen "VOLT 1"
scpi_write $gen "OUTP ON"

# --- Config oscilloscope ---
scpi_write $scope "*RST"
scpi_write $scope "CHAN1:DISP ON"
scpi_write $scope "CHAN2:DISP ON"

# --- Fréquences à tester ---
set freqs {100 500 1000 2000 5000 10000 20000}

# --- Fichier CSV ---
set csv [open [file join $::OUT_DIR "results.csv"] w]
puts $csv "freq_Hz,Vin_Vpp,Vout_Vpp,gain_dB"

# --- Sweep ---
foreach fHz $freqs {
    log "Testing frequency $fHz Hz"
    scpi_write $gen "FREQ $fHz"
    after 200

    set vin [scpi_query $scope "MEAS:VPP? CHAN1"]
    set vout [scpi_query $scope "MEAS:VPP? CHAN2"]

    if {$vin == 0} {
        set gain "NaN"
    } else {
        set gain [expr {20*log10($vout/$vin)}]
    }

    puts $csv "$fHz,$vin,$vout,$gain"
    log "Freq=$fHz Hz, Vin=$vin V, Vout=$vout V, Gain=$gain dB"
}

close $csv
visa::close $gen
visa::close $scope

log "Mesure terminée. Résultats dans data/results.csv"
