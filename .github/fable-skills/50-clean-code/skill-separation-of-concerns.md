# skill-separation-of-concerns

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Trennung von Zuständigkeiten in Code-Einheiten aller Größen · **Empfohlene Einsatzkontexte:** Implementierung, Reviews, Testbarkeits-Diagnosen, Legacy-Sanierung

**Kurzfassung:** Die drei Daueranliegen — Fachlogik, I/O (DB/Netz/Datei) und Darstellung — nicht in einer Einheit verweben: Getrennt wird, was sich unabhängig ändert oder unabhängig getestet werden muss; Trennung ist Mittel (billigere Änderungen, testbarer Kern), kein Schichten-Ritual.

## Skill-Name

Separation of Concerns

## Zweck

Der teuerste Mischcode ist der, in dem Geschäftsregeln untrennbar mit Datenbankzugriffen, HTTP-Details oder UI-Formatierung verwoben sind: Er ist nur noch als Ganzes testbar (also praktisch untestbar), und jede Änderung an einem Anliegen riskiert die anderen. Dieser Skill macht erkennbar, welche Anliegen in einer Einheit vermischt sind, wann das ein echtes Problem ist — und wie man mit kleinen Schnitten trennt, ohne in Schichten-Bürokratie zu verfallen.

## Einsatzbereich

- Neubau: Wo gehört welche Logik hin?
- Diagnose: „Warum ist das so schwer zu testen/ändern?"
- Legacy: Nähte finden, um Logik testbar herauszulösen (`skill-legacy-code-handling.md`, Regel 6)

## Denkweise

Frage pro Einheit: **„Aus wie vielen unabhängigen Gründen kann sich das hier ändern?"** Eine Methode, die Rabatt berechnet *und* SQL absetzt *und* HTML formatiert, ändert sich bei neuen Rabattregeln, bei DB-Umbauten und bei jedem Redesign — drei Änderungsströme kreuzen sich in einer Stelle, jeder gefährdet die anderen.

Das praktische Zielbild ist der **funktionale Kern mit imperativer Schale**: Innen reine Fachlogik (Daten rein, Entscheidung raus — trivial testbar), außen eine dünne Schale, die Daten beschafft, den Kern fragt und Effekte ausführt. Das ist keine Framework-Ideologie, sondern die billigste Struktur, die Testbarkeit und unabhängige Änderbarkeit liefert.

Und die Gegenwarnung: **Trennung hat Kosten** (Indirektion, mehr Dateien, Datenübergabe). Getrennt wird, wo Änderungsströme sich real kreuzen — nicht überall, wo ein Muster es vorschreibt.

## Kernregeln

**MUSS:**
1. Fachlogik nicht in I/O einweben: Geschäftsregeln (Berechnungen, Entscheidungen, Validierungsregeln) müssen ohne DB, Netz, Dateisystem und UI aufrufbar sein. Test-Diagnose: Braucht der Test einer Geschäftsregel eine Datenbank, ist die Trennung verletzt.
2. Darstellung raus aus der Logik: Formatierung (Währung, Datum, HTML, Spaltenbreiten) gehört an den Rand — eine Fachfunktion, die formatierte Strings zurückgibt, hat ihre Antwort für genau einen Konsumenten verheiratet.
3. Entscheiden und Ausführen trennen bei kritischen Abläufen: erst die Entscheidung berechnen (rein, testbar: „diese 3 Mails sind zu senden"), dann ausführen (Schale: senden). So sind alle Entscheidungsfälle testbar, ohne Effekte zu mocken.
4. Beim Neubau die Standard-Anliegen auseinanderhalten: Transport/Protokoll (HTTP, Queue), Validierung an der Grenze, Fachlogik, Persistenz, Darstellung. Sie dürfen in einer *Datei* wohnen, wenn das Modul klein ist — aber nie in einer *Funktion* verwoben sein.
5. Bei Änderungen den Mischgrad nicht erhöhen: In einer bereits vermischten Legacy-Stelle keine weitere Fachregel in den I/O-Teppich knüpfen — neuen Code getrennt anbauen und dünn anschließen (Sprout, `skill-legacy-code-handling.md`).

**SOLL:**
6. Querschnitts-Anliegen (Logging, Berechtigungen, Transaktionen, Retry) an Rahmen/Dekorator/Middleware geben statt in jede Fachfunktion zu kopieren — einmal richtig statt 50-mal fast richtig.
7. Trennung entlang echter Änderungsströme, nicht entlang von Musterkatalogen: Ein internes 3-Formulare-Tool braucht keine sechs Schichten; ein Berechnungskern mit 40 Regeln braucht zwingend seine Reinheit.
8. Datenbeschaffung nach oben ziehen: Funktionen bekommen Daten, statt sie sich zu holen — je tiefer im Callstack I/O steckt, desto größer der Testaufwand für alles darüber (`skill-function-design.md`, Regel 3).
9. Die Schale dünn und langweilig halten: beschaffen, delegieren, ausführen — keine versteckten Fachregeln in Controllern, Handlern, Mappern („nur ein kleines if" ist der Anfang vom Ende).

**KANN:**
10. In kleinen Skripten/Prototypen bewusst mischen — mit Wegwerf-Etikett. Die Trennung kommt, wenn das Skript Produktionsverantwortung bekommt (und das entscheidet man aktiv, nicht durch Verschleppen).
11. Als Lesehilfe in Bestandscode die Anliegen farblich/kommentarisch markieren („// I/O", „// Regel") — macht den Mischgrad sichtbar und die Schnittlinien offensichtlich.

## Arbeitsablauf

1. **Anliegen inventarisieren:** Welche der Standard-Anliegen (Transport, Validierung, Fachlogik, Persistenz, Darstellung, Querschnitt) stecken in der Einheit?
2. **Änderungsströme prüfen:** Welche davon ändern sich real unabhängig (Historie!)? Nur dort ist Trennung Pflicht.
3. **Kern identifizieren:** Die Entscheidungslogik benennen, die rein sein könnte (Daten rein → Ergebnis raus).
4. **Kleinsten Schnitt machen:** Kern als reine Funktion herauslösen, Schale beschafft und führt aus. Kein Schichten-Neubau — ein Schnitt pro Anliegen-Paar.
5. **Testbarkeit verifizieren:** Kern ohne Mocks testbar? Wenn nein, hängt noch I/O drin — zurück zu 4.

## Checkliste

- [ ] Sind Geschäftsregeln ohne DB/Netz/UI aufrufbar und testbar?
- [ ] Ist Formatierung/Darstellung am Rand statt in der Logik?
- [ ] Ist bei kritischen Abläufen Entscheiden von Ausführen getrennt?
- [ ] Sind Querschnitts-Anliegen zentral statt kopiert?
- [ ] Ist die Schale dünn (keine versteckten Fachregeln in Controllern/Handlern)?
- [ ] Habe ich nur getrennt, wo Änderungsströme sich real kreuzen (keine Ritual-Schichten)?
- [ ] Erhöht meine Änderung den Mischgrad nicht?

## Typische Fehler

- **Der 800-Zeilen-Handler:** HTTP-Parsing, Validierung, drei Geschäftsregeln, SQL und HTML-Aufbau in einer Methode — jede Änderung ist Operation am offenen Herzen, Tests unmöglich.
- **Logik im Template/Report:** Preisberechnung im HTML-Template oder im SQL des Reports — unauffindbar, dupliziert sich, weicht irgendwann von der „echten" Regel ab.
- **Schichten-Theater:** Sieben Projekte, Interfaces für alles, Mapper zwischen identischen DTOs — und die Fachregeln stecken trotzdem im Controller. Trennung nach Ritual statt nach Anliegen.
- **SQL als Fachlogik-Versteck:** Geschäftsregeln in Views/Prozeduren, die der Code-Leser nie sieht (klassisch in Legacy-Landschaften — beim Analysieren dort *auch* suchen, `skill-legacy-code-handling.md`, Regel 10).
- **Fachregel im Mapper:** „Beim Mappen setzen wir den Status gleich richtig" — die Regel wohnt jetzt da, wo niemand sie sucht.
- **Effekt im Kern:** Die „reine" Berechnungsfunktion schickt bei Grenzfall X schon mal eine Warn-Mail. Ab jetzt braucht jeder Test einen Mail-Mock.

## Beispiele

**Entscheiden/Ausführen getrennt:**
```csharp
// Kern (rein, 12 Testfälle ohne einen Mock):
List<DunningAction> DecideDunning(IReadOnlyList<Invoice> overdue, DunningPolicy policy, DateTime today)

// Schale (dünn, ein Integrationstest):
var actions = DecideDunning(repo.LoadOverdue(), policy, clock.Today);
foreach (var a in actions) mailer.Send(a);
```
Neue Mahnregeln = neue Testfälle am Kern; Mail-Provider-Wechsel = nur Schale. Zwei Änderungsströme, zwei Orte.

**Kleinster Schnitt in Legacy:** Statt den 800-Zeilen-Handler zu zerlegen: die eine zu ändernde Rabattregel als reine Funktion `IsDiscountEligible(...)` herausziehen (Sprout), Handler ruft sie auf. Der Handler bleibt hässlich — aber die Regel ist testbar und die Änderung sicher.

## Eskalation

- Kern lässt sich nicht herauslösen, weil Datenbeschaffung und Entscheidung sich abwechseln (Laden → Entscheiden → Nachladen → …) → Designfrage: Datenmodell für die Entscheidung klären; ggf. Vorab-Refactoring als Arbeitspaket (`skill-implementation-planning.md`, Regel 9).
- Fachregeln in DB-Objekten (Views/Prozeduren/Trigger) verteilt → Verlagerungsentscheidung mit DB-Verantwortlichen und Konsumenten-Analyse (`skill-change-impact-analysis.md`) — nicht still umziehen.
- Team-Streit „wie viele Schichten" → auf Änderungsströme und Testbarkeit zurückführen (messbare Kriterien) statt Musterkataloge zu vergleichen; Ergebnis festhalten (`skill-decision-records.md`).
