# skill-module-design

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Zuschnitt von Modulen, Paketen, Namespaces, Services · **Empfohlene Einsatzkontexte:** Strukturentscheidungen, Reviews, Refactoring-Planung

**Kurzfassung:** Ein Modul ist gut, wenn man es ändern kann, ohne die anderen zu verstehen: hohe Kohäsion (was sich zusammen ändert, wohnt zusammen), kleine bewusste öffentliche Oberfläche, Abhängigkeiten in eine Richtung — die Struktur folgt der Fachlichkeit, nicht dem Dateityp.

## Skill-Name

Modul-Design

## Zweck

Module sind die Einheiten, in denen Teams denken, ändern und Verantwortung tragen. Guter Zuschnitt entscheidet, ob eine Änderung ein Modul betrifft oder fünf, ob ein Neuer einen Bereich lernen kann oder das Ganze. Dieser Skill liefert die Entwurfs- und Prüfregeln — die Konstruktionsseite zu `skill-design-smell-detection.md` (Symptomseite).

## Einsatzbereich

- Zuschnitt neuer Module/Pakete/Namespaces; Bewertung bestehender Strukturen
- Entscheidung, wo neuer Code hingehört
- Vorstufe von Service-Schnitten (`skill-architecture-thinking.md`, Regel 6)

## Denkweise

Denke in **Wohngemeinschaften des Wandels**: Was sich aus demselben Grund ändert, gehört zusammen; was sich aus verschiedenen Gründen ändert, gehört getrennt. Nicht „alle Controller zu den Controllern" (Struktur nach Dateityp), sondern „alles zur Rechnungsstellung zur Rechnungsstellung" — denn Änderungen kommen als Fachanliegen, nicht als Schichtanliegen.

Zweites Bild: **Ein Modul ist ein Haus mit Haustür.** Die öffentliche Oberfläche (das, was andere Module benutzen dürfen) ist die Haustür — klein, bewusst, gepflegt. Interna sind die Zimmer: frei umbaubar, solange die Tür gleich bleibt. Ein Modul, dessen Interna überall direkt benutzt werden, hat keine Tür — es ist eine Ruine, durch deren Wände alle laufen; jeder Umbau trifft Unbekannte.

## Kernregeln

**MUSS:**
1. Zuschnitt nach Fachlichkeit/Änderungsgrund, nicht nach technischem Typ: `billing/`, `inventory/`, `customer/` statt `controllers/`, `helpers/`, `models/` als oberste Ordnung. (Technische Schichten dürfen *innerhalb* eines Fachmoduls existieren.)
2. Öffentliche Oberfläche bewusst und minimal halten: Jedes öffentlich gemachte Element ist ein Vertrag mit Pflegekosten (`skill-api-design.md`, Regel 13). Default ist intern; öffentlich wird, was ein anderer nachweislich braucht.
3. Abhängigkeiten gerichtet halten: Zyklen zwischen Modulen sind ein Befund, keine Geschmacksfrage — sie machen Module untrennbar (nicht einzeln testbar, verstehbar, ersetzbar). Richtung: Spezielles hängt von Allgemeinem ab, Fachkern nicht von Infrastruktur-Details (`skill-architecture-thinking.md`, Regel 5).
4. Eine Fachregel wohnt in genau einem Modul — das Modul, dem die Daten fachlich „gehören", beherbergt die Logik dazu (gegen Feature Envy, `skill-design-smell-detection.md`, Regel 3).
5. Vor dem Anlegen eines neuen Moduls prüfen, ob Bestehendes der richtige Ort ist — und vor dem Einsortieren in „utils/common/shared" prüfen, ob es einen fachlichen Ort gibt. Sammelmodule sind der Friedhof der Zuordnungsentscheidungen, die niemand treffen wollte.

**SOLL:**
6. Kohäsions-Test pro Modul: „Nutzen die Bestandteile einander tatsächlich — oder teilen sie nur einen Ordnernamen?" Module, deren Hälften nichts voneinander brauchen, sind zwei Module.
7. Kopplungs-Test pro Änderung: „Wie viele Module muss ich für diese Fachänderung anfassen und verstehen?" Regelmäßig > 2 → Zuschnitt prüfen (Shotgun Surgery).
8. Modulgrenzen mit Werkzeugen absichern, wo verfügbar (Projekt-/Paketgrenzen, Sichtbarkeitsmodifizierer, Architektur-Tests) — unerzwungene Grenzen erodieren unter Termindruck.
9. Gemeinsame Nutzung bewusst entscheiden: Bevor zwei Module dasselbe brauchen und es in „shared" wandert — prüfen, ob es wirklich dasselbe Konzept ist oder nur ähnlicher Code (zufällige vs. echte Gemeinsamkeit, `skill-abstraction-judgment.md`).
10. Ein Modul soll in den Kopf eines Menschen passen: Wenn niemand mehr das ganze Modul überblickt, ist es ein Kandidat für Teilung — entlang der Änderungsgründe, nicht der Dateigröße.

**KANN:**
11. Pro Modul eine Kurz-README (Zweck, Tür/öffentliche Oberfläche, Gefahrenzonen) — Minuten Aufwand, großer Einarbeitungsgewinn (`skill-documentation-writing.md`).
12. Co-Änderungs-Analyse aus git nutzen (welche Dateien ändern sich zusammen?) — sie zeigt den faktischen Zuschnitt, der dem gewollten oft widerspricht.

## Arbeitsablauf

1. **Änderungsgründe sammeln:** Welche Fachanliegen treffen diesen Bereich? (Aus Tickets/Historie, nicht aus der Vorstellung.)
2. **Wohngemeinschaften bilden:** Was ändert sich zusammen → ein Modul; was unabhängig → getrennt.
3. **Türen definieren:** Pro Modul die minimale öffentliche Oberfläche festlegen; Rest intern.
4. **Abhängigkeitsrichtung prüfen:** Zyklen auflösen (gemeinsames Konzept extrahieren oder Abhängigkeit umkehren), bevor sie sich einnisten.
5. **Grenzen erzwingen:** Sichtbarkeit, Paketstruktur, ggf. Architektur-Tests.
6. **Nachhalten:** Bei jeder Shotgun-Änderung fragen, ob der Zuschnitt noch stimmt.

## Checkliste

- [ ] Oberste Ordnung fachlich, nicht nach Dateityp?
- [ ] Öffentliche Oberfläche minimal und bewusst (Default intern)?
- [ ] Keine Zyklen; Abhängigkeiten in eine Richtung; Fachkern infrastrukturfrei?
- [ ] Jede Fachregel in genau einem Modul, beim Daten-Eigentümer?
- [ ] Kein wachsendes utils/common ohne Zuordnungsentscheidung?
- [ ] Besteht das Modul den Kohäsions-Test (Bestandteile brauchen einander)?
- [ ] Fachänderungen fassen typischerweise ≤ 2 Module an?

## Typische Fehler

- **Schichten-Ordner als Weltbild:** `controllers/`, `services/`, `repositories/` als oberste Ebene — jede Fachänderung schneidet durch alle Ordner, nichts hängt sichtbar zusammen.
- **Türenlose Module:** Alles public, jeder greift überall zu. Der erste Umbau bricht 30 unbekannte Nutzer (`skill-change-impact-analysis.md`).
- **utils.py, 4.000 Zeilen:** Der Sammelort für alles Heimatlose — höchste Kopplung im Repo, jeder hängt daran, niemand versteht es ganz.
- **Zyklus per Bequemlichkeit:** `billing` braucht kurz was aus `shipping`, das schon `billing` nutzt — „nur dieser eine Import". Ab jetzt sind es siamesische Zwillinge.
- **Shared auf Verdacht:** Ähnliche DTOs zweier Module „vereinheitlicht" — ab da zwingt jede Änderung des einen Fachbereichs dem anderen ein Deployment auf (zufällige Gemeinsamkeit gekoppelt).
- **Modul = Person:** Zuschnitt nach „das macht Klaus" statt nach Fachlichkeit. Wenn Klaus geht, ist die Grenze sinnlos.

## Beispiele

**Zuschnitt-Entscheidung:** Neuer Code „Mahnwesen": Option A: in `invoicing/` (nutzt Rechnungen). Prüfung der Änderungsgründe: Mahnstufen/-fristen ändern sich aus eigenen fachlichen Gründen (Forderungsmanagement), unabhängig von Rechnungserstellung; eigene Ansprechpartner. → Eigenes Modul `dunning/` mit Tür `DunningService.ProcessOverdueInvoices()`, liest Rechnungen nur über die öffentliche Oberfläche von `invoicing`. Ergebnis: Mahnlogik-Änderungen fassen ein Modul an.

**Zyklus aufgelöst:** `orders` ↔ `customers` (Orders braucht Kundendaten, Customers listet Bestellungen). Auflösung: `customers` verliert die Bestellliste — die gehört fachlich zu `orders` (`GetOrdersByCustomer` wohnt dort). Richtung jetzt: `orders → customers`, nie zurück.

## Eskalation

- Zuschnitt-Korrektur wäre ein Großumbau (Kernmodule verfilzt) → Kosten/Nutzen als Entscheidungsvorlage (`skill-architecture-thinking.md`); Zwischenschritt: Grenzen erst dokumentieren und einfrieren (nicht schlimmer werden lassen), dann schrittweise entflechten.
- Modulgrenze fällt mit Teamgrenze zusammen und ist strittig → Organisationsentscheidung, nicht im Code austragen (`skill-design-smell-detection.md`, Eskalation).
- Uneinigkeit, wem Daten/Logik fachlich „gehören" → Fachbereich/Domänenverantwortliche klären lassen; der Code kann die Frage nicht beantworten.
