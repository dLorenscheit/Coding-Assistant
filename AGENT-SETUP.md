# AGENT-SETUP — Fable-Agent einrichten und nutzen

**Version:** 4.0 · **Stand:** 2026-07-07 · **Zweck:** Beschreibt, wie das Fable-Skill-System als funktionsfähiger Coding-Agent (GitHub Copilot in VS Code) betrieben wird — hier im Repo und **projektlokal** in beliebigen anderen Projekten. Keine globale Installation, keine absoluten Pfade. · **Änderung 4.0:** Natives Copilot-Layout — alles liegt unter `.github/`; kein `COPILOT.md`-Lader mehr (Copilot lädt `copilot-instructions.md` selbst automatisch); die 8 Rollen sind echte Custom Agents (`*.agent.md`).

## Bausteine

| Baustein | Ort (identisch im Repo und in jedem Zielprojekt) | Funktion |
|---|---|---|
| `.github/copilot-instructions.md` | im Projekt | Wird von GitHub Copilot bei **jedem** Prompt automatisch geladen. Enthält Leitprinzipien + Kernregeln direkt und verweist auf die vollständige Betriebsanleitung; darunter Platz für Projekt-Notizen |
| `.github/fable-skills/FABLE-AGENT.md` | im Projekt | Vollständige Betriebsanleitung: regelt Skill-Protokoll, Arbeitsmodus, Routing, Formate |
| `.github/fable-skills/` (INDEX.md + `00-modelle/` … `60-agentic-ai/`) | im Projekt | Wissensbasis; wird **lazy** geladen (nie komplett in den Kontext) |
| `.github/agents/*.agent.md` | im Projekt | 8 echte VS-Code-Custom-Agents (Paula, Willi, Klara, Erwin, Ingrid, Bruno, Greta, Max) — Quelle der Wahrheit ist dieses Repo |
| `install-fable.ps1` | nur im Repo | Komfort-Installer für Projekte mit bestehendem `.github`-Ordner bzw. für Updates |

Der Orchestrator (Viktor) ist bewusst **kein** Custom Agent: Die Haupt-Instanz (der Standard-Copilot-Chat, in dem `copilot-instructions.md` automatisch geladen ist) übernimmt seine Rolle (Stufe 3 in `FABLE-AGENT.md`), weil nur sie mehrere Custom Agents aufrufen, parallelisieren und Ergebnisse zusammenführen kann.

## Pfad-Konvention (überall gleich)

**FABLE_SKILLS_ROOT = `.github/fable-skills/`** unter der Projektwurzel — im Fable-Repo wie in jedem Zielprojekt. Alle Skill-Verweise (in Betriebsanleitung, Agenten und Skills) sind relativ dazu. Fallback: Findet ein Agent den Ordner nicht auf Anhieb, sucht er per Glob nach `**/INDEX.md`.

Damit funktioniert das System an jedem Ablageort (anderer Rechner, anderer Benutzer, verschobener Ordner) ohne Anpassung.

## Wie GitHub Copilot das System lädt

- **Immer aktiv, ohne Zutun:** `.github/copilot-instructions.md` wird von Copilot bei jedem Chat-Request automatisch in den Kontext gemischt (kein Import, kein `@`-Mechanismus nötig — das ist Copilot-Bordmittel).
- **Auf Zuruf:** Die 8 Rollen liegen als `.github/agents/*.agent.md` vor und erscheinen im Agenten-Picker in VS Code; die Haupt-Instanz kann sie zusätzlich per `#agent-name`-Erwähnung als Subagent aufrufen (Stufe 2/3 in `FABLE-AGENT.md`).
- **Bei Bedarf:** Die Skill-Dateien unter `.github/fable-skills/` werden erst gelesen, wenn eine Aufgabe sie wirklich braucht (Lazy Loading über `INDEX.md`).

## Nutzung A — direkt in diesem Ordner

GitHub Copilot in der Repo-Wurzel starten. `.github/copilot-instructions.md` wird automatisch geladen, die Agenten aus `.github/agents/` sind im Picker verfügbar. Geeignet für Skill-Pflege und Aufgaben, bei denen der Code per Pfad referenziert wird.

## Nutzung B — neues Projekt (Normalfall): einfach kopieren

Den Ordner `.github/` aus dem Fable-Repo in die Projektwurzel kopieren — fertig:

```
<Projekt>\
└── .github\
    ├── copilot-instructions.md     (automatisch geladener Einstieg + Projekt-Notizen)
    ├── agents\                     (8 Custom Agents: *.agent.md)
    └── fable-skills\               (FABLE-AGENT.md, INDEX.md, 00-modelle\ … 60-agentic-ai\)
```

Danach ist das Projekt autark: Alles Nötige liegt im Projekt selbst und kann mit ihm versioniert, kopiert oder auf andere Rechner mitgenommen werden. Abweichungen des Projekts (z. B. anderes Fachgebiet als IBM i) unter „Projekt-Notizen" in der `.github/copilot-instructions.md` eintragen.

**Hat das Zielprojekt schon eine eigene `.github/copilot-instructions.md`?** Dann nur `.github/agents/` und `.github/fable-skills/` hineinkopieren und den Abschnitt „Pflicht zu Sitzungsbeginn" (siehe Vorlage in diesem Repo) in die bestehende Datei übernehmen — bestehende Projektregeln bleiben erhalten, der Fable-Block wird ergänzt.

**Hat das Zielprojekt schon einen eigenen `.github`-Ordner** (z. B. mit `workflows/` für CI)? Nur die Unterordner `agents/` und `fable-skills/` hineinkopieren; vorhandene Dateien und Ordner bleiben unberührt.

## Nutzung C — per Skript (Merge-Fälle und Updates)

Das Skript macht dasselbe wie Nutzung B, aber idempotent und merge-sicher (hängt den Fable-Abschnitt an eine bestehende `copilot-instructions.md` an, überschreibt nichts Fremdes in `.github/`, warnt bei Altlasten des Vorgänger-Layouts `<Projekt>\.copilot\` bzw. `<Projekt>\fable-skills\`):

```powershell
powershell -File .\install-fable.ps1 -Target "<Pfad zum Zielprojekt>"
```

Nach Änderungen im Fable-Repo erneut ausführen, um Projekt-Kopien zu aktualisieren.

## Warum das tokeneffizient ist

1. **Kleiner Dauer-Kontext:** Nur `.github/copilot-instructions.md` (~1 Seite) ist immer geladen; die 60 Skills bleiben auf der Platte.
2. **Lazy Loading mit Leseprotokoll:** Pro Aufgabe max. 1–2 Skill-Dateien, davon nur Kurzfassung → Kernregeln → Checkliste.
3. **Orchestrierungs-Check:** Einfache Aufgaben laufen ohne Custom Agent (Stufe 1) — kein Agenten-Overhead.
4. **Rollentrennung mit Tool-Grenzen:** Jeder Custom Agent hat nur die Tools, die seine Rolle braucht (z. B. Greta/Ingrid/Paula ohne Schreibrechte) — Regeln wie „ändert nie Code" sind damit technisch erzwungen, nicht nur behauptet.
5. **Feste Übergabeformate:** 5-Felder-Briefing und 4-Felder-Rückgabe verhindern Kontext-Flutung und Verlaufs-Schleppnetze.

## Pflege

- Quelle der Wahrheit ist dieses Repo: Agenten-Definitionen in `.github/agents/`, inhaltliche Regeln in den Skill-Dateien unter `.github/fable-skills/` ändern — danach Zielprojekte per Kopie oder `install-fable.ps1` aktualisieren (die Projekt-`copilot-instructions.md` bleibt unangetastet).
- Inhaltliche Regeln gehören in die Skill-Dateien, nicht in die Agenten-Definitionen — dort stehen nur Persona, Pflicht-Start, das Unverhandelbare und das Rückgabeformat.
- Skill-Konventionen: siehe `README.md` (Abschnittsfolge, ≤ ~130 Zeilen, Version + Stand anheben, INDEX/README nachführen).
