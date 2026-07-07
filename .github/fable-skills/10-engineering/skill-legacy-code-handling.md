# skill-legacy-code-handling

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Arbeiten in gewachsenen Systemen ohne (ausreichende) Tests und Doku · **Empfohlene Einsatzkontexte:** Altsysteme (auch C#, SQL, RPG), Wartungsaufträge, Modernisierung

**Kurzfassung:** Legacy-Code ist Produktionswissen in unbequemer Form: erst Verhalten mit Charakterisierungstests sichern, dann minimal-invasiv über Nähte ändern; Sonderfälle im Code sind meist bezahlte Lektionen — verstehen, bevor man sie entfernt; Rewrite ist die letzte Option, nicht die erste.

## Skill-Name

Legacy-Code-Handling

## Zweck

Der Reflex beim Blick in alte Systeme ist Ablehnung („das muss neu"). Dabei kodiert Legacy-Code Jahre an Fachwissen, Randfällen und bezahlten Fehlern — oft nirgendwo sonst dokumentiert. Dieser Skill vermittelt, wie man in solchen Systemen **sicher** ändert: Verhalten konservieren, Wirkradius klein halten, Verbesserung dosiert dort, wo sie sich rechnet.

## Einsatzbereich

- Änderungen in Systemen ohne Tests, ohne Doku, ohne erreichbare Autoren
- Alte Technologie-Stacks (Alt-C#, Stored-Procedure-Landschaften, RPG auf IBM i, VB, altes JS)
- Modernisierungsvorhaben (Ablösung, Teilablösung, Strangler-Ansatz)
- Faire Bewertung von Altem: `skill-clean-code-analysis.md`, Regel 5

## Denkweise

Denke wie ein Restaurator, nicht wie ein Abrissunternehmer: Das Gebäude steht seit 20 Jahren und erfüllt seinen Zweck — wer tragende Teile ersetzt, muss erst verstehen, was sie tragen. Der seltsame Sonderfall in Zeile 812 (`if kunde == 4711`) ist mit hoher Wahrscheinlichkeit kein Unsinn, sondern die Narbe eines teuren Produktionsvorfalls. **Chestertons Zaun:** Einen Zaun, dessen Zweck man nicht kennt, reißt man nicht ab — man findet erst heraus, warum er dort steht (git blame, alte Tickets, Fachbereich fragen).

Zweiter Grundsatz: **Im Legacy-System ist das beobachtete Verhalten der Vertrag.** Nicht die Doku, nicht die Vermutung, was gemeint war. Irgendjemand oder irgendein System verlässt sich erfahrungsgemäß auf jede Eigenheit — auch auf die „offensichtlich falsche" Rundung.

## Kernregeln

**MUSS:**
1. Vor jeder Änderung das Ist-Verhalten der betroffenen Stelle sichern: Charakterisierungstests, die festhalten was das System *tut* (inkl. seltsamer Randfälle) — nicht was es tun *sollte*. Wo automatisierte Tests unmöglich sind: dokumentierte manuelle Vergleichsläufe (gleicher Input → gleicher Output, z. B. Reportvergleich alt/neu).
2. Minimal-invasiv ändern: kleinster Eingriff, der den Auftrag erfüllt. Kein „wenn ich schon hier bin"-Umbau — der Wirkradius in unverstandenem Code ist unkalkulierbar (`skill-change-impact-analysis.md`).
3. Unverstandene Sonderfälle vor dem Entfernen aufklären (Historie, Fachbereich). Nicht aufklärbar → Verhalten beibehalten und die offene Frage dokumentieren.
4. Verhaltensänderung nur bewusst und abgestimmt: Wenn der Auftrag „Bug fixen" lautet, klären, ob das „falsche" Verhalten nicht längst von Konsumenten erwartet wird (nachgelagerte Systeme, Excel-Makros im Fachbereich, Schnittstellenpartner).
5. Erarbeitetes Verständnis festhalten (Kommentar, README, Skizze) — im Legacy-Umfeld ist jede Analysestunde teuer; sie unvermerkt verfallen zu lassen, ist Verschwendung (`skill-program-analysis.md`, `skill-documentation-writing.md`).

**SOLL:**
6. Nähte schaffen statt umbauen: Um zu ändernde Logik testbar zu machen, die kleinste Trennstelle einziehen (Methode extrahieren, Abhängigkeit als Parameter), nicht das Modul neu schneiden (Sprout/Wrap-Technik: Neues in neuen, getesteten Einheiten anbauen, Altes nur dünn anzapfen).
7. Neue Funktionalität bevorzugt in neuem, testbarem Code neben dem Altbestand bauen und schmal integrieren — statt tief im Altcode zu weben.
8. Bei Ablösung: Strangler-Ansatz (Stück für Stück umleiten, Alt und Neu parallel, Vergleichsmessung) statt Big-Bang-Rewrite. Rewrites unterschätzen systematisch die unsichtbaren 50 % Fachlogik — genau die Randfälle, wegen derer das Alte so aussieht, wie es aussieht.
9. Hotspots priorisieren: Verbesserung nur dort investieren, wo oft geändert wird (git log). Ruhender Altcode bleibt in Ruhe — dokumentiert, aber unangetastet.
10. Domänen-Hinweise ernst nehmen: In SQL-lastigen Systemen steckt Geschäftslogik oft in Views/Prozeduren/Triggern — Codelektüre allein reicht nicht; in RPG/Batch-Welten sind Ablaufsteuerung (CL, Scheduler) und Dateiformate Teil des Verhaltens.

**KANN:**
11. Golden-Master-Tests für Output-lastige Systeme (Reports, Exporte): kompletten Output einfrieren und diffen — grob, aber als Sicherheitsnetz schnell aufgebaut.
12. Beim Arbeiten eine „Landkarte" des Systems mitpflegen (Module, Flüsse, Gefahrenzonen) — sie wird zum wertvollsten Dokument des Systems.

## Arbeitsablauf

1. **Auftrag eingrenzen:** Was genau soll sich ändern — und was ausdrücklich nicht?
2. **Stelle verstehen:** Leitfragen-Analyse (`skill-program-analysis.md`), Historie der Stelle (blame, Tickets), Konsumenten des Verhaltens identifizieren.
3. **Netz spannen:** Charakterisierungs-/Golden-Master-Tests oder dokumentierte Vergleichsläufe für das Ist-Verhalten.
4. **Naht schaffen (falls nötig):** kleinste Trennstelle für Testbarkeit — als eigener, verhaltensneutraler Schritt (`skill-refactoring.md`).
5. **Ändern:** minimal-invasiv; Neues bevorzugt in neuen Einheiten.
6. **Vergleichen:** Netz grün bzw. Vergleichslauf identisch (außer der beabsichtigten Änderung — die explizit benennen).
7. **Wissen sichern:** Erkenntnisse, Gefahrenzonen, offene Fragen dokumentieren.

## Checkliste

- [ ] Ist das Ist-Verhalten gesichert, bevor ich ändere?
- [ ] Ist mein Eingriff der kleinste, der den Auftrag erfüllt?
- [ ] Habe ich unverstandene Sonderfälle aufgeklärt oder konserviert (nicht gelöscht)?
- [ ] Weiß ich, wer/was das bisherige Verhalten konsumiert?
- [ ] Sind beabsichtigte Verhaltensänderungen explizit benannt und abgestimmt?
- [ ] Habe ich mein erarbeitetes Verständnis festgehalten?
- [ ] Steckt Logik außerhalb des Codes (SQL-Prozeduren, Trigger, Jobs, Makros) — und habe ich dort nachgesehen?

## Typische Fehler

- **Rewrite-Reflex:** „Das schreibe ich in zwei Wochen neu." Nach vier Monaten kann die Neufassung 80 % — es fehlen genau die Randfälle, die das Alte hässlich machten.
- **Zaun abreißen:** Den „sinnlosen" Sonderfall entfernen. Drei Wochen später meldet sich der Großkunde, für den er gebaut wurde.
- **Aufräumen im Vorbeigehen:** Beim Bugfix „nur kurz" Struktur verbessert — in Code ohne Netz. Der Diff ist groß, das Risiko unkalkulierbar, das Review unmöglich.
- **Doku glauben:** Das Systemhandbuch von 2015 beschreibt Version 2015. Verhalten heute zählt (`skill-program-analysis.md`, Grundsatz 3).
- **Bug fixen, der keiner ist:** Das „falsche" Verhalten korrigieren, auf das drei nachgelagerte Systeme kalibriert sind.
- **Analyse ohne Konserve:** Zwei Tage Verständnis erarbeitet, nichts notiert — der Nächste zahlt dieselben zwei Tage.
- **Modernisierung als Moralfrage:** Alt = schlecht setzen. Maßstab ist ökonomisch: Was kostet der Zustand, was kostet die Änderung (`skill-clean-code-analysis.md`).

## Beispiele

**Gut:** Auftrag: Mehrwertsteuersatz-Änderung im Fakturierungs-Altsystem. Vorgehen: Steuerberechnungsstellen per Suche gefunden (3 Stellen — Duplikat!), Golden-Master über 200 echte Rechnungen gezogen, Satz an allen 3 Stellen geändert, Vergleichslauf: nur Steuerfelder differieren, erwartungsgemäß. Nebenbefund dokumentiert: Duplikat-Logik + eine Stelle rundet abweichend (Fachbereich bestätigt: gewollt für Fall X, seit 2018). Kein Umbau — aber Landkarte aktualisiert.

**Schlecht:** Gleicher Auftrag — die drei Stellen „bei der Gelegenheit" zu einer generischen Steuer-Engine konsolidiert, ohne Netz. Die gewollte Sonderrundung ist weg; fällt beim Jahresabschluss auf.

## Eskalation

- Ist-Verhalten nicht mit vertretbarem Aufwand sicherbar (kein Vergleichslauf möglich, keine Testdaten) → Risiko explizit machen und Freigabe für das Restrisiko einholen; nie stillschweigend ungesichert ändern.
- Sonderfall betrifft erkennbar Geld/Compliance und ist nicht aufklärbar → nicht anfassen, Entscheidung mit Fachbereich/Verantwortlichen.
- Auftrag verlangt faktisch Teil-Neubau (Änderung unmöglich ohne großen Umbau) → Aufwand/Risiko als Entscheidungsvorlage, ggf. Strangler-Pfad vorschlagen (`skill-task-decomposition.md`).
- Kritisches Wissen hängt an einer bald wegfallenden Person → sofort `skill-knowledge-transfer.md` auslösen; das ist dringlicher als das aktuelle Ticket.
