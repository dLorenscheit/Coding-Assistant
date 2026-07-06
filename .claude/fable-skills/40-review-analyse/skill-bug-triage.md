# skill-bug-triage

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Bewertung und Einordnung gemeldeter Fehler vor der Bearbeitung · **Empfohlene Einsatzkontexte:** Bug-Eingang, Support-Eskalationen, Vorfalls-Nachlese, Backlog-Pflege

**Kurzfassung:** Erst verstehen, dann einordnen, dann erst fixen: Reproduzierbarkeit und echten Impact klären (wer, wie oft, wie schlimm, Workaround?), Schwere von Dringlichkeit trennen, Duplikate und Muster erkennen — Triage entscheidet über Reihenfolge, nicht über Schuld.

## Skill-Name

Bug-Triage

## Zweck

Nicht jeder gemeldete Fehler ist ein Fehler, nicht jeder Fehler ist dringend, und der lauteste Melder hat nicht automatisch das größte Problem. Triage ist das Sortierwerk zwischen Meldung und Bearbeitung: Sie stellt sicher, dass die knappe Fix-Kapazität beim größten Schaden landet, dass Meldungen vollständig genug sind, um bearbeitbar zu sein, und dass Muster (fünf Meldungen, eine Ursache) erkannt werden, bevor fünf Leute parallel graben.

## Einsatzbereich

- Eingehende Bugmeldungen (Nutzer, Support, Monitoring, Team)
- Priorisierungsrunden über dem Bug-Backlog
- Erste Bewertung bei Vorfällen (Sofortmaßnahme nötig oder einplanbar?)

## Denkweise

Denke wie die Triage-Stelle einer Notaufnahme: Nicht wer am lautesten klagt, kommt zuerst dran, sondern wer am kritischsten ist — und dafür braucht es pro Fall wenige gezielte Befunde statt einer Vollduntersuchung. Triage ist bewusst **flach und schnell**: einordnen, nicht diagnostizieren. Die Tiefenanalyse (`skill-debugging.md`, `skill-root-cause-analysis.md`) kommt nach der Einordnung, für die Fälle, die sie verdienen.

Zwei getrennte Achsen, die Junioren fast immer vermischen: **Schwere** (wie schlimm ist der Schaden, wenn es auftritt) und **Häufigkeit/Reichweite** (wie viele trifft es wie oft). Ein Absturz, den ein Nutzer mit absurdem Sonderweg erzeugt: hohe Schwere, minimale Reichweite. Ein Rundungsfehler von 1 Cent auf jeder Rechnung: kleine Schwere, totale Reichweite — und vermutlich der wichtigere Bug. Priorität = Schwere × Reichweite ÷ Workaround-Qualität.

## Kernregeln

**MUSS:**
1. Jede Meldung auf Bearbeitbarkeit prüfen: Was wurde beobachtet, was wurde erwartet, Schritte dahin, Umgebung/Version, betroffene Daten/IDs, Zeitpunkt. Fehlt Wesentliches: gezielt nachfordern — eine unbearbeitbare Meldung einzuplanen ist Selbstbetrug.
2. Erwartung validieren: Ist das beschriebene Soll-Verhalten wirklich das vereinbarte? Manche „Bugs" sind Featurewünsche oder Missverständnisse — die Unterscheidung entscheidet den weiteren Weg (`skill-requirements-analysis.md`).
3. Impact belegen statt schätzen: Wie viele Betroffene (Logs/Metriken zählen, nicht raten), welcher Schaden (Datenverlust? Geld? Ärger?), gibt es einen Workaround und wie zumutbar ist er?
4. Schwere und Reichweite getrennt erfassen und daraus die Priorität ableiten — nicht aus der Lautstärke des Melders oder der Reihenfolge des Eingangs.
5. Sofort-Eskalationsklasse erkennen: Datenverlust im Gange, Sicherheitslücke, falsche Geldbeträge nach außen, Totalausfall → aus der Triage direkt in die Vorfallsbehandlung (Stabilisierung vor Analyse), nicht ins Backlog.
6. Vor dem Einplanen auf Duplikate/Muster prüfen: Gleiche Symptomklasse schon gemeldet? Mehrere Meldungen seit demselben Release? Verknüpfen statt parallel bearbeiten lassen.

**SOLL:**
7. Reproduzierbarkeit grob klassifizieren (immer / unter Bedingungen / sporadisch / einmalig) — sie bestimmt den Bearbeitungsansatz und die Aufwandserwartung. Bei „einmalig, kein Schaden, nicht reproduzierbar": beobachten statt graben (Ticket mit Beobachtungsauftrag).
8. Zeitliche Korrelation als Erstbefund mitgeben: „seit Release X / seit Config-Änderung Y" — die halbe Diagnose für den späteren Bearbeiter (`skill-debugging.md`, Regel 8).
9. Die Triage-Entscheidung kurz begründen (ein Satz: Impact, Workaround, Einordnung) — damit die Priorisierung überprüfbar bleibt und der Melder eine ehrliche Antwort bekommt.
10. Alte Low-Priority-Bugs periodisch ehrlich behandeln: Was in zwei Jahren nie hochpriorisiert wurde, wird geschlossen („wird nicht behoben" ist eine legitime, ehrliche Entscheidung) statt als ewige Karteileiche Aufmerksamkeit zu kosten.

**KANN:**
11. Bei Häufungen eine Muster-Hypothese notieren („5 Meldungen, alle mit Sonderzeichen im Namen") — Startpunkt für die Ursachensuche.
12. Support mit einer Meldungs-Vorlage ausstatten (Pflichtfelder aus Regel 1) — Triage-Qualität beginnt beim Eingang.

## Arbeitsablauf

1. **Vollständigkeit prüfen:** bearbeitbar? Sonst gezielt nachfordern.
2. **Sofortklasse ausschließen:** Datenverlust/Sicherheit/Geld/Ausfall → Vorfallsweg.
3. **Einordnen:** Bug oder Erwartungs-/Featurethema?
4. **Impact belegen:** Reichweite zählen, Schaden benennen, Workaround bewerten.
5. **Duplikate/Muster prüfen,** zeitliche Korrelation notieren.
6. **Priorisieren und begründen;** Melder-Rückmeldung; ggf. Beobachtungsauftrag statt Bearbeitung.

## Checkliste

- [ ] Ist die Meldung bearbeitbar (beobachtet/erwartet/Schritte/Umgebung)?
- [ ] Sofort-Eskalationsklasse geprüft?
- [ ] Ist es ein Bug (vereinbartes Soll verletzt) — oder Erwartung/Feature?
- [ ] Impact belegt (gezählt, nicht gefühlt) inkl. Workaround-Bewertung?
- [ ] Schwere und Reichweite getrennt bewertet?
- [ ] Duplikate und zeitliche Korrelation geprüft?
- [ ] Entscheidung in einem Satz begründet?

## Typische Fehler

- **Lautstärke-Priorisierung:** Der Bug des präsentesten Stakeholders überholt den stillen Rundungsfehler, der alle betrifft.
- **Triage als Tiefenanalyse:** Pro Meldung zwei Stunden debuggen — der Stapel wächst schneller als die Sortierung. Einordnen heißt nicht lösen.
- **„Kann ich nicht reproduzieren" = geschlossen:** Ohne Beobachtungsauftrag und ohne Log-Prüfung. Sporadische Bugs sind oft die gefährlichsten (Nebenläufigkeit, Last).
- **Schwere/Reichweite verschmolzen:** Der spektakuläre Einzelfall-Crash bekommt P1, der flächendeckende leise Datenfehler P3.
- **Duplikat-Blindheit:** Drei Personen debuggen drei Tickets mit einer Ursache.
- **Ewiges P4:** Hunderte nie-bearbeitete Alt-Bugs, die jede Backlog-Sicht verstopfen und Meldern falsche Hoffnung machen.
- **Bug-Etikett auf Featurewunsch:** „Das System sollte doch eigentlich…" ungeprüft als Defekt einplanen — die Fix-Arbeit landet dann im Anforderungsnebel.

## Beispiele

**Gut:** Meldung „Export stürzt ab". Triage: Nachgefordert: Fehlermeldung + Datei. Befund: tritt bei Dateien > 50 MB auf (Logs: 12 Vorkommen, 4 Kunden, seit Release 3.2), Workaround: Aufteilen der Datei (zumutbar, dokumentiert). Einordnung: Schwere mittel (Abbruch, kein Datenverlust), Reichweite klein, Workaround ok, Korrelation Release 3.2 notiert → P2 mit Diagnose-Startpunkt. Melder informiert inkl. Workaround.

**Gut (Sofortklasse):** Meldung „Kunde sieht fremde Rechnung" → keine Backlog-Diskussion: Sicherheitsklasse, sofort eskaliert (`skill-security-review.md`), Reichweite parallel per Logs geklärt.

**Schlecht:** „Klingt nach Randfall, P3" — ohne Logs zu zählen. Später: betraf jeden zehnten Login.

## Eskalation

- Sofortklasse (Datenverlust, Sicherheit, Geld nach außen, Ausfall) → direkt an Vorfallsprozess/Verantwortliche, Stabilisierung vor allem anderen.
- Impact nicht belegbar, weil Beobachtbarkeit fehlt (keine Logs/Metriken für den Bereich) → Beobachtbarkeits-Lücke als eigenes Arbeitspaket melden; Entscheidung unter Unsicherheit als solche kennzeichnen.
- Melder und Fachbereich uneins über das Soll-Verhalten → Klärung als Anforderungsfrage an den Product Owner, Bug-Ticket pausieren.
- Häufung nach Release ohne erkennbare Ursache → Release-Verantwortliche informieren; ggf. Rollback-Entscheidung vorbereiten, nicht abwarten bis der Stapel wächst.
