# 📡 openwrt-adblock-hosts – Hosts Lists for OpenWrt Adblock

![Build](https://github.com/przemekp1/openwrt-adblock-hosts/actions/workflows/update.yml/badge.svg)
![Last Commit](https://img.shields.io/github/last-commit/przemekp1/openwrt-adblock-hosts/main)
![Domains](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/domains.json)

Repozytorium zawiera **automatycznie aktualizowane listy domen w czystym formacie `<DOMAIN>`**, zoptymalizowane pod **OpenWrt Adblock 24.10+**.

Listy powstają na podstawie renomowanych źródeł, łączonych i normalizowanych w **GitHub Actions**, tak aby spełniały limit ~350 tys. domen.

---

## 🔗 Powiązane projekty

* 🌐 **OpenWrt Adblock**  
  [https://openwrt.org/docs/guide-user/network/dns/adblock](https://openwrt.org/docs/guide-user/network/dns/adblock)

* 🌐 **URLhaus (malware domains)**  
  [https://urlhaus.abuse.ch/](https://urlhaus.abuse.ch/)

* 🌐 **CERT Polska - hole.cert.pl**  
  [https://hole.cert.pl/](https://hole.cert.pl/)

---

## 📦 Zawartość list domen

Lista `combined.txt` powstaje z poniższych źródeł, po deduplikacji i normalizacji:

| Źródło                    | Opis                                | Przybliżona liczba domen  |
| ------------------------- | ---------------------------------- | ------------------------ |
| **CERT.pl (hole.cert.pl)** | domeny zagrożeń, phishing, malware | ~30-40 tys.              |
| **URLhaus**                | domeny malware i C2                 | ~10-15 tys.              |
| **AdAway**                 | reklamy i trackery                  | ~50-60 tys.              |
| **StevenBlack hosts**      | reklamy, malware, trackery          | ~150-170 tys.            |
| **yoyo.org (adservers)**   | serwery reklamowe                   | ~20-25 tys.              |
| **Disconnect.me**          | tracking i malvertising             | ~15-20 tys.              |

➡️ **Po deduplikacji lista ma około ~330–350 tys. unikalnych domen**  
➡️ **Format listy:** czysta domena, jedna domena na linię, zgodna z formatem OpenWrt Adblock `<DOMAIN>`

---

## 🔄 Automatyzacja (GitHub Actions)

Workflow GitHub Actions:

* ⏰ działa codziennie o 03:00 UTC (cron) oraz ręcznie (`workflow_dispatch`)  
* pobiera listy źródłowe  
* normalizuje domeny w jednolity format  
* łączy i deduplikuje listy  
* sprawdza, czy lista nie przekracza limitu (~370k domen)  
* commit i push do repozytorium — gotowe do użycia w OpenWrt

---

## 📥 Jak używać w OpenWrt Adblock

1. Skopiuj URL do wybranej listy, np.:
https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/combined.txt

2. W OpenWrt w konfiguracji Adblock dodaj ten URL jako **feed** w formacie `<DOMAIN>`

3. Zrestartuj usługę Adblock lub wymuś aktualizację listy

4. Blokowanie domen działa od razu

---

## ⚠️ Uwagi

* Listy są agregatem z różnych źródeł — może zdarzyć się fałszywy alarm  
* Projekt ma charakter **użyteczny i informacyjny** — nie gwarantuje 100% ochrony  
* Jeśli zauważysz problematyczne domeny lub błędy — zgłoś issue w repozytorium

---

⭐ Jeśli repozytorium jest dla Ciebie pomocne, zostaw **gwiazdkę** — to wspiera rozwój projektu!

---


