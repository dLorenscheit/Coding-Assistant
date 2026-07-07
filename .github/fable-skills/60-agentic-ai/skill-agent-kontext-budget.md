# skill-agent-kontext-budget

**Version:** 1.0 · **Stand:** 2026-07-03 · **Gültigkeitsbereich:** Briefings, Übergaben und Rückgaben zwischen Agenten · **Empfohlene Einsatzkontexte:** Jede Delegation und jede Ergebnis-Weitergabe in Multi-Agent-Arbeit

**Kurzfassung:** Jedes Briefing enthält nur den minimal hinreichenden Kontext im Standardformat, jede Rückgabe nur Ergebnis/Annahmen/Verifikation/Nebenbefunde — Kontext ist Budget, kein Lager.

## Skill-Name

Kontext- und Token-Budget für Agenten-Übergaben

## Zweck

Multi-Agent-Arbeit scheitert selten an Fähigkeit und oft an Kontext-Müll: geflutete Briefings, verschleppte Verläufe, Rückgaben voller Herleitungen. Dieser Skill definiert die zwei Standardformate (Briefing und Rückgabe) und die Schnittregeln, mit denen Kontext klein, präzise und wiederverwendbar bleibt.

## Einsatzbereich

- Orchestrator → Agent: jedes Arbeitspaket-Briefing
- Agent → Orchestrator: jede Ergebnis-Rückgabe
- Agent → Agent (über den Orchestrator): jede Weitergabe von Zwischenergebnissen

## Denkweise

Denke wie ein Funker mit begrenzter Bandbreite: **Jedes übertragene Wort kostet — und jedes fehlende entscheidende Wort kostet mehr.** Die Kunst ist nicht Kürze um jeden Preis, sondern der minimal hinreichende Ausschnitt: alles, was der Empfänger für das Ziel braucht, und nichts darüber hinaus.

Mentales Modell: **Frachtbrief statt Umzugskarton.** Übergeben wird, was deklariert und adressiert ist — nicht der gesamte Hausstand, weil Aussortieren anstrengend war.

## Kernregeln

**MUSS:**
1. **Standard-Briefing, 5 Felder:** Ziel (1–3 Sätze, prüfbar) · Kontext (minimal) · Nicht-Ziele · Rückgabeformat · Modellklasse (mit Begründung, siehe `skill-agent-model-routing.md`).
2. **Kontext minimal schneiden:** Prozedur statt ganzes Member, DSPFFD-Auszug statt kompletter DDS, betroffene CL-Schritte statt ganzer Jobkette. Was der Agent für das Ziel nicht braucht, gehört nicht ins Briefing.
3. **Standard-Rückgabe, 4 Felder:** Ergebnis · Annahmen (explizit) · Verifikation (was ausgeführt, mit welchem Resultat) · Nebenbefunde (Notizen, keine Fixes). Keine Herleitungen, keine Skill-Zitate.
4. **Skills benennen statt einfügen:** Briefing nennt maximal 1–2 Skill-Dateien (Pfad); der Agent lädt selbst nach INDEX-Protokoll (Kurzfassung → Kernregeln → Checkliste).
5. **Komprimiert weitergeben:** Der nächste Agent erhält Ergebnis + tragende Annahmen des Vorgängers — nie den Verlauf oder den Rohbericht.
6. **Nichts doppelt:** Bereits übergebener Kontext wird referenziert („siehe Paket 1: DDL-Diff"), nicht wiederholt.

**SOLL:**
7. Quellcode per Fundstelle übergeben (Bibliothek/Quelldatei/Member, Prozedur, Zeilen), wenn der Agent selbst Lesezugriff hat — Volltext nur, wenn nicht.
8. Rückgabeformat je Pakettyp vorformulieren: Diff, Befundliste mit Fundstellen, DDL-Skript, Doku-Abschnitt.
9. Große Artefakte (Compile-Listings, Joblogs, Spoolfiles) filtern: nur Fehler-/Warnzeilen mit kurzem Umfeld weitergeben.

**KANN:**
10. Bei Serienpaketen ein Muster-Briefing einmal definieren und danach nur Deltas übergeben.

## Arbeitsablauf

1. Ziel und Nicht-Ziele formulieren (bei Unschärfe: `skill-agent-prompt-engineer.md`).
2. Kontext bestimmen: Was braucht der Empfänger zwingend? Fundstelle oder Ausschnitt wählen.
3. Rückgabeformat und Modellklasse eintragen.
4. Nach Erhalt der Rückgabe: auf die 4 Felder prüfen — fehlt Verifikation oder Annahmen, zurückgeben statt akzeptieren.
5. Vor Weitergabe an den nächsten Agenten: komprimieren, Referenzen statt Wiederholung.

## Checkliste

- [ ] Briefing vollständig (5 Felder) und Ziel prüfbar?
- [ ] Kontext minimal — nichts „zur Sicherheit" angehängt?
- [ ] Skills benannt statt einkopiert?
- [ ] Rückgabe vollständig (4 Felder), Annahmen explizit?
- [ ] Weitergabe komprimiert, keine Verlaufs-Schleppe?
- [ ] Referenzen statt Duplikate für bereits Übergebenes?

## Typische Fehler

- **Kontext-Hamstern:** „Alles anhängen, könnte relevant sein." Der Empfänger sucht die Nadel im selbstgebauten Heuhaufen.
- **Verlaufs-Schleppnetz:** Den kompletten bisherigen Dialog als Kontext mitgeben.
- **Format-Anarchie:** Jeder Agent berichtet anders — die Aggregation wird teurer als die Arbeit.
- **Skill-Kopieren:** Ganze Skill-Texte ins Briefing einfügen statt den Pfad zu nennen.
- **Über-Kompression:** Beim Kürzen die Annahmen streichen — die sind der wichtigste Teil der Rückgabe.

## Beispiele

**Gut:** Briefing an Willi — Ziel: „Prozedur getRabatt um Staffelpreise erweitern (Staffeln aus PREISSTAFFEL, prüfbar: 3 Preisstufen im Testaufruf korrekt)." Kontext: Prozedur (60 Zeilen), DSPFFD-Auszug PREISSTAFFEL, Aufruferliste (3 Programme). Nicht-Ziele: keine Format-Konvertierung des Members. Rückgabe: Diff + Annahmen + Compile-/Testnachweis. Klasse: Sonnet (Standard-Feature).

**Schlecht:** „Hier sind vier komplette Member (6.000 Zeilen) und unser bisheriger Chat — bau mal Staffelpreise ein."

## Eskalation

- Minimaler Kontext nicht bestimmbar, weil der Wirkradius unklar ist → erst Analyse-Paket an Ingrid (`skill-agent-analyzer.md`), nicht mehr Kontext raten.
- Agent meldet „Kontext reicht nicht" → gezielt nachliefern (die fehlende Stelle), nicht fluten.
- Rückgabe wiederholt unvollständig trotz Rückgabeformat → an Orchestrator: Briefing- oder Routing-Problem klären.
