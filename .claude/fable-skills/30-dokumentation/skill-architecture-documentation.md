# skill-architecture-documentation

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Dokumentation von Systemstruktur und -entscheidungen · **Empfohlene Einsatzkontexte:** Systemüberblicke, Einarbeitung, Schnittstellen-Doku, Modernisierungs-Vorbereitung

**Kurzfassung:** Wenig, aber tragfähig: ein aktueller Systemüberblick (Kontext, Bausteine, Datenflüsse, Gefahrenzonen) plus verlinkte Entscheidungs-Records schlägt jedes 60-Seiten-Handbuch — dokumentiert wird, was Struktur erklärt und Code nicht zeigen kann; gepflegt wird bei jeder Strukturänderung oder gar nicht erst geschrieben.

## Skill-Name

Architektur-Dokumentation

## Zweck

Architektur-Doku beantwortet die Fragen, die kein Einzel-File beantwortet: Woraus besteht das System, wie hängen die Teile zusammen, wo fließen Daten, warum ist es so geschnitten — und wo sind die Minen? Sie ist das Einarbeitungs-Fundament und die Diskussionsgrundlage für jede Strukturänderung. Dieser Skill hält sie klein genug zum Pflegen und groß genug zum Tragen.

## Einsatzbereich

- Systemüberblick pro Repo/System (das eine Pflichtdokument)
- Vorbereitung von Modernisierung/Ablösung (Ist-Aufnahme, `skill-legacy-code-handling.md`, Regel 12)
- Schnittstellen-Landkarten zwischen Teams/Systemen
- Ergänzt: Entscheidungen einzeln in `skill-decision-records.md`, Betrieb in `skill-runbook-writing.md`

## Denkweise

Architektur-Doku ist eine **Landkarte, kein Livebild**: Karten zeigen bewusst nicht alles — sie zeigen, was man zum Navigieren braucht, auf der Flughöhe des Reisenden. Der Maßstab für jedes Element ist: *Hilft es jemandem, sich zu orientieren oder eine Strukturentscheidung zu treffen?* Klassendiagramme, die den Code nachzeichnen, sind kein Mehrwert — sie sind eine zweite, sofort veraltende Kopie der Wahrheit (das Was steht im Code; die Doku schuldet Struktur und Warum, `skill-documentation-writing.md`).

Pflege-Realismus als Entwurfsprinzip: **Jede Seite, die bei Strukturänderungen nicht mitgezogen wird, wird zur Falle.** Deshalb klein schneiden (eine Überblicksseite, wenige Diagramme), im Repo halten (Änderung im selben PR wie der Umbau) und alles Volatile (Klassennamen, Feldlisten, Versionsnummern) draußen lassen — dokumentiert wird die Ebene, die sich selten ändert.

## Kernregeln

**MUSS:**
1. Pro System existiert ein **Systemüberblick** (1–3 Seiten) mit genau diesen Teilen: **Zweck** (was tut das System, für wen) · **Kontext** (Nachbarsysteme und was über die Grenzen fließt) · **Bausteine** (die 5–15 Hauptteile und ihre Verantwortung, je 1–2 Sätze) · **Kern-Datenflüsse** (die 2–4 wichtigsten Abläufe Ende-zu-Ende) · **Gefahrenzonen** (fragile Bereiche, versteckte Kopplungen, Bus-Faktor-Wissen) · **Einstiegspunkte** (wo liest man weiter: ADRs, Runbook, Modul-READMEs).
2. Flughöhe halten: Bausteine und Beziehungen, keine Klassen und Methoden. Testfrage: Überlebt die Seite ein normales Refactoring unverändert? Wenn nein, ist sie zu tief.
3. Warum verlinken statt duplizieren: Strukturentscheidungen stehen in Decision Records (`skill-decision-records.md`); der Überblick verweist. Doppelt gepflegte Begründungen divergieren.
4. Im Repo, versioniert, und Pflege im Prozess verankert: Strukturänderungen (neuer Baustein, neue Schnittstelle, geänderter Datenfluss) ziehen die Doku im selben PR nach — sonst Verfallsdatum markieren (`skill-documentation-writing.md`, Regeln 4–5, 11).
5. Diagramme als Text-Quellen (Mermaid/PlantUML o. ä.) im Repo — Binär-Bilder ohne Quelle sind nach dem ersten Umbau unpflegbar und damit tot.

**SOLL:**
6. Kontext-Diagramm zuerst (System + Nachbarn + Flüsse): Es ist das wertvollste einzelne Bild — für Neue, für Impact-Analysen (`skill-change-impact-analysis.md`), für jede Schnittstellen-Diskussion.
7. Pro Diagramm eine Frage: „Wie fließt eine Bestellung?" oder „Wer spricht mit wem?" — nie „alles auf einmal". Mehr als ~15 Kästen = zwei Diagramme.
8. Die Gefahrenzonen ehrlich pflegen: der fragile Import, die Reflection-Kopplung, das Modul mit Bus-Faktor 1 — genau der Teil, den nur Insider wissen und der Neue am dringendsten braucht (`skill-handover.md`, Regel 1).
9. Bei Legacy-Systemen die Ist-Architektur dokumentieren, nicht die Soll-Erinnerung: aufschreiben, was belegt ist (`skill-program-analysis.md`, ✅/❓ — offene Fragen als solche kennzeichnen). Eine geschönte Karte führt in den Sumpf.
10. Aktualität prüfbar machen: Stand-Datum + „geprüft am" — und den Überblick bei Onboardings aktiv testen lassen (der Neue findet die Abweichungen, `skill-onboarding-juniors.md`, Regel 12).

**KANN:**
11. Für größere Landschaften geschachtelte Flughöhen (Landschaft → System → Baustein), jede Ebene nach demselben Muster — nur so tief, wie es reale Leser gibt.
12. Eine „Karte der Minenfelder" für Altsysteme als eigenes lebendes Dokument (`skill-legacy-code-handling.md`, Regel 12) — oft wertvoller als das Strukturbild.

## Arbeitsablauf

1. **Leserfrage klären:** Wer braucht Orientierung wofür (Einarbeitung? Umbau? Schnittstellen?)?
2. **Kontext zeichnen:** System, Nachbarn, Flüsse über die Grenzen.
3. **Bausteine schneiden:** Hauptteile mit Verantwortung in je 1–2 Sätzen — auf der Ebene, die Refactorings überlebt.
4. **Kernflüsse beschreiben:** die 2–4 wichtigsten Abläufe, je als kurze Stationsfolge.
5. **Gefahrenzonen und Einstiege ergänzen;** ADRs verlinken.
6. **Verifizieren:** gegen den Code prüfen (nicht gegen die Erinnerung); von einem Nicht-Autor gegenlesen lassen.
7. **Pflege verankern:** Doku-Pflicht bei Strukturänderungen in die Team-Konvention (`skill-consistency.md`).

## Checkliste

- [ ] Existiert der 1–3-Seiten-Überblick mit allen sechs Teilen?
- [ ] Überlebt jede Aussage ein normales Refactoring (richtige Flughöhe)?
- [ ] Sind Entscheidungen verlinkt statt dupliziert?
- [ ] Diagramme als Text-Quelle im Repo, pro Diagramm eine Frage?
- [ ] Sind die Gefahrenzonen ehrlich drin?
- [ ] Beschreibt die Doku das belegte Ist (nicht das erinnerte Soll)?
- [ ] Ist die Pflege an Strukturänderungen gekoppelt?

## Typische Fehler

- **Das 60-Seiten-Handbuch:** Vollständig bei Abgabe, falsch nach drei Monaten, gemieden für immer. Umfang ist der Feind der Pflege.
- **Code-Nachzeichnung:** Klassendiagramme mit 80 Kästen, generiert oder gemalt — veraltet beim nächsten Merge, orientiert niemanden.
- **Soll-als-Ist:** Die Doku zeigt die Architektur, wie sie gedacht war; die Ausnahmen und Direktzugriffe von fünf Jahren fehlen. Der Neue plant auf einer Fiktion.
- **Wiki-Exil:** Überblick in einem externen System, das bei Code-Änderungen niemand mitdenkt — nach einem Jahr traut ihm zu Recht niemand mehr (`skill-documentation-writing.md`, Wiki-Friedhof).
- **Bilder ohne Quelle:** Das schöne Visio-Diagramm, dessen Datei niemand mehr hat. Erste Änderung = Neuzeichnen = passiert nie.
- **Gefahrenzonen verschwiegen:** Die Karte zeigt saubere Kästen, verschweigt aber, dass Baustein C nachts direkt in die DB von D schreibt — genau das, was der Neue hätte wissen müssen.
- **Alles-Diagramm:** Ein Bild mit jedem System, jedem Fluss, jeder Ausnahme — beantwortet jede Frage schlecht statt eine gut.

## Beispiele

**Baustein-Beschreibung, richtige Flughöhe:**
> **Fakturierung (`/billing`):** Erzeugt Rechnungen aus abgeschlossenen Aufträgen (nächtlicher Lauf + manueller Einzelabruf). Führend für Rechnungsnummern und Steuerberechnung. Spricht: Auftragsmodul (liest über dessen API), DATEV-Export (schreibt Dateien), Mail-Versand (Events). ⚠️ Gefahrenzone: Steuerlogik existiert doppelt in `TaxCalc` und im DATEV-Export-SQL — Abweichung = Ticket BIL-203; Konsolidierung: ADR-011.

Zwei Sätze Verantwortung, Beziehungen, eine ehrliche Mine mit Verweis — das trägt Einarbeitung und Impact-Analyse. Kein Klassenname, der beim nächsten Refactoring bricht.

## Eskalation

- Beim Dokumentieren zeigt sich, dass niemand einen Bereich erklären kann (Bus-Faktor 0–1, widersprüchliche Aussagen) → das ist der eigentliche Befund: Wissenssicherung auslösen (`skill-knowledge-transfer.md`), Bereich als ❓ kartieren, nicht plausibel auffüllen.
- Ist-Aufnahme deckt ungewollte Struktur auf (Zyklen, Direktzugriffe unter Umgehung der Schnittstellen) → als Architektur-Befund melden (`skill-design-smell-detection.md`), in der Doku ehrlich als Ist einzeichnen — die Karte lügt nicht, auch nicht diplomatisch.
- Kein Mandat/keine Zeit für Pflege → lieber den kleinen gepflegten Kontext-Überblick als das ungepflegte Gesamtwerk; wenn selbst das nicht gewollt ist, Risiko benennen (Einarbeitungskosten, Fehlentscheidungen) und dokumentieren lassen, dass verzichtet wird.
- Zwei Teams beschreiben dieselbe Schnittstelle unterschiedlich → gemeinsame Klärung erzwingen — divergierende Landkarten sind ein Vorbote divergierender Systeme.
