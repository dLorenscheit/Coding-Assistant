# skill-implementation-planning

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Nicht-triviale Umsetzungen (> ~30 Min. Aufwand oder > 1 Datei) · **Empfohlene Einsatzkontexte:** Features, Bugfixes mit Umbauanteil, Refactorings

**Kurzfassung:** Bestand lesen, dann festlegen: Wo greife ich ein, was entsteht neu, wie beweise ich es — Nähte zwischen Neu und Alt zuerst durchdenken, Wiederverwendung prüfen, schwer Umkehrbares vorab freigeben lassen.

## Skill-Name

Implementierungsplanung

## Zweck

Zwischen „ich weiß, was gebraucht wird" (Anforderungsanalyse) und „ich tippe Code" liegt der Schritt, den Junioren am häufigsten überspringen: die konkrete technische Route festlegen. Wer ohne Plan codiert, trifft Architekturentscheidungen nebenbei, im Moment der geringsten Übersicht — mitten im Editor, unter dem Druck, dass es kompilieren soll. Dieser Skill macht die Entscheidungen **vor** dem Code, wo sie billig sind.

## Einsatzbereich

- Vor jeder Umsetzung, die mehr als eine Datei oder eine unklare Stelle berührt
- Nach `skill-requirements-analysis.md` (was/warum) und meist zusammen mit `skill-task-decomposition.md` (in welchen Schritten)
- Auch für Bugfixes, sobald der Fix mehr ist als eine Zeile — der Plan kann 5 Zeilen kurz sein
- Als Vorlage für Review durch Senior/Team, **bevor** Aufwand versenkt wird

## Denkweise

Denke wie ein Lotse: Bevor das Schiff ablegt, kennt er die Route, die Untiefen und die Stellen, an denen man umkehren kann. Der Plan ist keine Bürokratie — er ist die billigste Form, Fehler zu machen. Einen Plan wegzuwerfen kostet Minuten; eine halb fertige falsche Implementierung kostet Tage und hinterlässt oft Trümmer.

Für Junioren: Ein guter Plan beantwortet drei Fragen: **Wo greife ich ein** (welche Stellen im Bestand), **was entsteht neu** (Strukturen, Schnittstellen, Daten), **wie beweise ich, dass es stimmt** (Verifikationsstrategie). Wenn du eine der drei nicht beantworten kannst, bist du noch nicht bereit zu codieren — du würdest die Antwort im Code suchen, und das ist der teuerste Ort dafür.

## Kernregeln

**MUSS:**
1. Vor dem Plan den **Bestand lesen**: die betroffenen Stellen, ihre Aufrufer, vorhandene ähnliche Lösungen im Repo. Ein Plan auf Basis vermuteten Codes ist wertlos.
2. Der Plan benennt konkret: betroffene Dateien/Module, neue/geänderte Schnittstellen und Datenstrukturen, Migrationsbedarf, Verifikationsstrategie (welche Tests, welche manuelle Prüfung).
3. **Integrationspunkte zuerst durchdenken:** An welchen Nähten trifft Neues auf Altes? Dort entstehen 80 % der Überraschungen — diese Stellen im Plan explizit behandeln, nicht „ergibt sich".
4. Mindestens einmal fragen: **Gibt es im Repo/Team/Ökosystem schon eine Lösung dafür?** Vorhandenes wiederverwenden schlägt Neubau (Bibliothek prüfen, bevor Utility-Code entsteht).
5. Wenn der Plan eine schwer umkehrbare Entscheidung enthält (öffentliches API, DB-Schema, Technologiewahl): Entscheidung mit Alternativen und Begründung festhalten (siehe `skill-decision-records.md`) und ggf. freigeben lassen.

**SOLL:**
6. Plangröße dem Risiko anpassen: Routineänderung → 5 Zeilen Stichpunkte; Feature → halbe Seite; Migration → eigenes Dokument. Ein aufgeblasener Plan für Triviales ist genauso ein Fehler wie kein Plan für Kritisches.
7. Die gewählte Route gegen genau **eine** ernsthafte Alternative abwägen und in einem Satz begründen, warum nicht die Alternative. (Mehr Alternativen nur bei Architekturentscheidungen.)
8. Verifikationsstrategie vor dem Code festlegen: Welcher Test würde den Kern der Änderung beweisen? Wenn kein Test formulierbar ist, ist meist die Anforderung unklar → zurück zu `skill-requirements-analysis.md`.
9. Aufräumbedarf ehrlich einplanen: Wenn die Umsetzung ein kleines Vorab-Refactoring braucht, gehört das als eigener erster Schritt in den Plan — nicht als Überraschung in den Diff.

**KANN:**
10. Bei Unsicherheit über die Machbarkeit einer Route: kurzen Wegwerf-Spike vorschalten, Ergebnis in den Plan einarbeiten.
11. Den Plan vor Umsetzung von jemandem (Mensch oder stärkeres Modell) gegenlesen lassen — 10 Minuten Plan-Review ersetzen oft Stunden Code-Review.

## Arbeitsablauf

1. **Bestand erkunden:** Einstiegspunkte, Datenfluss, vorhandene Muster für Vergleichbares, Tests. Notieren, was einen überrascht hat — Überraschungen sind Planungsstoff.
2. **Zielstruktur skizzieren:** Welche Bausteine existieren nachher? Welche Schnittstellen ändern sich? Welche Daten fließen anders?
3. **Nähte bestimmen:** Jede Stelle, an der neuer Code Bestand berührt, einzeln benennen: Wie wird dort integriert, was kann dort brechen, wie wird es dort getestet?
4. **Route wählen:** Eine Alternative ernsthaft erwägen, Entscheidung begründen. Wiederverwendung geprüft?
5. **Verifikation planen:** Pro Kernverhalten einen Test benennen. Manuelle Prüfschritte für das, was Tests nicht abdecken.
6. **In Schritte schneiden:** Mit `skill-task-decomposition.md` — Risiko nach vorn, jeder Schritt lauffähig.
7. **Festhalten und ggf. freigeben lassen:** Plan dokumentieren. Bei schwer umkehrbaren Anteilen: Freigabe vor Umsetzung.

## Checkliste

- [ ] Habe ich den betroffenen Bestandscode wirklich gelesen (nicht nur Dateinamen)?
- [ ] Sind alle Nähte zwischen Neu und Alt benannt und durchdacht?
- [ ] Weiß ich für jedes Kernverhalten, welcher Test es beweist?
- [ ] Habe ich Wiederverwendung geprüft, bevor ich Neubau plane?
- [ ] Ist eine Alternative erwogen und die Wahl begründet?
- [ ] Sind schwer umkehrbare Entscheidungen als solche markiert (und freigegeben)?
- [ ] Ist der Plan so konkret, dass ein anderer Entwickler ihn umsetzen könnte?
- [ ] Steht Vorab-Refactoring (falls nötig) als eigener Schritt im Plan?

## Typische Fehler

- **Plan aus dem Gedächtnis:** Planen, wie der Code „wahrscheinlich aussieht", statt ihn zu lesen. Der Plan zerfällt beim ersten Dateiöffnen.
- **Happy-Path-Plan:** Nur den Erfolgsfall durchdenken. Fehlerpfade, Berechtigungen und Bestandsdaten tauchen erst im Code auf — und sprengen dann Aufwand und Design.
- **Nähte ignorieren:** Das Neue im Detail planen, die Integration mit „wird dann angeschlossen" abtun. Die Naht ist die Aufgabe.
- **Entscheidung im Editor:** Grundsatzfragen (Sync oder async? Neue Tabelle oder Spalte?) erst beim Tippen entscheiden — unter Druck, ohne Vergleich, ohne Doku.
- **Plan als Vertrag:** Am Plan festhalten, obwohl die Umsetzung ihn widerlegt hat. Ein Plan wird angepasst und die Anpassung kommuniziert — stures Abarbeiten ist keine Tugend.
- **NIH-Reflex (Not invented here):** Utility-Code neu schreiben, den eine etablierte Bibliothek (oder das eigene Repo, drei Ordner weiter) längst hat.

## Beispiele

**Kurzplan (angemessen für kleinen Fix):**
> Bug: Rabatt wird auf Versandkosten angewendet. Ort: `PriceCalculator.applyDiscount` behandelt `shippingCost` als Teil von `subtotal` (Zeile 84). Fix: Rabattbasis auf Artikelsumme begrenzen. Nähte: `InvoiceService` nutzt `applyDiscount` auch für Gutschriften — Verhalten dort gewollt gleich (mit PO geklärt). Verifikation: neuer Test „Rabatt 10 % auf 100 € Ware + 5 € Versand = 95 €-Rabattbasis", Bestands-Tests grün.

**Warnbeispiel:** Plan „Wir bauen einen NotificationService" ohne Blick in den Bestand — im Repo existiert bereits `MessageDispatcher`, der 80 % kann. Ergebnis ohne Bestandsanalyse: zwei konkurrierende Systeme, die das Team jahrelang parallel pflegt. Genau das verhindert Regel 1 und 4.

## Eskalation

Rückfrage/Freigabe einholen, bevor Code entsteht, wenn:

- der Plan ein öffentliches API, ein DB-Schema, Auth-/Zahlungslogik oder Datenlöschung ändert,
- die Bestandsanalyse zeigt, dass die Aufgabe ein größeres Vorab-Refactoring braucht (Aufwand ≠ Erwartung des Auftraggebers),
- zwei Routen vertretbar sind und die Wahl langfristige Folgen hat (Technologie, Datenmodell) — dann Entscheidungsvorlage statt stiller Wahl,
- die Verifikationsstrategie eine Lücke lässt, die nur mit Produktionsdaten oder -zugängen schließbar ist,
- der Plan während der Umsetzung in einem wesentlichen Punkt widerlegt wird — kurz melden und angepasst weiterarbeiten, nicht still umdisponieren.
