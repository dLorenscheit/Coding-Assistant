# AGENT-SETUP — Fable-Agent einrichten und nutzen

**Version:** 3.0 · **Stand:** 2026-07-05 · **Zweck:** Beschreibt, wie das Fable-Skill-System als funktionsfähiger Coding-Agent (Claude Code) betrieben wird — hier im Repo und **projektlokal** in beliebigen anderen Projekten. Keine globale Installation, keine absoluten Pfade. · **Änderung 3.0:** Alles liegt unter `.claude/` — ein neues Projekt braucht nur noch **`.claude\` + `CLAUDE.md` kopieren**; die Betriebsanleitung heißt jetzt `.claude/fable-skills/FABLE-AGENT.md` und wird per `@`-Import aus der Root-`CLAUDE.md` geladen.

## Bausteine

| Baustein | Ort (identisch im Repo und in jedem Zielprojekt) | Funktion |
|---|---|---|
| `CLAUDE.md` | Projektwurzel | Schlanker Lader: importiert die Betriebsanleitung per `@.claude/fable-skills/FABLE-AGENT.md`; darunter Platz für Projekt-Notizen |
| `.claude/fable-skills/FABLE-AGENT.md` | im Projekt | Betriebsanleitung: regelt Skill-Protokoll, Arbeitsmodus, Routing, Formate |
| `.claude/fable-skills/` (INDEX.md + `00-modelle/` … `60-agentic-ai/`) | im Projekt | Wissensbasis; wird **lazy** geladen (nie komplett in den Kontext) |
| `.claude/agents/*.md` | im Projekt | 8 Subagenten (Paula, Willi, Klara, Erwin, Ingrid, Bruno, Greta, Max) — Quelle der Wahrheit ist dieses Repo |
| `install-fable.ps1` | nur im Repo | Komfort-Installer für Projekte mit bestehender `CLAUDE.md` bzw. für Updates |

Der Orchestrator (Viktor) ist bewusst **kein** Subagent: Die Haupt-Instanz übernimmt seine Rolle (Stufe 3 in `FABLE-AGENT.md`), weil nur sie Subagenten starten, parallelisieren und Ergebnisse zusammenführen kann.

## Pfad-Konvention (überall gleich)

**FABLE_SKILLS_ROOT = `.claude/fable-skills/`** unter der Projektwurzel — im Fable-Repo wie in jedem Zielprojekt. Alle Skill-Verweise (in Betriebsanleitung, Agenten und Skills) sind relativ dazu. Fallback: Findet ein Agent den Ordner nicht auf Anhieb, sucht er per Glob nach `**/INDEX.md`.

Damit funktioniert das System an jedem Ablageort (anderer Rechner, anderer Benutzer, verschobener Ordner) ohne Anpassung.

## Nutzung A — direkt in diesem Ordner

Claude Code in der Repo-Wurzel starten. `CLAUDE.md` wird automatisch geladen (und importiert die Betriebsanleitung), die Agenten aus `.claude/agents/` sind verfügbar. Geeignet für Skill-Pflege und Aufgaben, bei denen der Code per Pfad referenziert wird.

## Nutzung B — neues Projekt (Normalfall): einfach kopieren

Zwei Dinge aus dem Fable-Repo in die Projektwurzel kopieren — fertig:

```
<Projekt>\
├── CLAUDE.md        ← Kopie der Repo-CLAUDE.md (schlanker Lader + Projekt-Notizen)
└── .claude\         ← Kopie des Repo-Ordners .claude\
    ├── agents\          (8 Subagenten)
    └── fable-skills\    (FABLE-AGENT.md, INDEX.md, 00-modelle\ … 60-agentic-ai\)
```

Danach ist das Projekt autark: Alles Nötige liegt im Projekt selbst und kann mit ihm versioniert, kopiert oder auf andere Rechner mitgenommen werden. Abweichungen des Projekts (z. B. anderes Fachgebiet als IBM i) unter „Projekt-Notizen" in der `CLAUDE.md` eintragen.

**Hat das Zielprojekt schon eine eigene `CLAUDE.md`?** Dann nur `.claude\` kopieren und diese eine Zeile in die bestehende `CLAUDE.md` aufnehmen:

```markdown
@.claude/fable-skills/FABLE-AGENT.md
```

**Hat das Zielprojekt schon einen eigenen `.claude\`-Ordner?** Nur die Unterordner `agents\` und `fable-skills\` hineinkopieren; vorhandene Dateien wie `settings.json` bleiben unberührt.

## Nutzung C — per Skript (Merge-Fälle und Updates)

Das Skript macht dasselbe wie Nutzung B, aber idempotent und merge-sicher (hängt den Fable-Block an bestehende `CLAUDE.md` an, überschreibt nichts Fremdes in `.claude\`, warnt bei Altlasten des 1.x-Layouts `<Projekt>\fable-skills\`):

```powershell
powershell -File .\install-fable.ps1 -Target "<Pfad zum Zielprojekt>"
```

Nach Änderungen im Fable-Repo erneut ausführen, um Projekt-Kopien zu aktualisieren. **Aufräumen nach früherer globaler Installation:** `-RemoveGlobal` mitgeben — entfernt die 8 Fable-Agenten aus `~\.claude\agents\`.

## Warum das tokeneffizient ist

1. **Kleiner Dauer-Kontext:** Nur `CLAUDE.md` + importierte Betriebsanleitung (~1 Seite) sind immer geladen; die 60 Skills bleiben auf der Platte.
2. **Lazy Loading mit Leseprotokoll:** Pro Aufgabe max. 1–2 Skill-Dateien, davon nur Kurzfassung → Kernregeln → Checkliste.
3. **Orchestrierungs-Check:** Einfache Aufgaben laufen ohne Subagenten (Stufe 1) — kein Agenten-Overhead.
4. **Modell-Routing:** Jedes Paket auf der kleinsten zuverlässigen Klasse (haiku/sonnet/opus); Risiko erzwingt Upgrade + Review statt Dauer-Opus.
5. **Feste Übergabeformate:** 5-Felder-Briefing und 4-Felder-Rückgabe verhindern Kontext-Flutung und Verlaufs-Schleppnetze.

## Pflege

- Quelle der Wahrheit ist dieses Repo: Agenten-Definitionen in `.claude/agents/`, inhaltliche Regeln in den Skill-Dateien unter `.claude/fable-skills/` ändern — danach Zielprojekte per Kopie oder `install-fable.ps1` aktualisieren (die Projekt-`CLAUDE.md` bleibt unangetastet).
- Inhaltliche Regeln gehören in die Skill-Dateien, nicht in die Agenten-Definitionen — dort stehen nur Persona, Pflicht-Start, das Unverhandelbare und das Rückgabeformat.
- Skill-Konventionen: siehe `README.md` (Abschnittsfolge, ≤ ~130 Zeilen, Version + Stand anheben, INDEX/README nachführen).
