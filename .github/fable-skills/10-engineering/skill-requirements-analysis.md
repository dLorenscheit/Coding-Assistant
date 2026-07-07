# skill-requirements-analysis

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Jede Aufgabe, bevor die erste Zeile Code entsteht · **Empfohlene Einsatzkontexte:** Features, Bugfixes, Änderungswünsche, Ticket-Analyse

**Kurzfassung:** Vor der Umsetzung schriftlich klären: Problem (nicht Lösung), prüfbare Erfolgskriterien, Nicht-Ziele, Randfall-Entscheidungen, Bestandsverhalten — Mehrdeutigkeit benennen statt still raten.

## Skill-Name

Anforderungsanalyse

## Zweck

Die teuersten Fehler im Software-Engineering entstehen nicht im Code, sondern davor: Es wird das Falsche gebaut, das Richtige falsch verstanden, oder Ungesagtes falsch geraten. Dieser Skill sorgt dafür, dass vor der Umsetzung geklärt ist, **was** gebraucht wird, **warum**, **für wen**, und woran man **Erfolg erkennt**. Eine Stunde Anforderungsklärung spart regelmäßig eine Woche Umbau.

## Einsatzbereich

- Jedes neue Feature, jeder Änderungswunsch, jedes Ticket
- Bugmeldungen (auch dort steckt eine Anforderung: „was wäre richtiges Verhalten?")
- Aufträge aus zweiter Hand („der Kunde will…"), wo Übersetzungsverluste wahrscheinlich sind
- Auch bei scheinbar glasklaren Aufgaben — gerade dort verstecken sich die Annahmen

## Denkweise

Denke wie ein Detektiv, nicht wie ein Kellner. Ein Kellner nimmt die Bestellung auf und liefert. Ein Detektiv fragt: Was ist hier eigentlich das Problem? Wer sagt das, und woher weiß er es? Was wird als selbstverständlich vorausgesetzt, ohne es zu sagen?

Kernsatz für Junioren: **Die Anforderung, wie sie formuliert ist, ist fast nie die Anforderung, wie sie gemeint ist.** Menschen beschreiben Lösungen („bau mir einen Export-Button"), wenn sie Probleme haben („ich muss die Daten monatlich an den Steuerberater geben"). Wer die Lösung baut ohne das Problem zu kennen, baut oft die falsche Lösung sehr ordentlich.

## Kernregeln

**MUSS:**
1. Vor Umsetzungsbeginn drei Dinge schriftlich festhalten: **Ziel** (welches Problem wird gelöst), **Erfolgskriterium** (woran erkennt man, dass es gelöst ist — prüfbar formuliert), **Nicht-Ziele** (was ausdrücklich nicht Teil der Aufgabe ist).
2. Bei jeder Lösungsvorgabe („mach ein Dropdown") einmal nach dem dahinterliegenden Problem fragen — mindestens gedanklich, bei Zweifel real.
3. Mehrdeutigkeiten benennen statt still auflösen. Wenn zwei Lesarten zu unterschiedlichem Code führen: Rückfrage. Wenn beide Lesarten zum selben Code führen: weiterarbeiten und die Annahme dokumentieren.
4. Randfälle aktiv abklopfen, bevor sie im Code auftauchen: leere Menge, null, Duplikate, Nebenläufigkeit, Berechtigungen, Zeitzonen, sehr große Mengen. Nicht jeder Fall braucht eine Antwort — aber jeder braucht eine bewusste Entscheidung („out of scope" ist eine gültige Antwort).
5. Bestandsverhalten klären: Was passiert mit existierenden Daten/Nutzern/Integrationen? „Neu" ist einfach, „neu neben alt" ist die eigentliche Aufgabe.

**SOLL:**
6. Anforderungen als prüfbare Sätze formulieren: „Ein Nutzer ohne Admin-Rolle erhält beim Aufruf von X den Status 403" — nicht „Zugriff soll geschützt sein".
7. Den Auftraggeber die eigene Zusammenfassung bestätigen lassen, wenn die Aufgabe > 1 Tag Aufwand hat oder aus zweiter Hand kommt.
8. Implizite Qualitätsanforderungen explizit machen: Wie schnell? Wie viele gleichzeitig? Wie lange aufbewahren? Offline nötig?
9. Prioritäten erfragen, wenn die Anforderung mehrere Wünsche bündelt: Was davon ist der Kern, was ist nice-to-have?

**KANN:**
10. Bei komplexen Anforderungen ein Beispiel durchspielen: „Kunde Müller macht am 31.12. um 23:58 eine Bestellung — was genau passiert?" Konkrete Beispiele decken Lücken schneller auf als abstrakte Diskussion.
11. Ein kurzes „Was wäre die dümmste Lösung, die die Anforderung wörtlich erfüllt?"-Gedankenexperiment machen — es zeigt, wo die Anforderung unterspezifiziert ist.

## Arbeitsablauf

1. **Wörtlich lesen:** Die Anforderung so nehmen, wie sie dasteht. Markieren, was Lösung und was Problem ist.
2. **Problem freilegen:** Warum wird das gebraucht? Wer nutzt es, wie oft, in welchem Kontext?
3. **Erfolg definieren:** 1–3 prüfbare Erfolgskriterien formulieren.
4. **Grenzen ziehen:** Nicht-Ziele explizit machen. Scope-Fragen jetzt klären, nicht beim Review.
5. **Randfälle abklopfen:** Standardliste durchgehen (leer/null/Duplikat/parallel/Rechte/Zeit/Volumen/Bestandsdaten). Antworten oder bewusste Ausschlüsse notieren.
6. **Widersprüche prüfen:** Passt die Anforderung zu bestehendem Verhalten, bestehenden Regeln, anderen laufenden Änderungen?
7. **Rückspiegeln:** Zusammenfassung an den Auftraggeber (bei relevanter Größe). Erst nach Bestätigung → `skill-task-decomposition.md`.

## Checkliste

- [ ] Kann ich das zu lösende Problem in einem Satz sagen — ohne die Lösung zu nennen?
- [ ] Habe ich prüfbare Erfolgskriterien?
- [ ] Sind Nicht-Ziele benannt?
- [ ] Sind die Standard-Randfälle entschieden (auch per bewusstem Ausschluss)?
- [ ] Ist geklärt, was mit Bestandsdaten/-nutzern passiert?
- [ ] Würden zwei Entwickler nach dieser Anforderung dasselbe bauen? Wenn nein: Was fehlt?
- [ ] Sind offene Annahmen dokumentiert und dem Auftraggeber sichtbar?

## Typische Fehler

- **Lösungshörigkeit:** Die vorgeschlagene Lösung bauen, ohne das Problem zu prüfen. Der Klassiker: Der Export-Button war gewünscht, ein automatischer Mail-Versand hätte das echte Problem besser gelöst.
- **Stilles Raten:** Mehrdeutigkeit bemerken und die bequemste Lesart wählen, ohne es zu sagen. Das rächt sich beim Abnahmetermin.
- **Rand­fall-Aufschub:** „Das klären wir, wenn es auftritt" — es tritt in Produktion auf, nachts.
- **Goldrand:** Aus einer kleinen Anforderung ein Rahmenwerk machen. Nicht-Ziele schützen auch vor sich selbst.
- **Scheinpräzision:** Lange Anforderungsdokumente, in denen das Erfolgskriterium trotzdem fehlt. Menge ersetzt keine Prüfbarkeit.
- **Bug ohne Soll:** Einen Bug fixen, ohne zu klären, was richtiges Verhalten wäre. „Es stürzt nicht mehr ab" ist kein Erfolgskriterium.

## Beispiele

**Vorher (roh):** „Der Report muss schneller werden."
**Nachher (analysiert):** Problem: Monatsabschluss-Report läuft 40 Min., Buchhaltung wartet darauf am Monatsersten. Erfolgskriterium: < 5 Min. für den Monat mit dem größten Datenvolumen (Jan 2026, 2,1 Mio. Zeilen). Nicht-Ziel: Optimierung der übrigen Reports. Randfall-Entscheidung: Parallelläufe zweier Nutzer sind zulässig, Ergebnis-Caching pro Parametersatz erlaubt (max. 1 h alt).

**Rückfrage richtig gestellt:** „Du schreibst ‚Kunden sollen ihre Rechnungen sehen'. Zwei Lesarten: (a) nur eigene Rechnungen, (b) alle Rechnungen ihres Firmenkontos inkl. Kollegen. (a) ist restriktiver und schnell erweiterbar, (b) braucht ein Rechtemodell. Ich empfehle (a) als ersten Schritt — passt das?" — Rückfrage mit Optionen und Empfehlung, nicht als offene Frage.

## Eskalation

Zwingend rückfragen, wenn:

- zwei Lesarten zu unterschiedlichem Code führen und keine aus dem Kontext belegbar richtiger ist,
- die Anforderung bestehendem Verhalten widerspricht, auf das andere sich verlassen könnten,
- die Anforderung eine stille Produktentscheidung enthält (Sichtbarkeit, Berechtigung, Löschverhalten, Preislogik),
- Erfolg nicht prüfbar formulierbar ist, weil Zahlen/Fakten fehlen (z. B. „schnell genug" ohne Messgröße),
- der Auftrag aus zweiter Hand kommt und geschäftskritisch ist — dann Original-Stakeholder einbeziehen.

Rückfragen immer mit Optionen und eigener Empfehlung stellen. Das respektiert die Zeit des Gefragten und zwingt einen selbst, das Problem zu Ende zu denken.
