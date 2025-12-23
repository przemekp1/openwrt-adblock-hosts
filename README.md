# 📡 openwrt-adblock-hosts – Hosts Lists for OpenWrt Adblock

![Full Combined Domains](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/.badges/full_combined.json?cacheSeconds=60)


Repozytorium zawiera **automatycznie aktualizowane listy domen w formacie `<DOMAIN>`**, zoptymalizowane pod **OpenWrt Adblock 24.10+**.

Listy są **agregowane, normalizowane, deduplikowane i walidowane** przez GitHub Actions.

---

## 🔗 Źródła list

| Źródło | Opis |
|--------|------|
| [CERT Polska](https://hole.cert.pl/) | domeny zgłoszone przez CERT Polska |
| [AdAway](https://adaway.org/hosts.txt) | serwery reklamowe |
| [yoyo.org](https://pgl.yoyo.org/adservers/) | dodatkowe reklamy/adservers |
| [Disconnect](https://disconnect.me) | trackery i malvertising |
| [URLhaus](https://urlhaus.abuse.ch/) | malware, phishing, C2 |
| [StevenBlack Hosts – Standard](https://github.com/StevenBlack/hosts) | standardowe blokady malware/adware |
| [StevenBlack Hosts – Porn](https://github.com/StevenBlack/hosts) | domeny pornograficzne |
| [StevenBlack Hosts – FakeNews](https://github.com/StevenBlack/hosts) | domeny dezinformacyjne |
| [OISD](https://oisd.nl/) | duże, globalne listy blokujące reklamy i malware |
| [EasyList](https://easylist.to/) | klasyczna lista reklamowa |
| [AdGuard DNS filter](https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt) | reklamy i trackery |

---

## 📦 Pliki wynikowe

| Plik | Zawartość | RAW URL |
|------|----------|--------|
| **full_combined.txt** | wszystkie powyższe źródła po deduplikacji | [Pobierz](https://raw.githubusercontent.com/przemekp1/openwrt-adblock-hosts/main/domains/full_combined.txt) |

Aktualna liczba domen jest widoczna **na badge** (liczona automatycznie).

---

## 🔄 Automatyzacja (GitHub Actions)

Workflow `update.yml`:

* ⏰ uruchamiany codziennie o **03:00 UTC** oraz ręcznie
* pobiera wszystkie źródła z fallbackiem – build nie pada
* normalizuje domeny do formatu `<DOMAIN>`
* deduplikuje wpisy
* tworzy plik `full_combined.txt`
* generuje badge `.badges/full_combined.json`

Jeśli któreś źródło jest chwilowo niedostępne:
* lista zostaje pusta
* badge pokaże `0`
* workflow **nie failuje**

---

## 📥 Jak używać w OpenWrt Adblock

1. Skopiuj RAW URL `full_combined.txt`
2. Dodaj go jako **feed typu `<DOMAIN>`** w konfiguracji Adblock
3. Zrestartuj usługę Adblock lub wymuś aktualizację list
4. Blokowanie działa od razu ✅

---

## ⚠️ Uwagi

* Listy są agregatem z wielu źródeł — mogą wystąpić fałszywe alarmy
* Projekt ma charakter **ochronny**, nie gwarantuje 100% bezpieczeństwa
* Problemy lub błędne domeny zgłaszaj w **Issues**

---

⭐ Jeśli repozytorium jest pomocne — zostaw **gwiazdkę**
