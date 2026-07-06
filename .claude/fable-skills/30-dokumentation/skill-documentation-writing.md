# skill-documentation-writing

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Alle technischen Texte, die Wissen konservieren sollen · **Empfohlene Einsatzkontexte:** READMEs, Modul-Doku, How-tos, Konzeptdokumente, Code-Kommentare

**Kurzfassung:** Für einen konkreten Leser in einer konkreten Situation schreiben, Warum statt Code-Nacherzählung, Anleitungen real durchspielen, Stand-Datum setzen, nah am Gegenstand ablegen — Pflegbarkeit schlägt Vollständigkeit.

## Skill-Name

Dokumentation schreiben

## Zweck

Dokumentation ist konserviertes Wissen mit Verfallsdatum. Gute Doku spart dem nächsten Leser Stunden; schlechte Doku ist schlimmer als keine, weil ihr geglaubt wird, wenn sie längst falsch ist. Dieser Skill sorgt dafür, dass Dokumentation **auffindbar, wahr, zielgruppengerecht und pflegbar** ist — und dass dokumentiert wird, was Code nicht selbst sagen kann, statt Code in Prosa zu wiederholen.

## Einsatzbereich

- READMEs, Setup-Anleitungen, How-tos, Modul- und Systemdokumentation
- Code-Kommentare (die kleinste Doku-Form)
- Konzept- und Erklärdokumente für Team und Nachwelt
- Nicht hier behandelt, aber verwandt: Architektur-Doku (`skill-architecture-documentation.md`), Runbooks (`skill-runbook-writing.md`), Änderungsdoku (`skill-change-documentation.md`)

## Denkweise

Schreibe für eine konkrete Person in einer konkreten Situation: **den Kollegen, der in 18 Monaten — wenn niemand vom heutigen Team mehr erreichbar ist — um 16:45 Uhr vor genau diesem Problem sitzt.** Er hat wenig Zeit, keinen Kontext und keine Möglichkeit nachzufragen. Jede Zeile Doku wird an ihm gemessen: Findet er sie? Versteht er sie? Stimmt sie noch? Kann er danach handeln?

Zweiter Leitgedanke: **Dokumentiere das Warum, nicht das Was.** Das Was steht im Code und veraltet dort nie. Das Warum (Entscheidungen, Annahmen, Fallstricke, abgelehnte Alternativen) steht nirgendwo — es verdunstet mit dem Team. Doku, die Code nacherzählt, ist Ballast; Doku, die Gründe konserviert, ist Gold.

Dritter Leitgedanke: **Pflegbarkeit schlägt Vollständigkeit.** Zehn Seiten, die niemand aktuell hält, verlieren gegen eine Seite, die stimmt. Jedes Dokument ist eine Wartungsverpflichtung — man geht sie bewusst ein oder lässt es.

## Kernregeln

**MUSS:**
1. Vor dem Schreiben festlegen: **Wer liest das, in welcher Situation, und was soll er danach können?** Ohne Antwort kein Dokument. („Alle" ist keine Zielgruppe.)
2. Das Wichtigste zuerst: Zweck und Kernaussage in die ersten 3–5 Zeilen. Leser scannen; wer den Nutzen nicht sofort sieht, ist weg.
3. Jede Anleitung **selbst durchspielen** (oder durchspielen lassen), bevor sie gilt: Jeder Befehl ausgeführt, jeder Pfad geprüft, auf einer frischen Umgebung, nicht auf der eigenen historisch gewachsenen. Ungetestete Anleitungen sind die häufigste Form falscher Doku.
4. Verfallskennzeichnung: Jedes Dokument trägt Stand-Datum und (wo sinnvoll) Gültigkeitsbereich/Version des beschriebenen Systems. Der Leser muss beurteilen können, wie sehr er dem Text trauen darf.
5. Doku so nah wie möglich am Gegenstand ablegen (README im Modul, Kommentar an der Stelle, ADR im Repo) — nicht in einem entkoppelten Wiki-Silo, das bei Codeänderungen niemand mitdenkt. Wenn ein externes System Pflicht ist: im Code auf das Dokument verweisen.
6. Code-Kommentare nur für das, was der Code nicht selbst sagen kann: Warum so (nicht anders), welche Einschränkung von außen gilt, welche Falle hier lauert. Kommentare, die die nächste Zeile paraphrasieren, werden nicht geschrieben (und beim Antreffen entfernt).

**SOLL:**
7. Dokumenttyp bewusst wählen und nicht mischen: **Anleitung** (Schritte zum Ziel), **Nachschlagewerk** (Fakten, vollständig, geordnet), **Erklärung** (Zusammenhänge, Warum), **Einstieg/Tutorial** (an die Hand nehmen). Ein Text, der alles zugleich will, leistet nichts davon.
8. Konkrete Beispiele vor abstrakten Beschreibungen: Ein echter Request mit echter Antwort erklärt ein API besser als drei Absätze Prosa. Beispiele müssen lauffähig/echt sein — erfundene Beispiele mit Fehlern zerstören Vertrauen.
9. Struktur für Scanner: aussagekräftige Überschriften, kurze Absätze, Listen für Aufzählungen, Tabellen für Vergleichbares. Der Leser sucht, er liest nicht linear.
10. Fachbegriffe beim ersten Auftreten in einem Halbsatz einordnen, wenn Junioren zur Zielgruppe gehören. Nicht dozieren — verankern.
11. Beim Ändern von Verhalten die zugehörige Doku im selben Arbeitsgang aktualisieren (Doku-Änderung gehört in den Diff). Veraltete Doku, die man findet und nicht fixen kann: mindestens als veraltet markieren.
12. Vor Textmenge Angst haben, nicht vor Kürze: Jeder Satz, der dem definierten Leser nicht hilft, fliegt raus.

**KANN:**
13. Ein „Bekannte Fallstricke"-Kapitel führen — oft der wertvollste Teil eines Dokuments und der, den nur erfahrene Autoren schreiben können.
14. FAQ-Form nutzen, wenn dieselben Fragen wiederholt real gestellt wurden (echte Fragen, keine erfundenen).
15. Skizzen/Diagramme einsetzen, wo Beziehungen erklärt werden — mit Quelldatei im Repo, damit sie änderbar bleiben.

## Arbeitsablauf

1. **Leser und Situation definieren:** Wer, wann, mit welchem Ziel? Eine Zeile, notiert.
2. **Kernaussagen sammeln:** Was muss dieser Leser wissen? (Stichpunkte, noch keine Prosa.) Alles streichen, was nicht auf sein Ziel einzahlt.
3. **Typ wählen:** Anleitung, Nachschlagewerk, Erklärung oder Einstieg — Struktur entsprechend aufsetzen.
4. **Schreiben:** Wichtigstes zuerst, Beispiele echt, Begriffe verankert, Warum vor Was.
5. **Verifizieren:** Anleitungen durchspielen (frische Umgebung), Fakten gegen den Code prüfen, Beispiele ausführen.
6. **Verorten:** Am Gegenstand ablegen, verlinken, Stand-Datum setzen.
7. **Gegenlesen lassen:** Idealerweise von jemandem aus der Zielgruppe — ein Junior, der über eine Stelle stolpert, hat immer recht.

## Checkliste

- [ ] Ist Zielgruppe + Situation definiert, und dient jeder Abschnitt ihr?
- [ ] Steht der Zweck in den ersten 3–5 Zeilen?
- [ ] Sind alle Schritte/Beispiele tatsächlich ausgeführt worden?
- [ ] Dokumentiere ich Warum/Fallstricke statt Code-Nacherzählung?
- [ ] Trägt das Dokument Stand-Datum und Geltungsbereich?
- [ ] Liegt es am Gegenstand (oder ist es von dort verlinkt)?
- [ ] Würde der Kollege in 18 Monaten damit handlungsfähig sein — ohne Rückfragemöglichkeit?
- [ ] Habe ich gestrichen, was der Leser nicht braucht?

## Typische Fehler

- **Code-Nacherzählung:** „Diese Funktion nimmt eine Kundennummer und gibt den Kunden zurück." Steht alles in der Signatur. Verschwendet Leserzeit und veraltet still.
- **Ungetestete Anleitungen:** Setup-Doku, geschrieben aus dem Gedächtnis auf einer Maschine, auf der alles längst installiert ist. Der Neue scheitert bei Schritt 2.
- **Doku für den Autor:** Texte, die das eigene Wissen sortieren, statt die Fragen des Lesers zu beantworten. Erkennbar an: viel Innenarchitektur, keine Handlungsanleitung.
- **Der große Wurf:** Das 40-Seiten-Systemhandbuch, das nach 3 Monaten in Schönheit stirbt. Klein anfangen, pflegen, wachsen lassen.
- **Wiki-Friedhof:** Doku weit weg vom Code, ohne Verweis, ohne Pflegeverantwortung. Nach einem Jahr weiß niemand mehr, was davon noch gilt — also traut niemand mehr irgendetwas davon.
- **Angstvollständigkeit:** Jeden Sonderfall dokumentieren wollen und deshalb nie fertig werden. Das 80 %-Dokument heute schlägt das 100 %-Dokument nie.
- **Kommentar-Lügen:** Kommentare, die nach der dritten Codeänderung das Gegenteil des Codes behaupten. Deshalb: Kommentare sparsam und nur fürs Warum — Warum veraltet selten.

## Beispiele

**Schlechter Kommentar / guter Kommentar:**
```csharp
// schlecht: erzählt den Code nach
// Erhöhe den Zähler um 1
retryCount++;

// gut: konserviert Wissen, das nicht im Code steht
// Provider-API liefert bei Duplikaten 200 statt 409 (Ticket PAY-231),
// deshalb prüfen wir zusätzlich die Transaktions-ID.
```

**README-Einstieg, gut:**
> **Rechnungs-Export (invoice-export)** — erzeugt monatliche DATEV-Exportdateien für die Buchhaltung. Läuft als Nachtjob (1. des Monats, 03:00) und manuell per `run-export.ps1`. Stand: 2026-07. **Bei Fehlern zuerst:** [Runbook](./runbook.md). Häufigster Stolperstein: Der Export braucht die Vormonats-Kurstabelle — fehlt sie, bricht er mit `FX-RATES MISSING` ab (Abschnitt „Fallstricke").

Warum gut: Zweck, Auslöser, Einstieg für den Notfall und der häufigste Fehler — alles in fünf Zeilen, geschrieben für den Kollegen um 16:45 Uhr.

## Eskalation

- Wenn beim Dokumentieren **Widersprüche zwischen Code und bisheriger Doku/Aussagen** auffallen: nicht still die eine Version wählen — klären, welche stimmt, und die falsche korrigieren oder markieren.
- Wenn sich herausstellt, dass Wissen nur noch in einem Kopf existiert (Bus-Faktor 1) und die Person verfügbar ist: Interview-Termin vorschlagen (`skill-knowledge-transfer.md`) — Doku aus zweiter Hand ist zweite Wahl.
- Wenn die Zielgruppe unklar ist oder der Auftraggeber „einfach alles dokumentieren" will: Rückfrage mit Vorschlag — konkrete Leser-Situationen anbieten und priorisieren lassen. Unbegrenzte Doku-Aufträge produzieren Friedhöfe.
- Wenn Dokumentation Sicherheitsrelevantes enthalten würde (Secrets, interne Angriffsflächen): klären, wo das Dokument liegen darf und wer es lesen kann, bevor es geschrieben wird.
