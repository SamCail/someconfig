alias update_software='clear ; apt update && apt upgrade -y && apt autoremove -y && apt autoclean && apt autopurge -y ; apt purge $(dpkg -l | grep "^rc\s*linux" | awk '\''{print $2}'\'') ; su samuel bash -lc '\''uv self update && rustup update'\'' ; snap refresh && snap list --all | while read snapname ver rev trk pub notes; do if [[ $notes = *disabled* ]]; then snap remove "$snapname" --revision="$rev"; fi; done ; screenfetch'
function compress_pdf() {
for each in screen ebook prepress default ; do
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$each -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$(basename "$*" .pdf )_$each.pdf" "$*" ;
done
}


function clean_up() {
# set -eu
LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        sudo snap remove "$snapname" --revision="$revision"
    done
sudo rm -rf /var/lib/snapd/cache/*
sudo journalctl --disk-usage
sudo journalctl --vacuum-time=7d
sudo journalctl --vacuum-size=128M
sudo journalctl --disk-usage
}

alias update_software='sudo apt update && sudo apt upgrade -y && sudo apt autoclean -y && sudo apt autopurge -y && sudo apt autoremove -y && sudo snap refresh;uv self update;rustup update; bash -lc "cd ~/Apps/yt-dlp && . ./venv/bin/activate && pip install --upgrade pip yt-dlp "; screenfetch'

clear;sync && echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a
