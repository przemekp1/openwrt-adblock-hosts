# 📡 openwrt-adblock-hosts – Hosts Lists for OpenWrt Adblock

![Build](https://github.com/przemekp1/openwrt-adblock-hosts/actions/workflows/update.yml/badge.svg)
![Last Commit](https://img.shields.io/github/last-commit/przemekp1/openwrt-adblock-hosts/main)
![Domains](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/domains.json)
![Full Domains](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/full_domains.json)

Repozytorium zawiera **automatycznie aktualizowane listy domen w formacie `<DOMAIN>`**, zoptymalizowane pod **OpenWrt Adblock 24.10+**.

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

Tworzone są trzy profile list:

| Plik               | Zawartość / źródła                                         | Przybliżona liczba domen | RAW URL |
| ------------------ | ---------------------------------------------------------- | ----------------------- | -------- |
| **basic.txt**      | CERT.pl, AdAway, yoyo.org, Disconnect tracking            | ~100–120 tys.           | [Pobierz](https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/basic.txt) |
| **full.txt**       | basic.txt + StevenBlack, Disconnect malvertising, URLhaus | ~250–300 tys.           | [Pobierz](https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/full.txt) |
| **combined.txt**   | pełna lista wszystkich kategorii                          | ~330–350 tys.           | [Pobierz](https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/combined.txt) |

**Kategorie:**

| Kategoria   | Źródła                                        | Opis                              |
| ----------- | --------------------------------------------- | --------------------------------- |
| `ads`       | AdAway, yoyo.org                              | reklamy, serwery reklamowe        |
| `tracking`  | Disconnect tracking                            | trackery i profilowanie           |
| `malware`   | StevenBlack, Disconnect malvertising, URLhaus | malware, phishing, C2             |
| `certpl`    | CERT.pl                                        | złośliwe i niebezpieczne domeny  |

**Format:** jedna domena na linię, czysta, zgodna z OpenWrt Adblock.

---

## 🔄 Automatyzacja (GitHub Actions)

Workflow GitHub Actions:

* ⏰ działa codziennie o 03:00 UTC (cron) oraz ręcznie (`workflow_dispatch`)  
* pobiera listy źródłowe  
* normalizuje domeny w jednolity format  
* tworzy profile `basic.txt`, `full.txt`, `combined.txt`  
* deduplikuje domeny  
* sprawdza limit (~370k domen)  
* commit i push do repozytorium — gotowe do użycia w OpenWrt  
* generuje badge `.badges/domains.json` i `.badges/full_domains.json`

---

## 📥 Jak używać w OpenWrt Adblock

1. Skopiuj URL do wybranej listy:

| Profil | RAW URL |
| ------ | -------- |
| **Basic** | [https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/basic.txt](https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/basic.txt) |
| **Full** | [https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/full.txt](https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/full.txt) |
| **Combined** | [https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/combined.txt](https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/combined.txt) |

2. W OpenWrt w konfiguracji Adblock dodaj URL jako **feed** w formacie `<DOMAIN>`  
3. Zrestartuj usługę Adblock lub wymuś aktualizację listy  
4. Blokowanie działa od razu ✅

---

## ⚠️ Uwagi

* Listy są agregatem z różnych źródeł — mogą wystąpić fałszywe alarmy  
* Projekt ma charakter **informacyjny i ochronny** — nie gwarantuje 100% ochrony  
* Jeśli zauważysz problematyczne domeny lub błędy — zgłoś issue w repozytorium

---

⭐ Jeśli repozytorium jest dla Ciebie pomocne, zostaw **gwiazdkę** — to wspiera rozwój projektu!
