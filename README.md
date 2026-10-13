# 🍏 Mac Dev Auto-Setup

Egyetlen futtatással konfigurálható, konténer- és terminálközpontú macOS fejlesztői környezet.

---

## ⚡ Gyorsindítás egy friss Macen

Nyiss egy **Terminált**, majd futtasd a következő parancsot:

```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/](https://raw.githubusercontent.com/)<felhasznalonev>/<repo-nev>/main/setup.sh)"
```

*Alternatív futtatás helyi fájlból:*

```bash
chmod +x setup.sh
./setup.sh
```

---

## 📦 Mit csinál a script automatikusan?

1. **Struktúra:** Létrehozza a felhőszinkronból kieső `~/Developer` gyökérmappát.
2. **Alaprendszer:** Telepíti az **Xcode Command Line Tools**-t és a **Homebrew**-t (Apple Silicon PATH beállítással).
3. **Appok (Cask):**
    * `OrbStack` (könnyű, akkukímélő Docker alternatíva)
    * `VS Code`
    * `Google Chrome`

4. **CLI eszközök:** `git`, `gh` (GitHub CLI), `mise`, `jq`, `ripgrep`, `fzf`, `btop`.
5. **Shell integráció:** Beköti a `mise` és `fzf` eszközöket a `~/.zshrc`-be.
6. **Runtime & AI:** Felhúzza a **Node.js LTS** verziót és a hivatalos **Claude Code CLI**-t (`npm -g`).
7. **Git konfiguráció:** Bekéri és beállítja a globális nevet, emailt és az alapértelmezett `main` branchet.

---

## 🏁 Teendők a lefutás után

1. **GitHub fiók és SSH összekötése:**
```bash
gh auth login
```

*(Válaszd az **SSH** opciót és engedélyezd a kulcs generálását böngészőn keresztül.)*

2. **OrbStack első indítása:**
Nyisd meg az alkalmazást Spotlightból (`Cmd + Szóköz` → *OrbStack*), és add meg a kért rendszerengedélyt a konténerekhez.

3. **Terminál frissítése:**
```bash
source ~/.zshrc
```