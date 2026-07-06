# INDEX — Fable Skills (Einstiegspunkt für Agents)

**Nutzungsprotokoll (tokeneffizient):**
1. Skill hier per Einzeiler auswählen — pro Aufgabe 1, maximal 2 Dateien laden.
2. In der Datei zuerst nur **Kurzfassung → Kernregeln → Checkliste** lesen. Denkweise/Fehler/Beispiele nur bei Bedarf.
3. Regeln anwenden, nicht zitieren. Querverweisen nur folgen, wenn die Aufgabe es verlangt.
4. Agenten-Rollen (60-agentic-ai) laden ihre Rollen-Datei plus höchstens einen Fach-Skill; die Modellklasse je Arbeitspaket bestimmt zusätzlich den passenden 00-modelle-Skill.

## 00-modelle
- `skill-fable-haiku.md` — Kleines Modell: minimaler Radius, explizite Annahmen, früh eskalieren
- `skill-fable-sonnet.md` — Alltagsmodell: erst verstehen, verifizieren statt behaupten, Unsicherheit dreistufig kennzeichnen
- `skill-fable-opus.md` — Großes Modell: Tiefe dosieren, Befund/Bewertung/Empfehlung trennen, Belege vor Autorität

## 10-engineering
- `skill-requirements-analysis.md` — Vor dem Code: Problem, prüfbare Erfolgskriterien, Nicht-Ziele, Randfälle klären
- `skill-task-decomposition.md` — Große Aufgaben in lauffähige, prüfbare Schritte schneiden; Risiko nach vorn
- `skill-implementation-planning.md` — Technische Route vor dem Editor: Eingriffsstellen, Nähte, Verifikation
- `skill-architecture-thinking.md` — Architektur als Trade-off: Reversibilität, Grenzen, einfachste tragfähige Lösung
- `skill-code-implementation.md` — Code schreiben: kleine lauffähige Schritte, Repo-Muster folgen, laufend verifizieren
- `skill-refactoring.md` — Verhalten erhalten: Testnetz zuerst, kleine Schritte, getrennt von Feature-Änderungen
- `skill-debugging.md` — Reproduzieren, Hypothesen testen, Ursache belegen statt Symptom patchen
- `skill-testing-strategy.md` — Was testen, wie tief: Verhalten statt Implementierung, Risiko bestimmt Abdeckung
- `skill-defensive-programming.md` — An Systemgrenzen validieren, innen schnell scheitern, gezielt statt überall absichern
- `skill-error-handling.md` — Fehlerpfade als Erstklassiges: nie schlucken, Kontext mitgeben, bewusst reagieren
- `skill-performance-analysis.md` — Erst messen, Ziel definieren, Engpass belegen, Verbesserung nachweisen
- `skill-security-review.md` — Eingaben, Berechtigungen, Secrets, Injection systematisch prüfen
- `skill-maintainability.md` — Für die nächste Änderung optimieren: Änderungskosten als Qualitätsmaß
- `skill-legacy-code-handling.md` — Alt-Code sicher ändern: Absicherungstests, Nähte, kein Rewrite-Reflex
- `skill-api-design.md` — Schnittstellen aus Konsumentensicht: Verträge, Kompatibilität, konsistente Fehler
- `skill-database-thinking.md` — Daten überleben Code: Schema-Kompatibilität, Transaktionen, Indizes, Migrationen

## 20-delivery
- `skill-project-planning.md` — Projekte als prüfbare Meilensteine mit Risiken und Puffern planen
- `skill-feature-planning.md` — Features schneiden: kleinster wertvoller Wurf, Rollout und Messung mitdenken
- `skill-risk-analysis.md` — Risiken benennen, gewichten, entschärfen, Frühwarnsignale definieren
- `skill-estimation.md` — Schätzen mit Spannen und Annahmen statt Punktzahlen und Wunschdenken
- `skill-prioritization.md` — Wert, Aufwand, Risiko, Verzögerungskosten — und begründet Nein sagen
- `skill-decision-records.md` — Entscheidungen mit Kontext, Optionen und Folgen dauerhaft festhalten (ADR)
- `skill-handover.md` — Übergaben: Zustand statt Chronik, Gefahrenzonen, verworfene Wege, Empfangsschleife
- `skill-onboarding-juniors.md` — Junioren befähigen: sichere erste Aufgaben, Warum erklären, Feedbackschleifen

## 30-dokumentation
- `skill-documentation-writing.md` — Doku für den Leser in 18 Monaten: Warum statt Was, getestet, datiert
- `skill-technical-explanations.md` — Technik zielgruppengerecht erklären: Modell vor Detail, Beispiel vor Abstraktion
- `skill-architecture-documentation.md` — Systembild knapp und aktuell: Kontext, Bausteine, Entscheidungen
- `skill-runbook-writing.md` — Betriebsanleitungen für den Störfall: symptomorientiert, exakt, getestet
- `skill-knowledge-transfer.md` — Kopfwissen sichern: nach Risiko priorisieren, Transfer verifizieren
- `skill-change-documentation.md` — Änderungen nachvollziehbar machen: Commits, Changelogs, Migrationshinweise

## 40-review-analyse
- `skill-code-review.md` — Schaden vor Merge verhindern: Risiko vor Stil, über den Diff hinaus lesen
- `skill-program-analysis.md` — Code systematisch lesen: Leitfrage, Datenfluss, Belege mit Fundstelle
- `skill-root-cause-analysis.md` — Vom Symptom zur belegten Ursache: Zeitachse, Warum-Kette, Beweis
- `skill-clean-code-analysis.md` — Qualität ökonomisch bewerten: kosmetisch vs. strukturell, Kontext zählt
- `skill-static-analysis-thinking.md` — Wie ein Analyzer denken: Pfade, Null, Ressourcen; Tool-Befunde triagieren
- `skill-design-smell-detection.md` — Struktur-Warnsignale erkennen und als Hinweis, nicht Urteil behandeln
- `skill-bug-triage.md` — Bugs einordnen: Schwere, Häufigkeit, Workaround — bevor jemand fixt
- `skill-change-impact-analysis.md` — Wirkradius einer Änderung: Aufrufer, Daten, Verträge, versteckte Kopplung

## 50-clean-code
- `skill-naming.md` — Namen als Vertrag: präzise, fachlich, nicht lügend
- `skill-function-design.md` — Funktionen: eine Aufgabe, ehrliche Signatur, explizite Effekte
- `skill-module-design.md` — Module: hohe Kohäsion, kleine Oberfläche, gerichtete Abhängigkeiten
- `skill-separation-of-concerns.md` — Logik, I/O und Darstellung trennen — dort, wo es Änderungen billiger macht
- `skill-abstraction-judgment.md` — Wann abstrahieren: Dreierregel, Kosten falscher Abstraktion
- `skill-complexity-control.md` — Komplexität budgetieren: essenziell vs. hausgemacht, Zustand minimieren
- `skill-readability.md` — Für den Leser optimieren: linearer Fluss, keine Überraschungen
- `skill-consistency.md` — Repo-Konvention schlägt Geschmack; Abweichung nur mit Migrationspfad

## 60-agentic-ai
- `skill-agent-orchestrator.md` — Viktor, der Dirigent: zerlegen, besetzen, briefen, prüfen, zusammenführen — nie selbst spielen
- `skill-agent-model-routing.md` — Kleinste zuverlässige Modellklasse je Paket; Risiko erzwingt Upgrade + Review; bindet 00-modelle
- `skill-agent-kontext-budget.md` — Briefing- und Rückgabeformat: minimaler Kontext, komprimierte Übergaben, Skills benennen statt einfügen
- `skill-agent-prompt-engineer.md` — Paula, die Präzisionsschmiedin: Aufträge in eindeutige, prüfbare, tokeneffiziente Briefings schmieden
- `skill-agent-rpg-coder.md` — Willi, der alte Hase: RPG alt & neu (**FREE, SQLRPGLE) im Bestandsstil, verifiziert statt vermutet
- `skill-agent-cl-spezialist.md` — Klara, die Operatorin: CL/CLLE, Jobsteuerung, MONMSG-Disziplin, Overrides und Bibliothekslisten im Griff
- `skill-agent-db2-analyst.md` — Erwin, der Datenhüter: DB2 for i — Schemaänderungen nur mit Where-used-Beleg, Migration rückwärtskompatibel
- `skill-agent-analyzer.md` — Ingrid, die Detektivin: Programm- und Störungsanalyse mit Fundstelle, Konkurrenzhypothesen, ohne Codeänderung
- `skill-agent-dokumentar.md` — Bruno, der Bibliothekar: nur Verifiziertes dokumentieren, Warum vor Was, für den Leser in 18 Monaten
- `skill-agent-reviewer.md` — Greta, die Prüferin: Risiko vor Stil, über den Diff hinaus, blockiert bei Produktions-/Datenrisiko
- `skill-agent-modernisierer.md` — Max, der Brückenbauer: fixed→free, DDS→DDL, OPM→ILE — verhaltenserhaltend, in beweisbaren Schritten
