# skill-knowledge-transfer

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Sicherung und Übertragung von Kopfwissen · **Empfohlene Einsatzkontexte:** Bus-Faktor-Risiken, ausscheidende Wissensträger, Teamwechsel, Wissensmonopole

**Kurzfassung:** Kopfwissen stirbt still: nach Risiko priorisieren (Bus-Faktor × Kritikalität), das wertvollste Wissen ist das unsichtbare (Warums, Eigenheiten, verworfene Wege, „daran denken wenn") — übertragen durch gemeinsames Arbeiten und strukturierte Interviews, konserviert in Doku, verifiziert durch den Empfänger, der es anwendet.

## Skill-Name

Wissenstransfer

## Zweck

In jedem Team gibt es Wissen, das genau eine Person hat — und das beim Weggang dieser Person nicht „verloren geht", sondern teuer wiederbeschafft wird: durch Ausfälle, Fehlentscheidungen und Archäologie. Dieser Skill macht Wissenssicherung planbar: was zuerst, in welcher Form, und woran man erkennt, dass der Transfer wirklich stattgefunden hat. Er ist das Langzeit-Gegenstück zur akuten Übergabe (`skill-handover.md`).

## Einsatzbereich

- Bus-Faktor-1-Bereiche (erkannt oder vermutet)
- Angekündigte Abgänge, Renteneintritte, Teamwechsel (je früher, desto mehr bleibt)
- Dauerhafte Wissensmonopole („DB-Fragen macht immer K.")
- Nach Vorfällen, die Wissenslücken offengelegt haben

## Denkweise

Denke wie ein Archivar der **unsichtbaren Bestände**: Das sichtbare Wissen (Code, Doku, Configs) ist schon gesichert — es liegt im Repo. Was mit der Person verschwindet, ist das Unsichtbare: *Warum* es so ist (Entscheidungen, Zwänge von damals), *woran man denken muss* (Eigenheiten, Fallen, saisonale Effekte), *was schon probiert wurde* (verworfene Wege), *wie man vorgeht, wenn* (Diagnose-Instinkte), und *wen man kennt* (Ansprechpartner, informelle Absprachen). Dieses Wissen kann sein Träger meist nicht aufzählen — er weiß nicht, was er weiß, bis eine konkrete Situation es abruft.

Daraus folgt die Kernmethode: **Wissen wird an Situationen abgerufen, nicht an Fragebögen.** Gemeinsames Arbeiten an echten Fällen (Pairing bei Störung, Wartung, Änderung) und Interviews entlang konkreter Artefakte („geh mit mir durch, was dieser Job nachts tut") fördern das Unsichtbare zutage — die abstrakte Bitte „schreib mal auf, was du weißt" fördert Inhaltsverzeichnisse zutage.

## Kernregeln

**MUSS:**
1. Nach Risiko priorisieren, nicht nach Verfügbarkeit: Bereiche nach **Bus-Faktor × Kritikalität × Wiederbeschaffungskosten** sortieren; die Top-Bereiche zuerst. Nicht alles ist sicherbar — die 20 % Wissen, die 80 % des Schadens verhindern, sind das Ziel (`skill-handover.md`, Eskalation).
2. Empfänger vor Medium: Jeder Transferbereich braucht einen benannten Menschen, der das Wissen übernimmt und künftig anwendet. Doku allein ist Konservierung, kein Transfer — ohne Empfänger, der damit arbeitet, veraltet sie ungeprüft.
3. Transfer verifizieren durch Anwendung: Der Empfänger löst einen echten Fall selbst (Wissensträger nur beobachtend erreichbar) — erst das deckt die Lücken auf, die beim Zuhören unsichtbar bleiben. „Hat zugehört und genickt" ist kein Transfer (`skill-handover.md`, Regel 3; `skill-technical-explanations.md`, Regel 5).
4. Das Unsichtbare gezielt abfragen — die fünf Kategorien pro Bereich durcharbeiten: Warums/Entscheidungen (→ als ADRs nachdokumentieren, `skill-decision-records.md`), Eigenheiten/Fallen (→ Gefahrenzonen-Doku, `skill-architecture-documentation.md`, Regel 8), verworfene Wege, Diagnose-Vorgehen (→ Runbook-Einträge, `skill-runbook-writing.md`), Kontakte/Absprachen.
5. Bei angekündigtem Abgang sofort beginnen: Der Umfang des Rettbaren fällt mit jeder Woche; die letzte Woche ist für Restfragen, nicht für den Transfer (`skill-handover.md`, Letzte-Woche-Übergabe).

**SOLL:**
6. Situationen statt Sitzungen planen: Transfer an reale Anlässe koppeln — der Empfänger macht die nächste Wartung/Störung/Änderung im Bereich, der Wissensträger begleitet (Pairing mit umgekehrten Rollen: der Lernende fährt).
7. Interviews entlang von Artefakten führen: gemeinsam durch den Job, das Modul, den Monatsablauf gehen und laufend fragen: „Was kann hier schiefgehen? Warum ist das so? Was hast du hier schon erlebt?" — konkrete Anker schlagen offene Fragen.
8. Ergebnisse sofort in die bestehenden Dokumentationsorte einarbeiten (Runbook, Überblick, ADRs, Modul-READMEs) statt in ein separates „Wissenstransfer-Dokument", das niemand wiederfindet (`skill-documentation-writing.md`, Regel 5).
9. Wissensmonopole strukturell abbauen, nicht nur dokumentieren: Aufgaben im Monopolbereich bewusst an andere geben (mit Betreuung) — Rotation ist der nachhaltigste Transfer; ein Monopol, das täglich nachwächst, kann man nicht wegdokumentieren.
10. Auch beim Wissensträger ansetzen: würdigende Rahmung („dein Wissen soll weiterwirken") statt Ersetzungs-Rhetorik — wer sich wegdokumentiert fühlt, dokumentiert schlecht.

**KANN:**
11. Störfall-Simulationen nutzen: geplanter „Gameday" (Wissensträger spielt Ausfall, Team löst mit Runbook) — deckt Lücken schneller auf als jede Review-Runde.
12. Aufzeichnungen (Video-Walkthroughs) für komplexe Abläufe als Ergänzung — durchsuchbar zusammengefasst, nie als Ersatz für strukturierte Doku.

## Arbeitsablauf

1. **Inventur:** Wissensbereiche listen, Bus-Faktor und Kritikalität je Bereich schätzen (das Team fragen: „wobei wärt ihr aufgeschmissen, wenn X morgen fehlt?").
2. **Priorisieren:** Top-3-Bereiche, Empfänger pro Bereich benennen, Zeitplan (rückwärts vom Abgangsdatum, falls es eins gibt).
3. **Heben:** Pro Bereich artefakt-geführte Interviews (fünf Kategorien) + gemeinsame Realfälle; Erkenntnisse sofort verdokumentieren (an die richtigen Orte).
4. **Anwenden lassen:** Empfänger übernimmt reale Aufgaben im Bereich; Lücken nachziehen.
5. **Verifizieren:** Empfänger löst einen Fall autonom; Gameday für kritische Abläufe.
6. **Verstetigen:** Rotation etablieren, damit das Monopol nicht nachwächst; Rest-Risiko dokumentieren.

## Checkliste

- [ ] Sind die Bereiche nach Bus-Faktor × Kritikalität priorisiert (statt „wir dokumentieren mal alles")?
- [ ] Hat jeder Top-Bereich einen benannten Empfänger?
- [ ] Werden die fünf unsichtbaren Kategorien gezielt gehoben (Warums, Fallen, Verworfenes, Diagnose, Kontakte)?
- [ ] Fließen Ergebnisse in bestehende Doku-Orte (Runbook, ADRs, Überblick)?
- [ ] Wendet der Empfänger das Wissen an echten Fällen an?
- [ ] Ist der Transfer durch autonome Anwendung verifiziert?
- [ ] Wird das Monopol strukturell abgebaut (Rotation), nicht nur beschrieben?

## Typische Fehler

- **„Schreib mal alles auf":** Der Wissensträger produziert 40 Seiten Systembeschreibung — das Sichtbare, das eh im Repo steht. Die Fallen und Warums fehlen, weil niemand sie abgerufen hat.
- **Transfer = Meeting-Serie:** Sechs Übergabe-Termine, Folien, Nicken. Beim ersten echten Störfall stellt sich heraus: nichts Anwendbares angekommen.
- **Kein Empfänger:** Doku „für das Team" geschrieben — alle zuständig, niemand verantwortlich, keiner liest sie, bis sie veraltet ist.
- **Zu spät begonnen:** Transfer startet vier Wochen vor Renteneintritt für 20 Jahre Wissen. Es wird eine Auswahl gerettet — aber durch Panik statt durch Priorität.
- **Monopol-Pflege aus Effizienz:** „Das macht K., der ist am schnellsten" — jede Woche wächst das Monopol, das man später teuer abbauen muss. Kurzfristige Effizienz, langfristiges Klumpenrisiko.
- **Würde-Fehler:** Der Transfer wird als Ersetzung kommuniziert („damit wir dich nicht mehr brauchen") — der Wissensträger liefert Dienst nach Vorschrift, das Unsichtbare bleibt bei ihm.
- **Verifikation vergessen:** Übergeben, abgehakt — die Lücken zeigen sich erst, wenn der Wissensträger nicht mehr erreichbar ist. Genau eine Anwendung unter Beobachtung hätte sie gezeigt.

## Beispiele

**Artefakt-geführtes Interview (Auszug, Monatsabschluss-Job):**
> „Geh mit mir den Ablauf durch, als liefe er jetzt." — Beim Schritt „Kurstabelle laden" sagt der Wissensträger beiläufig: „Da schau ich vorher immer, ob die EZB-Datei schon da ist — Anfang Januar kommt die manchmal erst am 2." Das ist der Jackpot: eine undokumentierte saisonale Falle samt Diagnose-Instinkt. Ergebnis: Runbook-Eintrag „FX-RATES MISSING" + Prüf-Check im Job. Eine abstrakte Frage („gibt es saisonale Probleme?") hätte das nie gehoben — die Situation hat es abgerufen.

**Priorisierung (verkürzt):** Team-Inventur ergibt: (1) Zahllauf-Eigenheiten — Bus-Faktor 1, kritisch, Empfänger: D., Start sofort mit Begleitung des nächsten Laufs. (2) RPG-Altmodul Lagerbewertung — Bus-Faktor 1, kritisch, aber stabil: Runbook + Gameday reichen vorerst. (3) Build-Server-Spezialwissen — Bus-Faktor 1, mittel: durch Standardisierung beseitigen statt transferieren (das beste Transfer-Ergebnis ist manchmal, das Sonderwissen überflüssig zu machen).

## Eskalation

- Wissensträger hat keine Zeit für Transfer (voll verplant bis zum Abgang) → an die Führung: Transfer ist Arbeitszeit und konkurriert mit Tagesgeschäft — diese Priorisierung kann nur dort entschieden werden (`skill-prioritization.md`).
- Wissensträger blockiert (bewusst oder durch Kränkung) → Führungsthema, kein Methodenthema; Rahmung prüfen (Regel 10), nicht mit mehr Formularen reagieren.
- Kritischer Bereich nicht mehr rechtzeitig sicherbar → Restrisiko beziffern (welche Ausfälle, welche Kosten) und formal akzeptieren lassen (`skill-risk-analysis.md`, Regel 9) — plus Minimal-Absicherung (Runbook-Grundgerüst, Kontaktliste, Gameday).
- Inventur deckt Bus-Faktor 1 auf laufend kritischem System auf (ohne Abgang) → als Dauer-Betriebsrisiko melden, nicht auf den Anlass warten (`skill-maintainability.md`, Eskalation).
