# skill-clean-code-analysis

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Bewertung von Codequalität — praktisch statt dogmatisch · **Empfohlene Einsatzkontexte:** Qualitäts-Audits, Review-Vertiefung, Refactoring-Vorbereitung, Legacy-Bewertung

**Kurzfassung:** Jeden Befund als kosmetisch oder strukturell klassifizieren; strukturelle brauchen ein Schadensszenario; Priorität = Befund × Änderungshäufigkeit × Kritikalität; Empfehlungen als kleine Schritte plus Nicht-anfassen-Liste.

## Skill-Name

Clean-Code-Analyse (undogmatisch)

## Zweck

„Clean Code" ist kein Regelkatalog zum Abhaken, sondern eine Frage: **Wie teuer und wie riskant ist es, diesen Code zu verstehen und zu ändern?** Dieser Skill bewertet Code entlang dieser Frage — und unterscheidet dabei konsequent zwischen kosmetischen Auffälligkeiten (billig, harmlos) und echten Wartbarkeitsrisiken (teuer, gefährlich). Er verhindert beides: das Übersehen realer Risiken und den dogmatischen Kreuzzug gegen harmlosen, funktionierenden Code.

## Einsatzbereich

- Qualitätsbewertung von Modulen, Diffs oder ganzen Codebasen
- Priorisierung von Refactoring-Kandidaten (was zuerst, was nie)
- Faire Bewertung von Legacy-Code
- Zweite Ebene im Code-Review (nach Korrektheit/Sicherheit, siehe `skill-code-review.md`)

## Denkweise

Denke wie ein Bausachverständiger: Er unterscheidet zwischen abblätternder Farbe (kosmetisch, egal für die Statik) und Rissen im Fundament (unsichtbar für Laien, teuer bei Ignoranz). Sein Urteil hängt außerdem vom **Nutzungsprofil** ab: Eine Scheune wird anders bewertet als ein Krankenhaus.

Übertragen: Die Kosten schlechten Codes = **Änderungshäufigkeit × Verständnisaufwand × Fehlerrisiko**. Eine hässliche Funktion, die seit 6 Jahren stabil läuft und nie angefasst wird, ist ein niedrig priorisiertes Problem. Eine mittelmäßige Funktion im Modul, das jede Woche geändert wird, ist ein hoch priorisiertes. Junioren bewerten Code absolut („verstößt gegen Regel X"); Seniors bewerten ökonomisch („kostet uns real Y").

Zweiter Grundsatz: **Lesbarkeit ist messbar am Leser, nicht am Autor.** Der Test ist nicht „gefällt mir der Code?", sondern „kann ein neuer Teamkollege in 5 Minuten sagen, was diese Funktion tut, was sie voraussetzt und was sie verändert?"

## Kernregeln

**MUSS:**
1. Jede Auffälligkeit einer von zwei Klassen zuordnen: **kosmetisch** (Benennungsgeschmack, Formatierung, Zeilenlänge — stört, gefährdet nichts) oder **strukturelles Risiko** (verdeckte Seiteneffekte, implizite Abhängigkeiten, duplizierte Geschäftslogik, untestbare Verflechtung — erzeugt Bugs bei künftigen Änderungen). Nur die zweite Klasse rechtfertigt Aufwand und Nachdruck.
2. Bewertung immer im Kontext von Änderungshäufigkeit und Kritikalität: Vor dem Urteil klären (git log, Ticket-Historie, Nachfragen), wie oft und wie riskant dieser Code angefasst wird.
3. Für jedes benannte strukturelle Risiko das **konkrete Schadensszenario** angeben: „Wenn jemand künftig X ändert, übersieht er Y, weil Z versteckt ist." Kein Szenario benennbar → Einstufung als kosmetisch oder streichen.
4. Auf diese Risikomuster aktiv prüfen (die Kernliste, weil sie Folgefehler erzeugen): versteckte Seiteneffekte (Funktion tut mehr als Name/Signatur sagen), implizite Abhängigkeiten (globaler Zustand, Reihenfolge-Zwänge, „muss vorher aufgerufen werden"), duplizierte Geschäftslogik (zwei Stellen, eine Wahrheit), magische Werte mit Fachbedeutung, zu frühe Generalisierung (Abstraktion mit einem einzigen Nutzer), untestbare Verflechtung (Logik untrennbar mit I/O/UI/Zeit verwoben).
5. Legacy fair bewerten: Maßstab ist „macht die nächste Änderung sicherer oder gefährlicher", nicht „entspricht dem Lehrbuch von heute". Alter allein ist kein Befund.

**SOLL:**
6. Den 5-Minuten-Lesertest anwenden: Kann ein kundiger Fremder Zweck, Voraussetzungen und Effekte der Einheit in 5 Minuten korrekt wiedergeben? Wo genau scheitert er? Diese Stelle ist der Befund.
7. Testbarkeit als Qualitätsindikator lesen: Code, für den sich schwer ein Test schreiben lässt, hat fast immer ein strukturelles Problem (verdeckte Abhängigkeiten, gemischte Verantwortlichkeiten) — die Testschwierigkeit ist das Symptom, die Struktur die Ursache.
8. Kopplung und Kohäsion konkret prüfen statt als Schlagwort: Kopplung = „welche anderen Stellen muss ich anfassen/verstehen, wenn ich hier ändere?" Kohäsion = „gehören die Dinge in dieser Einheit wirklich zusammen, oder wohnen sie nur zufällig in einer Datei?"
9. Empfehlungen als priorisierte, kleine Schritte formulieren (was zuerst, was als Beifang bei nächster Änderung, was nie) — nicht als Generalsanierungs-Wunschliste.
10. Konsistenz höher gewichten als Idealform: Ein Repo mit einem durchgehaltenen mittelguten Muster ist wartbarer als eines mit drei konkurrierenden Idealmustern. Verbesserungsvorschläge müssen zum Bestand passen oder einen Migrationspfad nennen.

**KANN:**
11. Metriken (Funktionslänge, Verschachtelungstiefe, zyklomatische Komplexität) als **Hinweisgeber** nutzen — nie als Urteil. Eine 80-Zeilen-Funktion, die eine lineare Abfolge lesbar erzählt, ist besser als fünf 15-Zeilen-Funktionen, zwischen denen man springen muss.
12. Ein „Warum ist das so?"-Konto führen: Auffälligkeiten, die sich per git blame/Ticket als bewusste Entscheidung herausstellen, werden dokumentiert statt bemängelt.

## Arbeitsablauf

1. **Kontext klären:** Wie oft wird dieser Code geändert? Wie kritisch ist er (Geld, Daten, Sicherheit)? Das kalibriert die Messlatte.
2. **Lesertest:** Die Einheit lesen wie ein Neuer. Notieren, wo das Verständnis stockt und warum (Benennung? versteckter Effekt? Sprungdistanz?).
3. **Risikomuster abklopfen:** Die Kernliste aus Regel 4 systematisch durchgehen; Fundstellen notieren.
4. **Klassifizieren:** Jeden Befund als kosmetisch oder strukturell einordnen; strukturelle mit Schadensszenario.
5. **Ökonomisch gewichten:** Struktur-Befunde × Änderungshäufigkeit × Kritikalität → Priorität.
6. **Empfehlen:** 1–3 konkrete erste Schritte (klein, risikoarm, testbar), Beifang-Liste, Nicht-anfassen-Liste (stabil + selten geändert + Umbau teuer).

## Checkliste

- [ ] Ist jeder Befund als kosmetisch oder strukturell klassifiziert?
- [ ] Hat jeder strukturelle Befund ein konkretes Schadensszenario?
- [ ] Habe ich Änderungshäufigkeit und Kritikalität in die Priorität einbezogen?
- [ ] Habe ich die Risikomuster-Liste vollständig geprüft (Seiteneffekte, implizite Abhängigkeiten, Duplikate, Magie, Frühgeneralisierung, Untestbarkeit)?
- [ ] Ist Legacy am richtigen Maßstab gemessen (nächste Änderung, nicht Lehrbuch)?
- [ ] Sind meine Empfehlungen kleine, priorisierte Schritte statt einer Sanierungsutopie?
- [ ] Gibt es eine explizite Nicht-anfassen-Liste?

## Typische Fehler

- **Checklisten-Dogmatismus:** „Funktion > 20 Zeilen = Befund." Regeln aus Büchern sind Heuristiken; das Urteil gehört ans Schadensszenario, nicht an die Zahl.
- **Kosmetik-Fixierung:** Reviews und Audits, die zu 90 % aus Benennungs- und Formatfragen bestehen, während die duplizierte Preisberechnung in drei Modulen unerwähnt bleibt.
- **Sanierungsutopie:** „Das Modul müsste man komplett neu schreiben." Fast immer falsch: teuer, riskant, und das neue Modul hat in 5 Jahren dieselben Narben. Richtig: gezielte, kleine Verbesserungen an den änderungsintensiven Stellen.
- **Abstraktions-Frömmigkeit:** Jede Duplikation sofort wegabstrahieren wollen. Zwei ähnliche Stellen sind oft billiger als eine falsche Abstraktion — erst bei der dritten Wiederholung und stabilem Muster abstrahieren (siehe `skill-abstraction-judgment.md`).
- **Kontextblindes Urteil:** Den 10 Jahre alten Batch-Import an heutigen Frontend-Standards messen. Fair ist: Was war damals Standard, was kostet uns der Zustand heute konkret?
- **Cleverness mit Lesbarkeit verwechseln:** Ein Einzeiler mit dreifach verschachteltem Ternary ist „kurz", nicht „clean". Maßstab ist der Leser.

## Beispiele

**Strukturell (hohe Priorität):**
> `PriceCalculator.calc()` liest neben den Parametern auch `ConfigCache.Current` und schreibt bei bestimmten Kundentypen `customer.LastDiscountDate` (Seiteneffekt, im Namen unsichtbar). Schadensszenario: Wer die Funktion für eine Preisvorschau aufruft, verändert ungewollt Kundendaten — genau das ist 2025 laut Ticket PRC-88 schon passiert. Modul wird ~wöchentlich geändert. Empfehlung: Seiteneffekt herausziehen (eigener expliziter Schritt im Aufrufer), 2–3 h inkl. Tests.

**Kosmetisch (niedrige Priorität, ehrlich benannt):**
> Uneinheitliche Benennung `qty`/`quantity`/`amount` im selben Modul. Stört den Lesefluss, erzeugt aber keine Fehlentscheidungen. Beifang: beim nächsten Anfassen vereinheitlichen, kein eigenes Ticket.

**Nicht anfassen:**
> `LegacyCsvExporter` (800 Zeilen, eine Methode, seit 2019 unverändert, 0 Bugs, wird 1×/Jahr genutzt). Umbau kostet Tage, Nutzen ~0. Dokumentieren, in Ruhe lassen.

## Eskalation

- Wenn die Analyse **Korrektheitsprobleme** freilegt (die Duplikate berechnen unterschiedlich, der Seiteneffekt korrumpiert Daten): Das ist kein Clean-Code-Thema mehr — als Bug melden, Priorität nach `skill-bug-triage.md`.
- Wenn sinnvolle Verbesserung ein architekturelles Vorab-Refactoring erfordert (z. B. Logik aus der UI-Schicht lösen, bevor sie testbar wird): Aufwand und Nutzen als Entscheidungsvorlage an den Verantwortlichen — nicht eigenmächtig beginnen.
- Wenn Kritikalität/Änderungshäufigkeit nicht ermittelbar sind (kein Repo-Zugriff auf Historie, kein Ansprechpartner): Bewertung ausdrücklich als kontextfrei kennzeichnen — sie ist dann nur halb so viel wert, und das muss der Empfänger wissen.
- Bei Uneinigkeit im Team über einen Standard (z. B. Exceptions vs. Result-Typen): nicht pro Review neu austragen — Entscheidung herbeiführen und festhalten (`skill-decision-records.md`, `skill-consistency.md`).
