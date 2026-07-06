# skill-code-review

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Jede Begutachtung fremder (oder eigener) Änderungen vor Merge · **Empfohlene Einsatzkontexte:** Pull Requests, Diffs, Patch-Reviews, Review der Arbeit kleinerer Modelle

**Kurzfassung:** Absicht verstehen, über den Diff hinaus lesen (Aufrufer, Duplikate), Befunde belegen und als CRITICAL/HIGH/MEDIUM/LOW einstufen, Stil strikt von Risiko trennen — Korrektheit > Sicherheit > Wartbarkeit > Stil.

## Skill-Name

Code-Review

## Zweck

Ein Review hat genau eine Hauptaufgabe: **Schaden verhindern, bevor er in den Hauptzweig gelangt** — Bugs, Sicherheitslücken, Datenverlust, Wartbarkeitsfallen. Alles andere (Stil, Geschmack, Lerneffekt) ist nachgeordnet. Dieser Skill sorgt dafür, dass Reviews systematisch statt oberflächlich ablaufen, dass Risiko von Geschmack getrennt wird und dass Feedback so formuliert ist, dass es angenommen werden kann.

## Einsatzbereich

- Pull Requests und Patches jeder Größe
- Review von Code, den KI-Modelle erzeugt haben (dort besonders: plausibel aussehender, ungeprüfter Code)
- Selbst-Review des eigenen Diffs vor Abgabe (Pflicht, siehe Kernregeln)
- **Nicht** für Architektur-Grundsatzfragen — die gehören in ein Plan-Review vor der Umsetzung; im Code-Review sind sie meist zu spät

## Denkweise

Denke wie ein Lotse, der ein Schiff in den Hafen bringt: Du musst nicht jede Schraube prüfen, aber du musst wissen, wo die Felsen liegen. Die zentrale Frage ist nie „Hätte ich das so geschrieben?", sondern: **„Was ist das Schlimmste, das dieser Diff in Produktion anrichten kann — und wie wahrscheinlich ist es?"**

Zweites Prinzip: **Der Diff lügt durch Auslassung.** Die gefährlichsten Fehler stehen nicht in den geänderten Zeilen, sondern in den nicht geänderten: der Aufrufer, der die neue Semantik nicht kennt; die zweite Stelle, die dieselbe Logik dupliziert und nicht mitgeändert wurde; der Randfall, für den kein Test dazukam. Wer nur den Diff liest, reviewt die halbe Änderung.

Prioritätsordnung, immer: **Korrektheit > Sicherheit > Datenintegrität > Wartbarkeit > Performance > Stil.** Und: Korrektheit vor Eleganz, Verständlichkeit vor Cleverness.

## Kernregeln

**MUSS:**
1. **Zuerst die Absicht verstehen:** Ticket/Beschreibung lesen, dann fragen: Löst der Diff das? Ein technisch sauberer Diff, der das falsche Problem löst, wird abgelehnt.
2. **Über den Diff hinaus lesen:** Für jede geänderte Funktion mindestens die Aufrufer prüfen (ändert sich Vertrag/Semantik?) und nach Duplikaten der geänderten Logik suchen.
3. **Jeden Befund einstufen:** CRITICAL (Sicherheit/Datenverlust — blockiert), HIGH (Bug/erhebliches Qualitätsproblem — soll vor Merge gefixt werden), MEDIUM (Wartbarkeit — Hinweis), LOW (Stil — optional). Keine ungewichtete Anmerkungsliste.
4. **Stilfragen von Risiken trennen:** Was reine Präferenz ist, wird als solche gekennzeichnet („Geschmackssache, kein Blocker") oder weggelassen. Ein Review, das 20 Stil-Nits und den einen echten Bug gleichrangig listet, versteckt den Bug.
5. **Behauptungen belegen:** „Das kann eine Race Condition geben" nur mit konkretem Szenario (welche zwei Abläufe, welcher gemeinsame Zustand). Bauchgefühl wird als Frage formuliert, nicht als Befund.
6. **Sicherheits-Checkliste bei einschlägigen Diffs:** Bei Auth, Nutzereingaben, DB-Queries, Dateipfaden, externen Aufrufen, Krypto, Zahlungen immer explizit prüfen: Injection, fehlende Berechtigungsprüfung, Secrets im Code, ungeprüfte Eingaben, Fehlermeldungen mit sensiblen Daten.
7. **Selbst-Review vor Abgabe:** Den eigenen Diff einmal komplett so lesen, als käme er von einem Fremden — bevor man ihn anderen gibt.

**SOLL:**
8. Tests mitreviewen: Prüfen die Tests die Anforderung — oder spiegeln sie nur die Implementierung? Fehlt der Test, der genau den Bug gefunden hätte, den der Diff fixt?
9. Fehlerpfade gezielt lesen: Was passiert bei Exception mitten im Ablauf, bei Timeout, bei leerer Menge, bei doppelter Ausführung? Der Happy Path ist selten das Problem.
10. Feedback als begründete Aussage mit Vorschlag formulieren: Was ist das Problem, warum ist es eins, was wäre ein gangbarer Fix. Fragen stellen, wo man unsicher ist.
11. Bei Legacy-Umfeld fair bleiben: Der Diff wird am Kontext gemessen, nicht am Idealbild. Verlangt wird, dass er nichts verschlechtert und seine unmittelbare Umgebung nicht verwahrlosen lässt — nicht, dass er das Modul saniert.
12. Umfang ansprechen: Diffs > ~400 Zeilen sinken messbar in der Review-Qualität. Große Diffs um Aufteilung bitten — oder gezielt die riskanten Teile tief und den Rest kursorisch reviewen und das offenlegen.

**KANN:**
13. Positives benennen, wo es echt ist — besonders bei Junioren: gute Testidee, saubere Zerlegung. Das kalibriert, was erwünscht ist.
14. Bei wiederkehrenden Mustern (dritter PR mit demselben Problem) das Muster adressieren statt der Instanz: Checkliste, Lint-Regel, kurzes Gespräch.

## Arbeitsablauf

1. **Kontext:** Ticket/Beschreibung lesen. Was soll das? Woran erkennt man Erfolg?
2. **Überblick:** Dateiliste ansehen. Passt der Umfang zur Aufgabe? Überraschende Dateien im Diff? (Geänderte Config, Migrationen, Lockfiles bewusst wahrnehmen.)
3. **Kernpfad tief lesen:** Die fachliche Kernänderung Zeile für Zeile, mit Blick auf Korrektheit und Randfälle. Aufrufer und Duplikate außerhalb des Diffs prüfen.
4. **Risikofelder abklopfen:** Fehlerpfade, Nebenläufigkeit, Transaktionen, Berechtigungen, Eingabevalidierung, Ressourcen-Freigabe, Migrationen (rückwärtskompatibel?).
5. **Tests bewerten:** Abdeckung der Anforderung, nicht der Zeilen. Fehlt ein offensichtlicher Fall?
6. **Befunde einstufen und formulieren:** Nach Schweregrad sortiert, belegt, mit Vorschlag. Stil-Nits bündeln oder streichen.
7. **Urteil fällen:** Approve / Approve mit Auflagen / Änderungen nötig / Blockiert (CRITICAL). Das Urteil muss aus den Befunden folgen.

## Checkliste

- [ ] Habe ich verstanden, was der Diff erreichen soll — und tut er das?
- [ ] Habe ich Aufrufer und Logik-Duplikate außerhalb des Diffs geprüft?
- [ ] Sind Fehlerpfade, Randfälle und doppelte Ausführung durchdacht?
- [ ] Bei einschlägigen Diffs: Security-Punkte explizit geprüft?
- [ ] Migrationen/Schema-Änderungen rückwärtskompatibel bzw. rückrollbar?
- [ ] Prüfen die Tests die Anforderung (nicht die Implementierung)?
- [ ] Jeder Befund eingestuft, belegt, mit Vorschlag?
- [ ] Stil sauber von Risiko getrennt?
- [ ] Folgt mein Urteil aus meinen Befunden?

## Typische Fehler

- **Nit-Picking als Gründlichkeitsersatz:** 15 Anmerkungen zu Benennung und Leerzeilen, aber die fehlende Berechtigungsprüfung übersehen. Oberfläche prüfen fühlt sich produktiv an — ist es nicht.
- **Nur den Diff lesen:** Die Semantikänderung ist im Diff korrekt, bricht aber einen von 12 Aufrufern. Der steht nicht im Diff.
- **LGTM aus Müdigkeit:** Große Diffs winkt man eher durch als kleine — genau falsch herum. Wenn keine Zeit für echtes Review ist: sagen, nicht so tun.
- **Design-Grundsatzdebatte im PR:** Die Architektur hätte im Plan-Review diskutiert gehört. Im PR blockiert sie fertige Arbeit — Anmerkung als Follow-up festhalten, nicht den Merge davon abhängig machen (außer es ist ein echtes Risiko).
- **Urteil ohne Beleg:** „Das ist nicht performant" ohne Zahl, Szenario oder Messung. Erst belegen oder als Frage stellen.
- **Eigenes Idealbild als Maßstab:** Umschreiben verlangen, bis es aussieht wie der eigene Code. Maßstab ist: korrekt, sicher, wartbar, konsistent mit dem Repo.
- **KI-Code zu gutgläubig reviewen:** Modell-generierter Code sieht überdurchschnittlich sauber aus — das Fehlerprofil liegt bei erfundenen Annahmen, nicht existenten APIs und unpassenden Randfallentscheidungen. Dort gezielt hinsehen.

## Beispiele

**Befund gut formuliert (HIGH):**
> `OrderService.cs:142` — `SaveOrder` und `ReserveStock` laufen in getrennten Transaktionen. Wenn `ReserveStock` fehlschlägt (z. B. Timeout), existiert eine Bestellung ohne Reservierung; der Nachtjob storniert die nicht. Vorschlag: beide in eine Transaktion ziehen oder Bestellung mit Status `pending` anlegen und erst nach Reservierung aktivieren. HIGH, weil real auftretender Timeout = inkonsistente Daten.

**Derselbe Befund schlecht formuliert:**
> „Transaktionshandling anschauen." — Kein Ort, kein Szenario, keine Einstufung, kein Vorschlag. Der Autor kann damit nichts anfangen.

**Stil korrekt einsortiert:**
> „LOW/Geschmack: `tmp` → `pendingInvoices` fände ich lesbarer. Kein Blocker."

## Eskalation

- **CRITICAL-Befund** (Sicherheitslücke, Datenverlustrisiko, Secrets im Code): Merge blockieren, Autor direkt informieren; bei bereits gemergten Fällen sofort Menschen/Security einschalten und ggf. Secrets rotieren.
- **Unsicherheit bei Spezialgebieten** (Krypto, Nebenläufigkeit, rechtliche Anforderungen): nicht freigeben „im Zweifel", sondern gezielt Fachperson oder tieferes Modell hinzuziehen — mit konkreter Frage.
- **Fundamentaler Design-Dissens:** Nicht im PR-Kommentarkrieg austragen. Kurz synchron klären (oder Entscheidungsvorlage), Ergebnis als Entscheidung festhalten.
- **Wiederholt mangelhafte Einreichungen derselben Quelle** (Mensch oder Modell): Muster dokumentieren und ans Team/den Betreiber zurückspielen — das ist ein Prozessproblem, kein Review-Problem.
- **Zeitdruck-Merge-Wunsch trotz HIGH-Befund:** Risiko und Konsequenz schriftlich festhalten, Entscheidung explizit dem Verantwortlichen überlassen. Nie still nachgeben.
