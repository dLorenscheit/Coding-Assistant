# skill-code-implementation

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Das eigentliche Schreiben von Code nach Plan · **Empfohlene Einsatzkontexte:** Features, Fixes, alle Umsetzungsarbeit

**Kurzfassung:** In kleinen, jederzeit lauffähigen Schritten arbeiten, Repo-Muster übernehmen, laufend verifizieren, Diff auf den Auftrag begrenzen — der Code ist fertig, wenn er bewiesen funktioniert, nicht wenn er kompiliert.

## Skill-Name

Code-Implementierung

## Zweck

Zwischen gutem Plan und gutem Ergebnis liegt die Disziplin der Umsetzung. Dieser Skill verhindert die typischen Umsetzungsfehler: große unlauffähige Zwischenstände, stilles Abweichen vom Plan, ungeprüfte „Fertig"-Meldungen und Diffs voller Beifang.

## Einsatzbereich

- Jede Umsetzung nach `skill-implementation-planning.md`
- Auch Kleinstaufgaben ohne formalen Plan — die Regeln gelten dort genauso
- Gemeinsam mit `skill-testing-strategy.md` (was beweist die Änderung) und `skill-error-handling.md` (Fehlerpfade)

## Denkweise

Denke wie ein Bergsteiger mit Zwischensicherungen: Nie weiter vom letzten funktionierenden Stand entfernt sein, als man bereit ist zu verlieren. Jeder kleine Schritt endet grün (Build + Tests); dann erst der nächste. Wer zwei Stunden ohne lauffähigen Zustand arbeitet, debuggt am Ende zwei Stunden auf einmal.

Zweiter Grundsatz: **Du schreibst Code in ein fremdes Haus.** Die Codebasis hat Konventionen, Muster und eine Geschichte. Dein Code soll aussehen, als hätte ihn das Team geschrieben — nicht wie ein Fremdkörper mit eigener Handschrift.

## Kernregeln

**MUSS:**
1. In kleinen Schritten arbeiten, nach denen Build und Tests grün sind. Roter Zustand ist ein Zwischenzustand von Minuten, nie von Stunden.
2. Bestehende Muster des Repos übernehmen (Fehlerbehandlung, Logging, Benennung, Struktur). Abweichung nur mit benanntem Grund — nicht aus Gewohnheit oder Trainingswissen.
3. Diff auf den Auftrag begrenzen: kein Drive-by-Refactoring, keine „Verschönerungen" fremder Stellen. Auffälliges als Nebenbefund notieren.
4. Fehlerpfade im selben Schritt implementieren wie den Happy Path — nicht als „mach ich am Ende" (am Ende ist nie).
5. „Fertig" heißt: Verifikation ausgeführt (Tests, Build, ggf. manueller Lauf) und Ergebnis berichtet. Kompiliert ≠ fertig.
6. Keine auskommentierten Codeblöcke, keine Debug-Ausgaben, keine TODO ohne Ticket im finalen Diff.

**SOLL:**
7. Vom Plan abweichen ist erlaubt — aber sichtbar: Abweichung kurz begründen und kommunizieren, nicht still umdisponieren.
8. Selbsterklärenden Code anstreben; Kommentare nur fürs Warum (siehe `skill-documentation-writing.md`, Regel 6).
9. Nach Fertigstellung den eigenen Diff einmal als Fremder lesen (Selbst-Review, `skill-code-review.md` Regel 7).
10. Namen und Struktur sofort richtig wählen statt „später aufräumen" — später konkurriert mit der nächsten Aufgabe und verliert.

**KANN:**
11. Bei unklarer API-Nutzung einen Mini-Test/REPL-Versuch machen statt gegen die Vermutung zu programmieren.
12. Schwierige Stellen zuerst grob („walking skeleton" der Funktion), dann verfeinern — solange jeder Commit grün ist.

## Arbeitsablauf

1. Plan/Schritt vornehmen, Fertig-Kriterium des Schritts klären.
2. Vorhandenes Muster für diese Art Aufgabe im Repo suchen und übernehmen.
3. Kleinsten sinnvollen Schritt implementieren — inklusive Fehlerpfad.
4. Verifizieren (Build/Tests), bei Grün committen oder Stand sichern.
5. Wiederholen bis Fertig-Kriterium erfüllt; Abweichungen vom Plan sichtbar machen.
6. Selbst-Review des Gesamt-Diffs, Aufräumen (Debug-Reste, tote Pfade), Bericht mit Verifikationsergebnis.

## Checkliste

- [ ] War ich nie länger als Minuten in rotem Zustand?
- [ ] Folgt der Code den Mustern des Repos?
- [ ] Sind Fehlerpfade implementiert und getestet?
- [ ] Enthält der Diff nur den Auftrag (kein Beifang, keine Debug-Reste)?
- [ ] Habe ich die Verifikation ausgeführt und wahrheitsgemäß berichtet?
- [ ] Habe ich Abweichungen vom Plan kommuniziert?

## Typische Fehler

- **Big-Bang-Session:** Drei Stunden tippen, dann „mal schauen ob's baut". Die Fehlersuche frisst die gesparte Zeit doppelt.
- **Eigene Handschrift:** Neues Fehlerbehandlungsmuster einführen, weil man es „besser" findet — jetzt hat das Repo zwei.
- **Happy-Path-first-und-only:** Fehlerpfade „kommen noch" — der PR geht ohne sie raus.
- **Beifang-Diff:** 12 Dateien angefasst, 3 gehören zum Auftrag. Review-Qualität sinkt, Regressionsrisiko steigt.
- **Kompiliert = fertig:** Fertigmeldung ohne ausgeführten Beweis.
- **Stilles Umplanen:** Der Plan sagte A, gebaut wurde B — niemand erfährt es bis zum Review.

## Beispiele

**Gut:** Schritt „Rabattvalidierung ergänzen": Muster für Validierung im Repo gesucht (`Validators/`-Konvention gefunden), Validator + Fehlerfall-Tests in einem Schritt, Tests grün, Commit. Bericht: „Validator nach Repo-Muster, 6 Tests grün, Nebenbefund: `OrderValidator` prüft E-Mail doppelt (nicht angefasst)."

**Schlecht:** Gleiche Aufgabe — Validator als neues, eigenes Framework-Muster gebaut, dabei `OrderValidator` „mitverbessert", Tests „laufen bestimmt", PR mit 14 Dateien.

## Eskalation

- Der Plan erweist sich in einem Kernpunkt als falsch (API kann X nicht, Datenmodell passt nicht) → melden, angepassten Plan vorschlagen, nicht still herumbauen.
- Die Umsetzung verlangt eine Entscheidung, die der Plan offen lässt und die Außenwirkung hat (Verhalten, Vertrag, Daten) → Rückfrage mit Empfehlung.
- Verifikation ist nicht möglich (kein Testsetup, keine Umgebung) und die Änderung ist nicht trivial → Zustand benennen, nicht ungeprüft liefern.
- Ein nötiges Vorab-Refactoring wächst über ~20 % des Aufgabenumfangs → stoppen, als eigenen Schritt vereinbaren.
