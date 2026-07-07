# skill-testing-strategy

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Entscheidung, was wie tief getestet wird · **Empfohlene Einsatzkontexte:** Neue Features, Bugfixes, Test-Nachrüstung, Test-Reviews

**Kurzfassung:** Verhalten testen, nicht Implementierung; Testtiefe nach Risiko (Geld, Daten, Sicherheit zuerst); jeder Bugfix bekommt den Test, der ihn gefunden hätte; ein flakiger Test ist ein Bug, kein Ärgernis.

## Skill-Name

Teststrategie

## Zweck

Tests sind kein Ritual, sondern die einzige skalierende Antwort auf die Frage „woher weißt du, dass es funktioniert — heute und nach der nächsten Änderung?". Dieser Skill hilft zu entscheiden, **was** getestet wird, **auf welcher Ebene** und **wie tief** — damit Testaufwand dort landet, wo Fehler wehtun, statt dort, wo Tests leicht zu schreiben sind.

## Einsatzbereich

- Testplanung für neue Features (idealerweise vor der Implementierung)
- Bugfixes (Reproduktionstest ist Pflicht)
- Nachrüsten von Tests in Legacy-Code (→ Charakterisierungstests, `skill-refactoring.md`)
- Bewertung vorhandener Testsuiten im Review (`skill-code-review.md`, Regel 8)

## Denkweise

Denke wie ein Versicherungsmathematiker: Testaufwand ist eine Prämie, Fehler sind der Schadensfall. Man versichert das Haus (Zahlungslogik, Datenintegrität) höher als den Gartenzwerg (Log-Formatierung). Die Frage ist nie „wie viel Coverage?", sondern: **Welcher unentdeckte Fehler wäre hier am teuersten — und welcher Test würde ihn fangen?**

Zweiter Grundsatz: **Ein Test prüft ein Versprechen, nicht eine Implementierung.** Guter Test: „Rabatt über 100 % wird abgelehnt." Schlechter Test: „Methode ruft `validateInternal` genau einmal auf." Der erste überlebt jedes Refactoring; der zweite bricht bei jedem und beweist nichts.

## Kernregeln

**MUSS:**
1. Testtiefe nach Risiko staffeln: Geld-, Daten-, Sicherheits- und Kerngeschäftslogik gründlich (inkl. Randfälle und Fehlerpfade); triviale Durchreich-Schichten und Framework-Funktionalität nicht doppelt testen.
2. Jeder Bugfix enthält den Test, der den Bug gefunden hätte — und dieser Test schlägt vor dem Fix fehl (belegt, nicht vermutet).
3. Verhalten von außen testen (Eingabe → beobachtbares Ergebnis), nicht innere Abläufe. Mocks nur an echten Systemgrenzen (DB, Netz, Uhr, Zufall), nicht zwischen eigenen Klassen.
4. Fehlerpfade und Randfälle explizit testen: leer, null, doppelt, zu groß, nicht berechtigt, Abbruch mittendrin. Der Happy Path allein prüft das Feature nicht.
5. Flakige Tests (mal grün, mal rot ohne Codeänderung) sofort behandeln: fixen oder in Quarantäne mit Ticket — nie per Retry „lösen" oder ignorieren. Eine Suite, der man nicht traut, ist wertlos.
6. Tests sind deterministisch und unabhängig: keine Abhängigkeit von Reihenfolge, echter Uhrzeit, Netz oder geteiltem veränderlichem Zustand.

**SOLL:**
7. Testpyramide pragmatisch: viele schnelle Unit-Tests für Logik, gezielte Integrationstests für Zusammenspiel (DB, Queries, Verträge), wenige E2E-Tests für die kritischen Nutzerpfade. Kein Dogma — Queries testet man z. B. sinnvoll nur gegen eine echte DB.
8. Testnamen beschreiben das Versprechen: `lehnt_rabatt_über_100_prozent_ab`, nicht `test_calc_3`. AAA-Struktur (Arrange–Act–Assert) einhalten.
9. Coverage als Lückenfinder nutzen, nicht als Ziel: 80 % mit Randfällen schlagen 95 % Happy-Path-Durchlauf. Ungetestete Zeilen anschauen: Ist da Risiko?
10. Testdaten sprechend und minimal: nur die Felder setzen, die der Fall braucht (Builder/Factories); der Leser muss sehen, welcher Wert den Testfall ausmacht.

**KANN:**
11. Property-based Tests für algorithmische Logik (Rundung, Parsing, Invarianten).
12. Contract-Tests, wo zwei Teams/Services einen Vertrag teilen.
13. Vor der Implementierung schreiben (TDD), wo die Anforderung klar ist — der rote Test ist die beste Anforderungsprüfung.

## Arbeitsablauf

1. **Risiko einstufen:** Was kostet ein Fehler hier? (Geld/Daten/Sicherheit → hoch.)
2. **Versprechen listen:** Welche prüfbaren Zusagen macht die Änderung? (Aus `skill-requirements-analysis.md`.)
3. **Ebene wählen:** Pro Versprechen die billigste Ebene, die es ehrlich prüft (Logik → Unit; Query/Mapping → Integration; kritischer Nutzerfluss → E2E).
4. **Randfälle ergänzen:** leer/null/doppelt/zu groß/verboten/Abbruch — bewusst entscheiden, welche gelten.
5. **Schreiben & rot sehen:** Neue Tests müssen erst fehlschlagen können (bei TDD automatisch; nachträglich: Implementierung kurz sabotieren).
6. **Suite pflegen:** Flakies sofort behandeln, langsame Tests optimieren oder verschieben, tote Tests löschen.

## Checkliste

- [ ] Testen die Tests Versprechen (Verhalten) statt Implementierung?
- [ ] Ist die Tiefe dem Risiko angemessen (kritisch = gründlich inkl. Fehlerpfade)?
- [ ] Hat jeder Bugfix seinen vorher-roten Reproduktionstest?
- [ ] Sind Randfälle explizit abgedeckt oder bewusst ausgeschlossen?
- [ ] Laufen die Tests deterministisch und unabhängig?
- [ ] Würde ein Refactoring ohne Verhaltensänderung die Tests grün lassen?
- [ ] Keine Mocks zwischen eigenen Klassen ohne Not?

## Typische Fehler

- **Coverage-Theater:** Tests, die Code ausführen, aber nichts Sinnvolles behaupten (`assert result != null`). Zahl gut, Schutz null.
- **Implementierungs-Spiegel:** Test prüft interne Aufrufe per Mock-Verify. Bricht bei jedem Refactoring, findet keinen echten Fehler.
- **Happy-Path-Suite:** 40 Tests, alle mit gültigen Daten. Produktion liefert die ungültigen.
- **Mock-Kaskade:** Alles gemockt außer der einen Zeile — getestet wird die Mock-Konfiguration.
- **Flaky-Toleranz:** „Der Test ist halt manchmal rot, einfach neu starten." Ab da drückt jeder bei echten Fehlern auf Retry.
- **Test nach Sichtbarem:** Getestet wird, was leicht testbar ist (Getter, DTOs), nicht was riskant ist (Preislogik, Nebenläufigkeit).
- **Bugfix ohne Test:** Der Bug kommt beim nächsten Umbau wieder — und niemand merkt es.

## Beispiele

**Gut (Priorisierung):** Feature „Gutschein einlösen". Risiko: Geld. Tests: Unit — Wertlogik inkl. Randfälle (abgelaufen, doppelt eingelöst, Betrag > Warenkorb, negativer Wert); Integration — Einlösung schreibt Verbrauch transaktional (Doppel-Klick-Szenario!); E2E — ein Pfad Checkout mit Gutschein. Kein Test für den Gutschein-DTO-Mapper (trivial, vom Compiler geprüft).

**Schlecht:** 25 Tests für Getter/Setter und Mapper (leicht), null Tests für die Doppel-Einlösung (schwer, aber genau da liegt das Geld).

## Eskalation

- Anforderung nicht prüfbar formulierbar → zurück zu `skill-requirements-analysis.md`, bevor Pseudo-Tests entstehen.
- Code strukturell untestbar (Logik untrennbar mit I/O/UI verwoben) → Refactoring-Bedarf melden (`skill-refactoring.md`), nicht mit Mock-Akrobatik überkleistern.
- Kritischer Pfad nur mit Produktionsdaten/-umgebung testbar → Risiko benennen und Freigabe für Testansatz einholen, nicht still ungetestet lassen.
- Suite dauerhaft langsam/flaky und blockiert das Team → als eigenes technisches Problem priorisieren lassen; das ist Infrastruktur, kein Nebenbei.
