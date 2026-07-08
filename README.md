# Fable Skills — Strukturierte Senior-Wissensübergabe

**Version:** 1.7 · **Stand:** 2026-07-08 · **Sprache:** Deutsch · **Pflege:** Bei jeder inhaltlichen Änderung Version und Datum in der betroffenen Datei anheben. · **Änderung 1.1:** Neue Schicht `60-agentic-ai/` (Orchestrator, Modell-Routing, Kontext-Budget, 8 Agenten-Rollen mit IBM-i-Fokus). · **Änderung 1.2:** Agent-Harness für Claude Code: Betriebsanleitung, `.claude/agents/` (8 Subagenten), `AGENT-SETUP.md` (Nutzung in anderen Projekten). · **Änderung 1.3:** Agent-Setup pfadunabhängig und projektlokal: `install-fable.ps1` kopiert Skills + Subagenten + Betriebsanleitung ins Zielprojekt; FABLE_SKILLS_ROOT wird relativ aufgelöst. · **Änderung 1.4:** Layout 2.0 — alles liegt unter `.claude/` (`.claude/fable-skills/` mit Skills, INDEX und Betriebsanleitung `FABLE-AGENT.md`); ein neues Projekt braucht nur noch `.claude\` + `CLAUDE.md` kopieren. · **Änderung 1.5:** Portierung auf GitHub Copilot — `.copilot/` statt `.claude/`, `COPILOT.md` statt `CLAUDE.md`, Agent-Dateien angepasst. · **Änderung 1.6:** Natives Copilot-Layout — alles liegt unter `.github/`; `copilot-instructions.md` wird von Copilot automatisch geladen (kein Lader/Import mehr nötig), die 8 Rollen sind echte Custom Agents (`*.agent.md`) mit rollenspezifischen Tool-Grenzen. · **Änderung 1.7:** Neue Schicht `70-sprachreferenz/` — reine RPG-Syntax-Referenzen (Free-/Fixed-Format) gegen dünne, oft vermischte Trainingsdaten zu RPG/IBM i; Willi verweist beim Codieren zusätzlich darauf.

## Was dieses Repository ist

Dieses Skill-System ist eine strukturierte Wissensübergabe: So, als würde ein Senior Developer kurz vor dem Ruhestand sein Erfahrungswissen, seine Standards, seine Entscheidungslogik und seine Arbeitsweise an Junioren und an kleinere KI-Modelle weitergeben. Jede Datei operationalisiert einen Teilbereich seniorigen Denkens in konkrete Regeln, Abläufe, Checklisten und Warnsignale.

Die Skills sind so geschrieben, dass:

- ein **Junior** nicht nur Anweisungen kopiert, sondern die Entscheidungslogik dahinter versteht,
- ein **kleines Modell** (z. B. Haiku) diszipliniert und fehlerarm arbeitet,
- ein **großes Modell** (z. B. Opus/Fable) seine Analysetiefe gezielt und nicht ausufernd einsetzt.

## Leitprinzipien (gelten für ALLE Skills)

1. **Korrektheit vor Eleganz.** Schöner Code, der falsch ist, ist wertlos.
2. **Verständlichkeit vor Cleverness.** Code wird 10-mal öfter gelesen als geschrieben.
3. **Sicherheit vor Geschwindigkeit.** Eine Abkürzung, die Produktionsdaten gefährdet, ist keine Abkürzung.
4. **Stabilität vor Perfektionismus.** Ein funktionierendes System wird nicht für kosmetische Ideale riskiert.
5. **Beweise vor Bauchgefühl.** Behauptungen über Code werden am Code belegt, nicht vermutet.
6. **Symptom ≠ Ursache.** Erst verstehen, dann ändern.
7. **Legacy-Code fair behandeln.** Er löst seit Jahren echte Probleme — Respekt vor dem Kontext, in dem er entstand.

## Einheitliche Dateistruktur

Jede Skill-Datei folgt exakt dieser Gliederung:

| Abschnitt | Inhalt |
|---|---|
| Skill-Name | Kurzname des Skills |
| Zweck | Was dieser Skill erreicht |
| Einsatzbereich | Wann und wo er angewendet wird |
| Denkweise | Das mentale Modell des Seniors |
| Kernregeln | MUSS / SOLL / KANN — klar unterschieden |
| Arbeitsablauf | Konkrete Schritte in Reihenfolge |
| Checkliste | Abhakbare Prüfpunkte vor Abschluss |
| Typische Fehler | Was Junioren (und Modelle) regelmäßig falsch machen |
| Beispiele | Kleine, realistische Vorher/Nachher- oder Entscheidungsbeispiele |
| Eskalation | Wann Rückfrage/Übergabe an Menschen oder Senior zwingend ist |

**Regel-Kategorien:**
- **MUSS** — nicht verhandelbar. Verstoß = Fehler.
- **SOLL** — Standard. Abweichung nur mit benanntem Grund.
- **KANN** — situativ sinnvoll, Ermessensspielraum.

## Tokeneffiziente Nutzung durch Agents

Skills sind Arbeitsmittel, kein Lesestoff. Damit Modelle sie mit minimalem Kontextverbrauch nutzen:

1. **Einstieg über [INDEX.md](.github/fable-skills/INDEX.md):** Dort steht pro Skill ein Einzeiler. Skill dort auswählen — pro Aufgabe 1, maximal 2 Dateien laden. Nie „alle Skills zur Sicherheit“.
2. **Operativer Kern zuerst:** In jeder Datei genügen für die Arbeit **Kurzfassung → Kernregeln → Checkliste**. Denkweise, Typische Fehler und Beispiele nur nachladen, wenn eine Regel unklar ist oder ein Junior sie erklärt bekommen soll.
3. **Anwenden, nicht zitieren:** Regeln umsetzen; keine Skill-Passagen in Antworten, Diffs oder Berichte kopieren.
4. **Verweisen statt wiederholen:** Querverweise (`skill-x.md`) nur folgen, wenn die Aufgabe es wirklich verlangt.
5. **Autorenregel:** Neue/geänderte Skills bleiben kompakt (Ziel ≤ ~130 Zeilen, hart max. 200), ohne inhaltliche Duplikation zwischen Dateien — verweisen statt wiederholen. Jede Datei trägt direkt unter den Metadaten eine einzeilige **Kurzfassung**.

## Agentic-AI-Schicht (60-agentic-ai)

Die Schicht `60-agentic-ai/` definiert ein Multi-Agent-System auf Basis der übrigen Skills:

- **Orchestrator (Viktor)** zerlegt Aufträge in Arbeitspakete, besetzt sie mit Agenten-Rollen und führt Ergebnisse geprüft zusammen — er arbeitet nie selbst am Code.
- **Modell-Routing** wählt je Paket die kleinste zuverlässige Modellklasse (Haiku/Sonnet/Opus); die Wahl bindet den Agenten verbindlich an die Arbeitsregeln aus `00-modelle/`. Risiko erzwingt Upgrade plus Review.
- **Kontext-Budget** hält die Zusammenarbeit tokeneffizient: Standard-Briefing (Ziel, minimaler Kontext, Nicht-Ziele, Rückgabeformat, Modellklasse) und Standard-Rückgabe (Ergebnis, Annahmen, Verifikation, Nebenbefunde).
- **Acht Agenten-Rollen mit eigener Persönlichkeit** zur klaren Differenzierung: Paula (Prompt-Engineer), Willi (RPG-Coder), Klara (CL-Spezialistin), Erwin (DB2-Analyst), Ingrid (Analyzer), Bruno (Dokumentar), Greta (Reviewerin), Max (Modernisierer).

**Domänenfokus:** IBM i / AS400 — RPG (RPG III/RPG/400 bis Free-Format), CL/CLLE, DB2 for i (SQL und DDS), Systemkommandos. Andere Sprachen sind möglich, wenn der Auftrag sie explizit nennt; dann gelten die `10-engineering/`-Skills.

**Betrieb als GitHub-Copilot-Agent:** Die Schicht ist als lauffähiges Agent-Harness ausgeprägt — [.github/copilot-instructions.md](.github/copilot-instructions.md) wird von GitHub Copilot bei jedem Prompt automatisch geladen und verweist auf die Betriebsanleitung [.github/fable-skills/FABLE-AGENT.md](.github/fable-skills/FABLE-AGENT.md) (Skill-Protokoll, Arbeitsmodus, Routing, Übergabeformate); die acht Rollen liegen als echte Custom Agents in `.github/agents/*.agent.md`, der Orchestrator Viktor wird von der Haupt-Instanz übernommen. Ein neues Projekt braucht nur den Ordner `.github\` — Einrichtung und Nutzung: [AGENT-SETUP.md](AGENT-SETUP.md).

## Sprachreferenz-Schicht (70-sprachreferenz)

Reine Syntax-Fakten statt Verhaltensregeln — für Domänen mit dünnen oder widersprüchlichen Trainingsdaten (aktuell RPG/IBM i). Kein Stil, keine Entscheidungslogik: nur, was syntaktisch korrekt ist, damit ein Modell nicht aus Analogie zu C#/COBOL/Java rät. `skill-rpg-syntax-free-format.md` deckt **FREE/ILE RPG/SQLRPGLE ab, `skill-rpg-syntax-fixed-format.md` das spaltengebundene RPG III/RPG400. Willi (`skill-agent-rpg-coder.md`) lädt bei jeder Code-Erstellung/-Änderung die passende Datei zusätzlich zu seiner Rollen-Datei. Weitere Sprachreferenzen (z. B. CL, DB2-SQL) können bei Bedarf nach demselben Muster ergänzt werden.

## Ordnerstruktur

```
Fable Skills/                        (Struktur = 1:1 die eines Zielprojekts)
├── README.md                        ← diese Datei (nur im Repo)
├── AGENT-SETUP.md                   ← Einrichtung/Nutzung des Agenten in anderen Projekten (nur im Repo)
├── install-fable.ps1                ← Komfort-Installer für Merge-Fälle und Updates (nur im Repo)
└── .github/
    ├── copilot-instructions.md      ← wird von GitHub Copilot automatisch bei jedem Prompt geladen
    ├── agents/                      ← 8 Custom Agents (*.agent.md): Paula, Willi, Klara, Erwin, Ingrid, Bruno, Greta, Max
    └── fable-skills/                ← FABLE_SKILLS_ROOT: Betriebsanleitung + Wissensbasis
        ├── FABLE-AGENT.md           ← Betriebsanleitung des Agent-Harness
        ├── INDEX.md                 ← Einstiegspunkt: ein Einzeiler pro Skill
        ├── 00-modelle/              ← modellspezifische Arbeitsregeln
        │   ├── skill-fable-haiku.md
        │   ├── skill-fable-sonnet.md
        │   └── skill-fable-opus.md
        ├── 10-engineering/          ← Kernskills Entwicklung
        │   ├── skill-requirements-analysis.md
        │   ├── skill-task-decomposition.md
        │   ├── skill-implementation-planning.md
        │   ├── skill-architecture-thinking.md
        │   ├── skill-code-implementation.md
        │   ├── skill-refactoring.md
        │   ├── skill-debugging.md
        │   ├── skill-testing-strategy.md
        │   ├── skill-defensive-programming.md
        │   ├── skill-error-handling.md
        │   ├── skill-performance-analysis.md
        │   ├── skill-security-review.md
        │   ├── skill-maintainability.md
        │   ├── skill-legacy-code-handling.md
        │   ├── skill-api-design.md
        │   └── skill-database-thinking.md
        ├── 20-delivery/             ← Planung, Strukturierung, Delivery
        │   ├── skill-project-planning.md
        │   ├── skill-feature-planning.md
        │   ├── skill-risk-analysis.md
        │   ├── skill-estimation.md
        │   ├── skill-prioritization.md
        │   ├── skill-decision-records.md
        │   ├── skill-handover.md
        │   └── skill-onboarding-juniors.md
        ├── 30-dokumentation/        ← Dokumentation & Wissensweitergabe
        │   ├── skill-documentation-writing.md
        │   ├── skill-technical-explanations.md
        │   ├── skill-architecture-documentation.md
        │   ├── skill-runbook-writing.md
        │   ├── skill-knowledge-transfer.md
        │   └── skill-change-documentation.md
        ├── 40-review-analyse/       ← Reviews, Analysen, Qualität
        │   ├── skill-code-review.md
        │   ├── skill-program-analysis.md
        │   ├── skill-root-cause-analysis.md
        │   ├── skill-clean-code-analysis.md
        │   ├── skill-static-analysis-thinking.md
        │   ├── skill-design-smell-detection.md
        │   ├── skill-bug-triage.md
        │   └── skill-change-impact-analysis.md
        ├── 50-clean-code/           ← Clean Code & Engineering-Prinzipien
        │   ├── skill-naming.md
        │   ├── skill-function-design.md
        │   ├── skill-module-design.md
        │   ├── skill-separation-of-concerns.md
        │   ├── skill-abstraction-judgment.md
        │   ├── skill-complexity-control.md
        │   ├── skill-readability.md
        │   └── skill-consistency.md
        └── 60-agentic-ai/           ← Agentic AI: Orchestrator & Agenten-Rollen (Fokus IBM i)
            ├── skill-agent-orchestrator.md
            ├── skill-agent-model-routing.md
            ├── skill-agent-kontext-budget.md
            ├── skill-agent-prompt-engineer.md
            ├── skill-agent-rpg-coder.md
            ├── skill-agent-cl-spezialist.md
            ├── skill-agent-db2-analyst.md
            ├── skill-agent-analyzer.md
            ├── skill-agent-dokumentar.md
            ├── skill-agent-reviewer.md
            └── skill-agent-modernisierer.md
        └── 70-sprachreferenz/       ← reine Syntax-Referenzen (kein Verhalten, kein Stil)
            ├── skill-rpg-syntax-free-format.md
            └── skill-rpg-syntax-fixed-format.md
```

## Status der Dateien

**Vollständig (Stand 2026-07-08):** Alle 62 Skill-Dateien sind erstellt — 3 Modell-Skills, 16 Engineering, 8 Delivery, 6 Dokumentation, 8 Review/Analyse, 8 Clean Code, 11 Agentic AI, 2 Sprachreferenz — plus [INDEX.md](.github/fable-skills/INDEX.md) als tokeneffizienter Einstiegspunkt (ein Einzeiler pro Skill).

Jede Datei trägt direkt unter den Metadaten eine einzeilige **Kurzfassung**; der operative Kern jeder Datei ist Kurzfassung → Kernregeln → Checkliste (siehe „Tokeneffiziente Nutzung durch Agents").

## Empfohlene Erst-Nutzung (Top 10)

1. `00-modelle/skill-fable-sonnet.md` — Standard-Arbeitsmodus für den Alltag
2. `00-modelle/skill-fable-opus.md` — Tiefenanalyse-Modus für schwere Fälle
3. `10-engineering/skill-requirements-analysis.md` — verhindert falsche Arbeit an der Quelle
4. `10-engineering/skill-task-decomposition.md` — macht große Aufgaben beherrschbar
5. `10-engineering/skill-implementation-planning.md` — Plan vor Code
6. `40-review-analyse/skill-code-review.md` — größter Qualitätshebel im Team
7. `40-review-analyse/skill-program-analysis.md` — systematisches Code-Lesen
8. `40-review-analyse/skill-clean-code-analysis.md` — undogmatische Qualitätsbewertung
9. `30-dokumentation/skill-documentation-writing.md` — Wissen konservieren
10. `20-delivery/skill-handover.md` — Übergaben ohne Wissensverlust

## Pflegehinweise

- Skills sind **lebende Dokumente**: Wer eine Regel in der Praxis widerlegt, aktualisiert die Datei (Version hochzählen, Datum setzen, Änderung im Kopf der Datei vermerken).
- Neue Regeln nur aufnehmen, wenn sie **konkret und prüfbar** sind. „Schreibe guten Code" ist keine Regel.
- Sprach-/Domänenhinweise (C#, SQL, RPG, Python, JavaScript, APIs, Legacy) nur dort ergänzen, wo sie echte Praxisrelevanz haben — kein generischer Ballast.
