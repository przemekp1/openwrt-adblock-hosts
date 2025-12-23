# 📡 openwrt-adblock-hosts – Hosts Lists for OpenWrt Adblock
![Domains](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/domains.json)
![Full](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/full_domains.json)
![Basic](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/basic_domains.json)

![Ads](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/ads_domains.json)
![Tracking](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/tracking_domains.json)
![Malware](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/malware_domains.json)
![CERT.PL](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/certpl_domains.json)


Repozytorium zawiera **automatycznie aktualizowane listy domen w formacie `<DOMAIN>`**, zoptymalizowane pod **OpenWrt Adblock 24.10+**.

Listy są **agregowane, normalizowane, deduplikowane i walidowane** przez GitHub Actions.

---

## 🔗 Powiązane projekty / źródła

* 🌐 OpenWrt Adblock  
  https://openwrt.org/docs/guide-user/network/dns/adblock

* 🌐 CERT Polska – hole.cert.pl  
  https://hole.cert.pl/

* 🌐 URLhaus (malware & C2)  
  https://urlhaus.abuse.ch/

* 🌐 StevenBlack Hosts  
  https://github.com/StevenBlack/hosts

* 🌐 AdAway / yoyo.org / Disconnect.me

---

## 📦 Profile list domen

| Profil | Zawartość | RAW URL |
|------|----------|--------|
| **basic.txt** | CERT.PL, reklamy, tracking | https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/basic.txt |
| **full.txt** | basic + malware + malvertising | https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/full.txt |
| **combined.txt** | komplet wszystkich kategorii | https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/combined.txt |

Aktualna liczba domen jest widoczna **na badge** (liczona automatycznie).

---

## 🧩 Kategorie domen

| Kategoria | Plik | Opis |
|---------|------|------|
| **ads** | `ads.txt` | serwery reklamowe |
| **tracking** | `tracking.txt` | trackery i profilowanie |
| **malware** | `malware.txt` | malware, phishing, C2 |
| **certpl** | `certpl.txt` | domeny zgłoszone przez CERT Polska |

Każda kategoria posiada **osobny badge** pokazujący rzeczywistą liczbę domen.

---

## 🔄 Automatyzacja (GitHub Actions)

Workflow `update.yml`:

* ⏰ uruchamiany codziennie o **03:00 UTC** oraz ręcznie
* pobiera wiele źródeł (z fallbackiem – build nie pada)
* normalizuje domeny do formatu `<DOMAIN>`
* deduplikuje wpisy
* buduje profile `basic`, `full`, `combined`
* sprawdza limit (~370k domen)
* commit i push do repozytorium
* generuje badge `.badges/*.json`

Jeśli któreś źródło jest chwilowo niedostępne:
* lista zostaje pusta
* badge pokaże `0`
* workflow **nie failuje**

---

## 📥 Jak używać w OpenWrt Adblock

1. Skopiuj RAW URL wybranego profilu
2. Dodaj go jako **feed typu `<DOMAIN>`** w konfiguracji Adblock
3. Zrestartuj usługę Adblock lub wykonaj aktualizację list
4. Blokowanie działa od razu ✅

---

## ⚠️ Uwagi

* Listy są agregatem z wielu źródeł — mogą wystąpić fałszywe alarmy
* Projekt ma charakter **ochronny**, nie gwarantuje 100% bezpieczeństwa
* Problemy lub błędne domeny zgłaszaj w **Issues**

---

⭐ Jeśli repozytorium jest pomocne — zostaw **gwiazdkę**
