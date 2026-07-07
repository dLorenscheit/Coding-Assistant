---
name: CreateUserDocumentation
description: >
  **WORKFLOW SKILL** — Analysiert ein Programm oder eine Anwendung aus Benutzerperspektive und erstellt eine verständliche Benutzerdokumentation als HTML.
  Kein technisches Vorwissen beim Leser vorausgesetzt – Fokus auf Bedienung, Masken, Funktionstasten und Prozesse.
  USE FOR: Benutzerdokumentation erstellen, Bedienungsanleitungen, End-User-Handbücher, Schulungsunterlagen.
---

# CreateUserDocumentation – Skill

## Ziel
Analysiert ein übergebenes Programm oder Quellcode-Dokument aus der **Perspektive des Endbenutzers** und erstellt eine verständliche, benutzerfreundliche HTML-Dokumentation. Technische Details werden nur soweit aufgenommen, wie sie für die Bedienung relevant sind. Bei Unklarheiten werden Rückfragen gestellt.

**Ausgabe:** Ausschließlich HTML – gestylt im hellen Blue-Accent-Design.

---

## Ausschlussregeln (PFLICHT – niemals verletzen)

> Diese Regeln gelten absolut. Verstöße werden in der Qualitätsprüfung aufgedeckt und müssen vor Ausgabe korrigiert werden.

| Kategorie | Verboten in der Benutzerdoku | Erlaubte Alternative |
|-----------|------------------------------|----------------------|
| **Datenbanknamen** | Tabellennamen (`KDSTAT01P`), View-Namen, Schema-Namen, Bibliotheksnamen | Fachliche Bezeichnung: *„Kundenstatus"*, *„Artikelliste"* |
| **Technische Feldnamen** | Interne Feldnamen aus Code (`RECID`, `BT_DELETE_TT`) | Beschriftung wie auf der Maske / fachlicher Begriff |
| **Security-Konzepte** | Berechtigungsprofile, Rollen-Namen, Objektrechte, Authority-Prüfungen | Wenn nötig: *„Für diese Funktion wird eine besondere Berechtigung benötigt – wenden Sie sich an Ihren Administrator."* |
| **SQL / Datenbanklogik** | SQL-Statements, JOIN-Logik, Cursor, SQLSTATE | Nicht erwähnen |
| **Systemtechnische Details** | Interne Programm-Namen, Service-Programme, Copy-Members | Nicht erwähnen |
| **Technische Fehlercodes** | SQLSTATE-Codes, CPF-Messages, interne Error-Codes | Nur sichtbaren Meldungstext + Lösungshinweis |

---

## Workflow

### Schritt 1 – Programm einlesen & Benutzerfunktionen identifizieren

1. Das im Aufruf referenzierte Dokument vollständig einlesen
2. Aus Benutzersicht relevante Elemente identifizieren:
   - Masken / Bildschirme (DSPF-Record-Formate, UI-Komponenten)
   - Eingabefelder und deren Bedeutung für den Benutzer
   - Funktionstasten (F3, F5, F6, F12, etc.) und deren Wirkung
   - Aktionen: Anlegen, Bearbeiten, Löschen, Suchen, Anzeigen
   - Status-Anzeigen, Fehlermeldungen, Hinweistexte
   - Pflichtfelder und Validierungsregeln (aus Benutzersicht)
3. Programm-Typ und Hauptzweck notieren

**Erkennungsmerkmale für Benutzer-relevante Elemente:**
| Element | Erkennungsmerkmale | Benutzerbedeutung |
|---------|-------------------|-------------------|
| Eingabemaske | DSPF `INPUT`-Felder, HTML-Forms, UI-Komponenten | Felder, die der Benutzer ausfüllen kann |
| Anzeigemaske | DSPF `OUTPUT`-Felder, Read-only-Bereiche | Informationen, die angezeigt werden |
| Subfile / Liste | DSPF `SFL`-Records, Tabellen, Grids | Übersichten, aus denen der Benutzer wählt |
| Funktionstasten | `CA`/`CF`-Keys, Button-Definitionen | Schnellaktionen über Tastatur |
| Fehlermeldungen | `ERRMSG`, `ERRMSGID`, Error-Codes | Was tun bei Fehlern? |
| Pflichtfelder | Validierungslogik, `CHECK(ME)`, NOT NULL | Was muss eingegeben werden? |

---

### Schritt 2 – Benutzerorientierte Analyse

Das Programm aus Endbenutzer-Perspektive analysieren:

#### 2.1 Programmzweck (Was macht dieses Programm?)
- Welches fachliche Problem löst das Programm?
- Für welche Benutzergruppe ist es gedacht?
- Was ist das Ergebnis / der Nutzen für den Benutzer?

#### 2.2 Einstieg & Voraussetzungen
- Wie wird das Programm aufgerufen / gestartet?
- Welche **fachlichen** Voraussetzungen muss der Benutzer erfüllen (z.B. welche Daten müssen vorhanden sein)?
- Gibt es Eingabe-Parameter beim Start?
- **KEINE Berechtigungsprofile oder Security-Konzepte** – wenn Zugriffsbeschränkungen relevant sind, nur formulieren als: *„Für diese Funktion wird eine besondere Berechtigung benötigt. Wenden Sie sich an Ihren Administrator."*

#### 2.3 Masken / Bildschirmaufbau
Für jede Maske / jeden Screen erfassen:
- **Name / Bezeichnung** der Maske – als **fachlichen Namen** (nicht das interne Record-Format)
- **Zweck:** Was kann der Benutzer hier tun?
- **Felder:** Alle sichtbaren Felder mit **benutzerfreundlicher Bezeichnung** (Beschriftung wie auf der Maske, nicht der interne Feldname aus dem Code)
- **Pflichtfelder:** Welche Felder müssen zwingend gefüllt werden?
- **Besonderheiten:** Formatvorgaben, Auswahlmöglichkeiten, Abhängigkeiten
- **KEINE internen Feldnamen, Tabellennamen oder technischen Bezeichnungen**

**Dokumentationsformat pro Maske:**
```
Maske: [Maskenname / Record-Format]
├── Zweck:         [Was macht der Benutzer hier?]
├── Felder:        [Feldname (Bezeichnung) – Pflicht? – Beschreibung]
├── Aktionen:      [Welche Aktionen sind möglich?]
└── Nächster Schritt: [Wohin geht es nach Bestätigung?]
```

#### 2.4 Funktionstasten & Schaltflächen
- Vollständige Liste aller Funktionstasten mit Wirkung
- Kontextabhängige Verfügbarkeit (z.B. nur aktiv wenn Datensatz selektiert)

**Format:**
| Taste | Bezeichnung | Wirkung | Verfügbar |
|-------|-------------|---------|-----------|
| F3 | Beenden | Programm verlassen ohne Speichern | Immer |
| F5 | Aktualisieren | Anzeige neu laden | Immer |
| ... | ... | ... | ... |

#### 2.5 Bedienabläufe (Schritt-für-Schritt)
Für jede Hauptaktion einen nummerierten Ablauf dokumentieren:

**Typische Aktionen:**
- Neuen Datensatz anlegen
- Bestehenden Datensatz suchen und anzeigen
- Datensatz bearbeiten und speichern
- Datensatz deaktivieren / löschen
- Liste filtern und navigieren

**Format pro Ablauf:**
```
Aktion: [Bezeichnung]
1. [Schritt 1 – was der Benutzer tut]
2. [Schritt 2 – was passiert]
3. [Schritt 3 – Eingabe / Bestätigung]
4. [Ergebnis / Abschluss]
```

#### 2.6 Fehlermeldungen & Hinweise
- Alle erkennbaren Fehlermeldungen mit:
  - Fehlermeldungstext **wie der Benutzer ihn sieht** (kein interner Code in der Ausgabe)
  - Ursache in alltagsverständlicher Sprache
  - Empfohlene Lösung / nächste Schritte
- **KEINE technischen Codes** (CPF-IDs, SQLSTATE, interne Error-Codes) in der Ausgabe nennen

#### 2.7 Tipps & Hinweise
- Arbeitshinweise für effiziente Bedienung
- Häufige Fehler und wie man sie vermeidet
- Besonderheiten, die Benutzer kennen sollten

---

### Schritt 3 – Rückfragen bei Unklarheiten

> **PFLICHT:** Wenn Benutzersicht unklar ist, SOFORT Rückfragen stellen.

Typische Rückfrage-Situationen:
- Feldbezeichnungen sind technisch / abgekürzt – fachliche Bedeutung unklar
- Fehlermeldungstext nicht im Code erkennbar (nur Message-ID)
- Ablauf hat Verzweigungen, deren Bedingungen nicht klar sind
- Pflichtfelder nicht eindeutig aus Code ersichtlich
- Benutzergruppe / Zielgruppe der Doku unklar

**Format der Rückfrage:**
```
⚠️ Dobby hat eine Frage zur Benutzerdoku:
[Konkrete Frage – welches Feld / welche Maske / welcher Ablauf ist unklar?]
```

---

### Schritt 4 – HTML-Dokumentation erstellen

**Eine HTML-Datei** erstellen: `[Programmname]_Benutzerdokumentation.html`

#### Pflicht-Abschnitte der HTML-Dokumentation:

```
1. Übersicht          – Programmname, Zweck, Zielgruppe, Version
2. Voraussetzungen    – Was wird benötigt? Welche Berechtigungen?
3. Programmstart      – Wie wird das Programm aufgerufen?
4. Maskenübersicht    – Alle Masken mit Feldbeschreibung
5. Bedienabläufe      – Schritt-für-Schritt für alle Hauptaktionen
6. Funktionstasten    – Vollständige Übersichtstabelle
7. Fehlermeldungen    – Was bedeuten sie? Was tun?
8. Tipps & Hinweise   – Praxistipps für die Bedienung
```

#### Navigationsanker

Jeder Abschnitt erhält einen `id`-Anker für die interne Navigation:
```html
<h2 id="voraussetzungen">Voraussetzungen</h2>
```

Ein festes Inhaltsverzeichnis am Seitenanfang verlinkt alle Abschnitte.

---

### Schritt 5 – Qualitätsprüfung

**Inhalt & Verständlichkeit:**
- [ ] Kein technischer Jargon – alle Begriffe für Endbenutzer verständlich?
- [ ] Alle Masken / Bildschirme dokumentiert?
- [ ] Alle Felder mit benutzerfreundlicher Bezeichnung erklärt?
- [ ] Pflichtfelder klar markiert?
- [ ] Alle Funktionstasten in der Übersichtstabelle?
- [ ] Alle Hauptabläufe als Schritt-für-Schritt erklärt?
- [ ] Fehlermeldungen mit Lösungshinweis?
- [ ] Inhaltsverzeichnis mit funktionierenden Anker-Links?
- [ ] Datei im `Output/`-Ordner abgelegt?

**Ausschluss-Check (PFLICHT – jeder Punkt muss ✅ sein):**
- [ ] Keine Datenbanknamen / Tabellennamen / View-Namen in der Ausgabe?
- [ ] Keine internen Feldnamen aus dem Quellcode sichtbar?
- [ ] Keine Berechtigungsprofile, Rollen oder Security-Konzepte genannt?
- [ ] Keine SQL-Statements oder Datenbanklogik erwähnt?
- [ ] Keine internen Fehlercodes (CPF, SQLSTATE) in Fehlermeldungen sichtbar?
- [ ] Keine Programm-/Service-Programm-Namen interner Aufrufe genannt?
- [ ] HTML valide und im Blue-Accent-Design?

---

## Ausgabe-Format

**Ablageort:** `[Projektordner]/Output/`

**Datei:** `[Programmname]_Benutzerdokumentation.html`

---

## Integriertes CSS-Template (Blue-Accent-Design)

```html
<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[Programmname] – Benutzerdokumentation</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
  <style>
    :root {
      --color-white:    #ffffff;
      --color-snow:     #f8fafc;
      --color-mist:     #f1f5f9;
      --color-border:   #e2e8f0;
      --color-ink:      #0f172a;
      --color-slate:    #334155;
      --color-muted:    #64748b;
      --color-ocean:    #1d4ed8;
      --color-wave:     #2563eb;
      --color-sky:      #3b82f6;
      --color-foam:     #dbeafe;
      --color-horizon:  #eff6ff;
      --color-success:  #16a34a;
      --color-warning:  #d97706;
      --color-danger:   #dc2626;
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      background: var(--color-snow);
      color: var(--color-ink);
      font-family: 'Inter', system-ui, -apple-system, sans-serif;
      font-size: 16px;
      line-height: 1.6;
      letter-spacing: -0.2px;
      padding: 0;
    }

    /* ── Layout ────────────────────────────────────── */
    .page-wrapper {
      display: flex;
      min-height: 100vh;
    }

    /* ── Sidebar Navigation ────────────────────────── */
    .sidebar {
      width: 260px;
      min-width: 260px;
      background: var(--color-white);
      border-right: 1px solid var(--color-border);
      padding: 32px 0;
      position: sticky;
      top: 0;
      height: 100vh;
      overflow-y: auto;
    }

    .sidebar-logo {
      padding: 0 24px 24px;
      border-bottom: 1px solid var(--color-border);
      margin-bottom: 16px;
    }

    .sidebar-logo span {
      font-size: 13px;
      font-weight: 600;
      color: var(--color-ocean);
      text-transform: uppercase;
      letter-spacing: 0.08em;
    }

    .sidebar-logo h1 {
      font-size: 16px;
      font-weight: 700;
      color: var(--color-ink);
      margin-top: 4px;
      letter-spacing: -0.3px;
      border: none;
      padding: 0;
    }

    .nav-section {
      padding: 8px 0;
    }

    .nav-section-title {
      font-size: 11px;
      font-weight: 600;
      color: var(--color-muted);
      text-transform: uppercase;
      letter-spacing: 0.1em;
      padding: 8px 24px 4px;
    }

    .nav-link {
      display: block;
      padding: 7px 24px;
      font-size: 14px;
      color: var(--color-slate);
      text-decoration: none;
      border-left: 3px solid transparent;
      transition: all 0.15s ease;
    }

    .nav-link:hover {
      background: var(--color-horizon);
      color: var(--color-ocean);
      border-left-color: var(--color-sky);
    }

    .nav-link.active {
      background: var(--color-foam);
      color: var(--color-ocean);
      border-left-color: var(--color-ocean);
      font-weight: 500;
    }

    /* ── Main Content ──────────────────────────────── */
    .main-content {
      flex: 1;
      padding: 48px 64px;
      max-width: 900px;
    }

    /* ── Page Header ───────────────────────────────── */
    .page-header {
      margin-bottom: 48px;
      padding-bottom: 32px;
      border-bottom: 2px solid var(--color-border);
    }

    .page-header .badge {
      display: inline-block;
      background: var(--color-foam);
      color: var(--color-ocean);
      font-size: 12px;
      font-weight: 600;
      padding: 4px 12px;
      border-radius: 9999px;
      margin-bottom: 12px;
      letter-spacing: 0.03em;
    }

    .page-header h1 {
      font-size: 36px;
      font-weight: 700;
      color: var(--color-ink);
      letter-spacing: -0.5px;
      line-height: 1.2;
      margin-bottom: 12px;
    }

    .page-header p {
      font-size: 18px;
      color: var(--color-slate);
      line-height: 1.5;
      margin-bottom: 0;
    }

    /* ── Sections ──────────────────────────────────── */
    .section {
      margin-bottom: 64px;
      scroll-margin-top: 24px;
    }

    h2 {
      font-size: 22px;
      font-weight: 700;
      color: var(--color-ink);
      letter-spacing: -0.3px;
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 2px solid var(--color-foam);
      display: flex;
      align-items: center;
      gap: 10px;
    }

    h2::before {
      content: '';
      display: inline-block;
      width: 4px;
      height: 22px;
      background: var(--color-ocean);
      border-radius: 2px;
      flex-shrink: 0;
    }

    h3 {
      font-size: 17px;
      font-weight: 600;
      color: var(--color-ocean);
      margin-top: 28px;
      margin-bottom: 12px;
      letter-spacing: -0.2px;
    }

    p {
      margin-bottom: 16px;
      color: var(--color-slate);
    }

    /* ── Meta Box ──────────────────────────────────── */
    .meta-box {
      background: var(--color-white);
      border: 1px solid var(--color-border);
      border-radius: 12px;
      padding: 24px;
      margin-bottom: 32px;
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
      gap: 16px;
    }

    .meta-item dt {
      font-size: 11px;
      font-weight: 600;
      color: var(--color-muted);
      text-transform: uppercase;
      letter-spacing: 0.08em;
      margin-bottom: 4px;
    }

    .meta-item dd {
      font-size: 15px;
      font-weight: 500;
      color: var(--color-ink);
    }

    /* ── Tables ────────────────────────────────────── */
    table {
      width: 100%;
      border-collapse: collapse;
      margin: 16px 0 24px;
      background: var(--color-white);
      border: 1px solid var(--color-border);
      border-radius: 10px;
      overflow: hidden;
    }

    th {
      background: var(--color-ocean);
      color: var(--color-white);
      font-weight: 600;
      text-align: left;
      padding: 12px 16px;
      font-size: 13px;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    td {
      padding: 11px 16px;
      border-bottom: 1px solid var(--color-border);
      font-size: 14px;
      color: var(--color-slate);
      vertical-align: top;
    }

    tr:last-child td { border-bottom: none; }
    tr:hover td { background: var(--color-horizon); }

    /* ── Step List ─────────────────────────────────── */
    .step-list {
      counter-reset: steps;
      list-style: none;
      padding: 0;
      margin: 16px 0 24px;
    }

    .step-list li {
      counter-increment: steps;
      display: flex;
      gap: 16px;
      margin-bottom: 16px;
      align-items: flex-start;
    }

    .step-list li::before {
      content: counter(steps);
      display: flex;
      align-items: center;
      justify-content: center;
      min-width: 28px;
      height: 28px;
      background: var(--color-ocean);
      color: var(--color-white);
      border-radius: 50%;
      font-size: 13px;
      font-weight: 700;
      flex-shrink: 0;
      margin-top: 1px;
    }

    .step-list li p {
      margin: 0;
      padding-top: 4px;
    }

    /* ── Callouts ──────────────────────────────────── */
    .callout {
      border-radius: 10px;
      padding: 16px 20px;
      margin: 16px 0;
      display: flex;
      gap: 12px;
      align-items: flex-start;
    }

    .callout-icon {
      font-size: 18px;
      flex-shrink: 0;
      margin-top: 1px;
    }

    .callout-body { flex: 1; }
    .callout-body strong { display: block; margin-bottom: 4px; font-size: 14px; }
    .callout-body p { margin: 0; font-size: 14px; }

    .callout-info {
      background: var(--color-horizon);
      border-left: 4px solid var(--color-sky);
    }
    .callout-info strong { color: var(--color-ocean); }

    .callout-warning {
      background: #fffbeb;
      border-left: 4px solid var(--color-warning);
    }
    .callout-warning strong { color: var(--color-warning); }

    .callout-danger {
      background: #fef2f2;
      border-left: 4px solid var(--color-danger);
    }
    .callout-danger strong { color: var(--color-danger); }

    .callout-success {
      background: #f0fdf4;
      border-left: 4px solid var(--color-success);
    }
    .callout-success strong { color: var(--color-success); }

    /* ── Field List (Mask Documentation) ───────────── */
    .field-list {
      background: var(--color-white);
      border: 1px solid var(--color-border);
      border-radius: 10px;
      overflow: hidden;
      margin: 16px 0 24px;
    }

    .field-item {
      display: grid;
      grid-template-columns: 180px 1fr 90px;
      gap: 16px;
      padding: 12px 16px;
      border-bottom: 1px solid var(--color-border);
      align-items: center;
    }

    .field-item:last-child { border-bottom: none; }
    .field-item:hover { background: var(--color-horizon); }

    .field-name {
      font-size: 14px;
      font-weight: 600;
      color: var(--color-ink);
    }

    .field-desc {
      font-size: 14px;
      color: var(--color-slate);
    }

    .field-badge {
      font-size: 11px;
      font-weight: 600;
      padding: 3px 8px;
      border-radius: 9999px;
      text-align: center;
    }

    .field-badge-required {
      background: #fef2f2;
      color: var(--color-danger);
    }

    .field-badge-optional {
      background: var(--color-mist);
      color: var(--color-muted);
    }

    /* ── Function Key Box ──────────────────────────── */
    .fkey-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
      gap: 10px;
      margin: 16px 0 24px;
    }

    .fkey-item {
      background: var(--color-white);
      border: 1px solid var(--color-border);
      border-radius: 8px;
      padding: 12px 14px;
      display: flex;
      gap: 12px;
      align-items: center;
    }

    .fkey-key {
      background: var(--color-ink);
      color: var(--color-white);
      font-size: 12px;
      font-weight: 700;
      padding: 4px 10px;
      border-radius: 5px;
      font-family: 'JetBrains Mono', monospace;
      min-width: 44px;
      text-align: center;
      flex-shrink: 0;
    }

    .fkey-label {
      font-size: 13px;
      color: var(--color-slate);
      line-height: 1.4;
    }

    .fkey-label strong {
      display: block;
      font-size: 13px;
      color: var(--color-ink);
    }

    /* ── Error Messages ────────────────────────────── */
    .error-item {
      background: var(--color-white);
      border: 1px solid var(--color-border);
      border-left: 4px solid var(--color-danger);
      border-radius: 0 8px 8px 0;
      padding: 14px 18px;
      margin-bottom: 12px;
    }

    .error-msg {
      font-family: 'JetBrains Mono', monospace;
      font-size: 13px;
      color: var(--color-danger);
      font-weight: 500;
      margin-bottom: 6px;
    }

    .error-cause {
      font-size: 14px;
      color: var(--color-slate);
      margin-bottom: 4px;
    }

    .error-solution {
      font-size: 14px;
      color: var(--color-success);
      font-weight: 500;
    }

    /* ── Mask Card ─────────────────────────────────── */
    .mask-card {
      background: var(--color-white);
      border: 1px solid var(--color-border);
      border-radius: 12px;
      overflow: hidden;
      margin-bottom: 24px;
    }

    .mask-header {
      background: var(--color-ocean);
      padding: 14px 20px;
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .mask-header-name {
      font-size: 15px;
      font-weight: 700;
      color: var(--color-white);
    }

    .mask-header-desc {
      font-size: 13px;
      color: rgba(255,255,255,0.75);
    }

    .mask-body {
      padding: 20px;
    }

    /* ── Divider ───────────────────────────────────── */
    .section-divider {
      border: none;
      border-top: 1px solid var(--color-border);
      margin: 48px 0;
    }

    /* ── TOC (inline fallback ohne Sidebar) ─────────── */
    .toc {
      background: var(--color-horizon);
      border: 1px solid var(--color-foam);
      border-radius: 12px;
      padding: 20px 24px;
      margin-bottom: 40px;
    }

    .toc h2 {
      font-size: 15px;
      font-weight: 700;
      color: var(--color-ocean);
      margin-bottom: 12px;
      border: none;
      padding: 0;
    }

    .toc h2::before { display: none; }

    .toc ol {
      padding-left: 20px;
      margin: 0;
      column-count: 2;
      column-gap: 24px;
    }

    .toc li { margin-bottom: 6px; }

    .toc a {
      font-size: 14px;
      color: var(--color-ocean);
      text-decoration: none;
    }

    .toc a:hover { text-decoration: underline; }

    /* ── Responsive ────────────────────────────────── */
    @media (max-width: 900px) {
      .sidebar { display: none; }
      .main-content { padding: 32px 24px; }
      .toc ol { column-count: 1; }
    }
  </style>
</head>
<body>

<div class="page-wrapper">

  <!-- Sidebar Navigation -->
  <nav class="sidebar">
    <div class="sidebar-logo">
      <span>Benutzerdokumentation</span>
      <h1>[Programmname]</h1>
    </div>
    <div class="nav-section">
      <div class="nav-section-title">Inhalt</div>
      <a href="#uebersicht" class="nav-link active">Übersicht</a>
      <a href="#voraussetzungen" class="nav-link">Voraussetzungen</a>
      <a href="#start" class="nav-link">Programmstart</a>
      <a href="#masken" class="nav-link">Masken</a>
      <a href="#ablaeufe" class="nav-link">Bedienabläufe</a>
      <a href="#funktionstasten" class="nav-link">Funktionstasten</a>
      <a href="#fehlermeldungen" class="nav-link">Fehlermeldungen</a>
      <a href="#tipps" class="nav-link">Tipps & Hinweise</a>
    </div>
  </nav>

  <!-- Main Content -->
  <main class="main-content">

    <!-- Page Header -->
    <div class="page-header">
      <div class="badge">Benutzerdokumentation</div>
      <h1>[Programmname]</h1>
      <p>[Kurzbeschreibung: Was tut dieses Programm für den Benutzer?]</p>
    </div>

    <!-- Inhaltsverzeichnis (Fallback) -->
    <div class="toc">
      <h2>Inhalt dieser Dokumentation</h2>
      <ol>
        <li><a href="#uebersicht">Übersicht</a></li>
        <li><a href="#voraussetzungen">Voraussetzungen</a></li>
        <li><a href="#start">Programmstart</a></li>
        <li><a href="#masken">Masken &amp; Felder</a></li>
        <li><a href="#ablaeufe">Bedienabläufe</a></li>
        <li><a href="#funktionstasten">Funktionstasten</a></li>
        <li><a href="#fehlermeldungen">Fehlermeldungen</a></li>
        <li><a href="#tipps">Tipps &amp; Hinweise</a></li>
      </ol>
    </div>

    <!-- 1. Übersicht -->
    <section class="section" id="uebersicht">
      <h2>Übersicht</h2>
      <div class="meta-box">
        <dl class="meta-item"><dt>Programm</dt><dd>[Programmname]</dd></dl>
        <dl class="meta-item"><dt>Zweck</dt><dd>[Kurzbeschreibung]</dd></dl>
        <dl class="meta-item"><dt>Zielgruppe</dt><dd>[Benutzergruppe]</dd></dl>
        <dl class="meta-item"><dt>Stand</dt><dd>[Datum]</dd></dl>
      </div>
      <p>[Ausführliche Beschreibung des Programmzwecks aus Benutzersicht]</p>
    </section>

    <hr class="section-divider">

    <!-- 2. Voraussetzungen -->
    <section class="section" id="voraussetzungen">
      <h2>Voraussetzungen</h2>
      <p>[Was muss gegeben sein, bevor der Benutzer das Programm nutzen kann?]</p>
    </section>

    <hr class="section-divider">

    <!-- 3. Programmstart -->
    <section class="section" id="start">
      <h2>Programmstart</h2>
      <p>[Wie wird das Programm aufgerufen?]</p>
    </section>

    <hr class="section-divider">

    <!-- 4. Masken -->
    <section class="section" id="masken">
      <h2>Masken &amp; Felder</h2>

      <!-- Beispiel Masken-Card – für jede Maske wiederholen -->
      <div class="mask-card">
        <div class="mask-header">
          <div>
            <div class="mask-header-name">[Maskenname]</div>
            <div class="mask-header-desc">[Kurzbeschreibung der Maske]</div>
          </div>
        </div>
        <div class="mask-body">
          <div class="field-list">
            <div class="field-item">
              <span class="field-name">[Feldname]</span>
              <span class="field-desc">[Beschreibung für den Benutzer]</span>
              <span class="field-badge field-badge-required">Pflicht</span>
            </div>
            <div class="field-item">
              <span class="field-name">[Feldname 2]</span>
              <span class="field-desc">[Beschreibung für den Benutzer]</span>
              <span class="field-badge field-badge-optional">Optional</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <hr class="section-divider">

    <!-- 5. Bedienabläufe -->
    <section class="section" id="ablaeufe">
      <h2>Bedienabläufe</h2>

      <h3>[Aktion 1: z.B. Neuen Eintrag anlegen]</h3>
      <ol class="step-list">
        <li><p>[Schritt 1]</p></li>
        <li><p>[Schritt 2]</p></li>
        <li><p>[Schritt 3]</p></li>
      </ol>
    </section>

    <hr class="section-divider">

    <!-- 6. Funktionstasten -->
    <section class="section" id="funktionstasten">
      <h2>Funktionstasten</h2>
      <div class="fkey-grid">
        <div class="fkey-item">
          <span class="fkey-key">F3</span>
          <div class="fkey-label"><strong>Beenden</strong>Programm verlassen</div>
        </div>
        <div class="fkey-item">
          <span class="fkey-key">F12</span>
          <div class="fkey-label"><strong>Zurück</strong>Vorherige Maske</div>
        </div>
        <!-- weitere F-Keys ergänzen -->
      </div>
    </section>

    <hr class="section-divider">

    <!-- 7. Fehlermeldungen -->
    <section class="section" id="fehlermeldungen">
      <h2>Fehlermeldungen</h2>

      <div class="error-item">
        <div class="error-msg">[Fehlermeldungstext wie der Benutzer ihn sieht]</div>
        <div class="error-cause">Ursache: [Was hat den Fehler ausgelöst?]</div>
        <div class="error-solution">Lösung: [Was soll der Benutzer tun?]</div>
      </div>
    </section>

    <hr class="section-divider">

    <!-- 8. Tipps & Hinweise -->
    <section class="section" id="tipps">
      <h2>Tipps &amp; Hinweise</h2>

      <div class="callout callout-info">
        <span class="callout-icon">ℹ️</span>
        <div class="callout-body">
          <strong>Hinweis</strong>
          <p>[Praxistipp oder nützliche Information]</p>
        </div>
      </div>

      <div class="callout callout-warning">
        <span class="callout-icon">⚠️</span>
        <div class="callout-body">
          <strong>Achtung</strong>
          <p>[Wichtiger Hinweis auf häufigen Fehler oder Besonderheit]</p>
        </div>
      </div>
    </section>

  </main>
</div>

</body>
</html>
```

---

## HTML-Komponenten-Referenz

### Mask-Card (für jede Maske)
```html
<div class="mask-card">
  <div class="mask-header">
    <div>
      <div class="mask-header-name">[Maskenname]</div>
      <div class="mask-header-desc">[Zweck der Maske]</div>
    </div>
  </div>
  <div class="mask-body">
    <div class="field-list">
      <div class="field-item">
        <span class="field-name">[Feldbezeichnung]</span>
        <span class="field-desc">[Erklärung]</span>
        <span class="field-badge field-badge-required">Pflicht</span>
      </div>
    </div>
  </div>
</div>
```

### Schritt-für-Schritt-Liste
```html
<ol class="step-list">
  <li><p>[Schritt 1]</p></li>
  <li><p>[Schritt 2]</p></li>
</ol>
```

### Funktionstaste
```html
<div class="fkey-item">
  <span class="fkey-key">F5</span>
  <div class="fkey-label">
    <strong>Aktualisieren</strong>
    Anzeige neu laden
  </div>
</div>
```

### Fehlermeldung
```html
<div class="error-item">
  <div class="error-msg">[Fehlermeldungstext]</div>
  <div class="error-cause">Ursache: [Ursache]</div>
  <div class="error-solution">Lösung: [Lösung]</div>
</div>
```

### Callouts
```html
<!-- Info -->
<div class="callout callout-info">
  <span class="callout-icon">ℹ️</span>
  <div class="callout-body"><strong>Hinweis</strong><p>[Text]</p></div>
</div>

<!-- Warnung -->
<div class="callout callout-warning">
  <span class="callout-icon">⚠️</span>
  <div class="callout-body"><strong>Achtung</strong><p>[Text]</p></div>
</div>

<!-- Fehler -->
<div class="callout callout-danger">
  <span class="callout-icon">🚫</span>
  <div class="callout-body"><strong>Wichtig</strong><p>[Text]</p></div>
</div>

<!-- Erfolg -->
<div class="callout callout-success">
  <span class="callout-icon">✅</span>
  <div class="callout-body"><strong>Tipp</strong><p>[Text]</p></div>
</div>
```
