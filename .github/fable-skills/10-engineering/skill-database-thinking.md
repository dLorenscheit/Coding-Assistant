# skill-database-thinking

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Datenmodellierung, Queries, Migrationen, Transaktionen · **Empfohlene Einsatzkontexte:** Schema-Design, SQL-Arbeit, Datenmigrationen, Persistenz-Entscheidungen

**Kurzfassung:** Daten überleben jeden Code: Schema-Entscheidungen sind die am schwersten umkehrbaren, Integrität gehört in die Datenbank (Constraints), Migrationen laufen abwärtskompatibel und rückrollbar, Transaktionsgrenzen sind bewusste Entscheidungen, und Queries werden gegen realistische Datenmengen geprüft.

## Skill-Name

Datenbank-Denken

## Zweck

Anwendungscode wird ersetzt, umgebaut, neu geschrieben — die Daten bleiben. Ein Schemafehler von heute quält noch das dritte Nachfolgesystem; ein korrupter Datenbestand ist oft irreparabel. Dieser Skill vermittelt die Denkweise, mit der man Datenstrukturen, Zugriffe und Änderungen so behandelt, wie es ihrer Lebensdauer und Kritikalität entspricht.

## Einsatzbereich

- Schema-Entwurf und -Änderung (Tabellen, Constraints, Indizes)
- Query-Design und -Review (SQL, ORM-Nutzung)
- Datenmigrationen (Struktur und Inhalt)
- Transaktions- und Konsistenzfragen; Auswahl von Persistenztechnologien

## Denkweise

Behandle die Datenbank als das Fundament, nicht als Abstellraum des Codes: **Der Code ist Meinung, die Daten sind Fakten.** Anwendungen kommen und gehen (und mit ihnen ihre Validierungslogik) — was die Datenbank nicht selbst erzwingt, wird irgendwann verletzt: vom Zweitsystem, vom Admin-Skript, vom Import, vom Bugfix um Mitternacht.

Zweiter Grundsatz: **Denke in Datenmengen, nicht in Beispielzeilen.** Jede Query, jedes fehlende Limit, jeder fehlende Index verhält sich bei 100 Zeilen unauffällig und bei 10 Millionen katastrophal. Die Frage ist nie „funktioniert es?", sondern „funktioniert es noch, wenn diese Tabelle so groß ist wie in drei Jahren?"

## Kernregeln

**MUSS:**
1. Integritätsregeln, die immer gelten müssen, in der DB erzwingen: Fremdschlüssel, NOT NULL, UNIQUE, CHECK — nicht nur in der Anwendung. Die DB ist die letzte Verteidigungslinie gegen jeden künftigen Schreibpfad.
2. Schema-Migrationen abwärtskompatibel in Schritten ausrollen (expand → migrate → contract): erst erweitern (neue Spalte nullable/mit Default), Code umstellen, erst dann Altes entfernen — alter und neuer Code müssen während des Deployments gleichzeitig funktionieren. Jede Migration hat einen getesteten Rückweg oder ist explizit als Point-of-no-Return freigegeben (`skill-task-decomposition.md`, Regel 5).
3. Destruktive Operationen (DROP, DELETE, UPDATE ohne WHERE-Review, Inhaltsmigrationen) nur mit: vorheriger Mengenprüfung (SELECT COUNT mit derselben WHERE-Klausel), Backup/Restore-Weg, und bei Produktionsdaten expliziter Freigabe.
4. Transaktionsgrenzen bewusst setzen: Was zusammen gelten muss, gehört in eine Transaktion; was lange dauert oder extern aufruft, gehört nicht hinein (Locks!). „Zwei Schreibvorgänge, keine Transaktion, wird schon gutgehen" ist ein Datenintegritätsfehler in Wartestellung (`skill-code-review.md`, Beispiel).
5. Queries auf Skalierbarkeit prüfen: Zugriffspfade über Indizes abgedeckt? Kein N+1 (Query-Anzahl pro Vorgang zählen)? Kein SELECT * über breite Tabellen? Listen mit Limit/Paginierung? Bei Zweifel: Execution Plan mit realistischer Datenmenge (`skill-performance-analysis.md`, Regel 5).
6. Geld als DECIMAL (nie Float), Zeitstempel mit definierter Zeitzonen-Strategie (idealerweise UTC in der DB) — Korrektur im Bestand ist um Größenordnungen teurer als richtig anfangen.

**SOLL:**
7. Fürs Verstehen normalisieren, fürs Messen denormalisieren: Ausgangspunkt ist ein redundanzfreies Modell (eine Tatsache, ein Ort); Redundanz nur mit belegtem Performance-Bedarf und definiertem Abgleichmechanismus.
8. ORM-Komfort misstrauisch begleiten: Lazy Loading, automatische Kaskaden und generierte Queries sind die Hauptquellen von N+1 und Überraschungslöschungen — bei kritischen Pfaden das erzeugte SQL ansehen.
9. Indizes als Trade-off behandeln: Sie beschleunigen Lesen und verteuern jedes Schreiben — nach echten Zugriffsmustern setzen (Query-Log), nicht prophylaktisch auf jede Spalte.
10. Lösch- und Historienstrategie pro Tabelle bewusst entscheiden (hart löschen, soft-delete, Archiv, Audit) — inklusive rechtlicher Anforderungen (Aufbewahrung, DSGVO-Löschpflicht).
11. Gleichzeitigkeit durchdenken: Was passiert, wenn zwei Prozesse denselben Datensatz ändern? (Optimistic Locking, Constraints, `SELECT … FOR UPDATE` — bewusst wählen statt Zufall walten lassen.)

**KANN:**
12. Für Legacy-Datenbestände Qualitätsanalyse vor Migrationsplanung: NULL-Raten, Duplikate, verletzte implizite Regeln — die Überraschungen stecken in den Daten, nicht im Schema.
13. Query-Wissen im Repo konservieren: kommentierte, geprüfte Kern-Queries statt Stammes-Wissen in Einzelköpfen.

## Arbeitsablauf

1. **Fachlichkeit modellieren:** Entitäten, Beziehungen, Invarianten („ein Auftrag hat genau einen Kunden") — Invarianten als Constraints formulieren.
2. **Zugriffsmuster erheben:** Wer liest/schreibt wie oft, welche Mengen, welche Suchen? Daraus Indizes und ggf. bewusste Redundanz ableiten.
3. **Lebenszyklus klären:** Wachstum, Löschung, Historie, Aufbewahrung.
4. **Migrationsweg planen:** expand→migrate→contract, Rückweg, Mengen- und Dauerabschätzung gegen Produktionsgröße (lockt die Migration Tabellen? Wartungsfenster nötig?).
5. **Queries validieren:** Plan/Query-Zählung mit realistischen Mengen; kritische Pfade testen (`skill-testing-strategy.md`, Regel 7 — gegen echte DB).
6. **Betrieb absichern:** Backup/Restore für die Änderung geprüft, Monitoring für neue Zugriffe.

## Checkliste

- [ ] Erzwingt die DB die Invarianten (FK, NOT NULL, UNIQUE, CHECK)?
- [ ] Ist die Migration abwärtskompatibel geschnitten und rückrollbar (oder als PonR freigegeben)?
- [ ] Vor destruktiven Operationen: Mengen geprüft, Backup-Weg getestet, Freigabe eingeholt?
- [ ] Transaktionsgrenzen bewusst gesetzt (zusammen was zusammengehört, nichts Langes/Externes darin)?
- [ ] Queries gegen realistische Mengen geprüft (Indizes, N+1, Limits)?
- [ ] Geld als DECIMAL, Zeit mit Zeitzonen-Strategie?
- [ ] Gleichzeitige Änderungen durchdacht?
- [ ] Lösch-/Historienstrategie entschieden?

## Typische Fehler

- **Validierung nur im Code:** „Die App prüft das ja" — bis das Import-Skript, das Admin-Tool oder der nächste Bugfix direkt schreibt.
- **Big-Bang-Migration:** Spalte umbenennen in einem Deployment — in der Sekunde zwischen DB-Änderung und Code-Rollout wirft alles Fehler; Rollback unmöglich.
- **UPDATE ohne Netz:** Inhalts-Fix auf Produktion, WHERE-Klausel minimal daneben, 200.000 Zeilen falsch, Backup von gestern.
- **N+1 im ORM-Gewand:** Schleife über Bestellungen, Lazy-Load der Positionen — 10.000 Queries, unsichtbar im Code, brutal in Produktion.
- **Der fehlende Index — und der Index-Friedhof:** Beides real: die Volltabellen-Suche im Kundenportal ebenso wie 14 nie genutzte Indizes, die jedes INSERT verteuern.
- **Float-Geld und naive Zeit:** Rundungscent-Differenzen im Abschluss; Sommerzeit-Doppelbuchungen um 2:30 Uhr.
- **Transaktion um den Mail-Versand:** Externer Aufruf in der Transaktion — Timeout hält Locks, DB staut, System steht.

## Beispiele

**Gut (Migration):** Spalte `kunde_name` soll in `vorname`/`nachname` geteilt werden. Schritt 1 (expand): neue Spalten nullable anlegen, Backfill-Job in Batches (Mengencheck: 2,4 Mio. Zeilen, ~15 Min., kein Lock-Problem — auf Kopie gemessen). Schritt 2: Code liest neu, schreibt beides. Schritt 3 (contract, zwei Releases später): alte Spalte entfernen — nachdem Log-Metrik bestätigt, dass kein Leser mehr zugreift. Jeder Schritt einzeln deploybar und rückrollbar.

**Schlecht:** Ein Release: Spalte umbenannt + Code umgestellt. Deployment dauert 4 Minuten — 4 Minuten Fehlerregen; Rollback scheitert, weil die alte Spalte weg ist.

## Eskalation

- Destruktive Produktionsoperation ansteht → Freigabe durch Verantwortliche, getesteter Restore-Weg, Vier-Augen auf die WHERE-Klausel. Ohne alle drei: nicht ausführen.
- Datenqualität im Bestand verhindert saubere Migration (Duplikate, verletzte Invarianten) → Befund mit Mengen vorlegen; Bereinigungsstrategie ist eine Fachentscheidung, keine technische.
- Konsistenzanforderung über Systemgrenzen (verteilte Transaktion) → Architekturfrage (`skill-architecture-thinking.md`), Entscheidungsvorlage statt Eigenbau.
- Rechtliche Fragen zu Löschung/Aufbewahrung → klären lassen, nicht selbst interpretieren.
- Migration braucht Wartungsfenster/Lock auf großer Tabelle → Betrieb einbeziehen, Zeitpunkt abstimmen — nie „einfach mittags laufen lassen".
