# skill-abstraction-judgment

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Entscheidung, wann und wie abstrahiert wird · **Empfohlene Einsatzkontexte:** Implementierung, Reviews, Refactoring-Entscheidungen

**Kurzfassung:** Duplikation ist billiger als die falsche Abstraktion: erst beim dritten echten Fall und stabilem Muster abstrahieren (Dreierregel), nur echte Gemeinsamkeit (gleicher Änderungsgrund) zusammenfassen — und eine Abstraktion, die Parameter-Schalter sammelt, wieder auflösen statt weiter füttern.

## Skill-Name

Abstraktions-Urteilsvermögen

## Zweck

Abstraktion ist das mächtigste und das am meisten missbrauchte Werkzeug im Handwerkskasten. Richtig eingesetzt bündelt sie eine Wahrheit an einem Ort; falsch eingesetzt koppelt sie Dinge, die nichts verbindet, und zwingt jede künftige Änderung durch ihr Nadelöhr. Dieser Skill liefert die Entscheidungsregeln: wann abstrahieren, wann duplizieren, wann eine bestehende Abstraktion rückbauen.

## Einsatzbereich

- „Das sieht ähnlich aus — zusammenfassen?" (die tägliche Frage)
- Review von neuen Interfaces, Basisklassen, generischen Helfern
- Diagnose leidender Abstraktionen (Flag-Parameter, Typ-Checks, Sonderfälle)

## Denkweise

Der Kernsatz, den jeder Junior verinnerlichen sollte: **Duplikation ist ein sichtbares, billiges Problem — die falsche Abstraktion ist ein unsichtbares, teures.** Zwei duplizierte Stellen kann jeder verstehen und unabhängig ändern. Eine falsche Abstraktion sieht ordentlich aus, aber jede Änderung an einem Nutzer muss durch sie hindurch und alle anderen Nutzer mitdenken — und der Rückbau wird mit jedem neuen Nutzer teurer.

Entscheidend ist der Unterschied zwischen **echter und zufälliger Gemeinsamkeit**: Echt gemeinsam ist, was sich aus demselben *fachlichen Grund* gleich verhält (Mehrwertsteuerberechnung überall gleich, weil es dasselbe Gesetz ist). Zufällig gemeinsam ist, was heute nur *ähnlich aussieht* (zwei Formulare mit denselben drei Feldern). Echte Gemeinsamkeit divergiert nie — zufällige divergiert garantiert, und dann kämpft die Abstraktion gegen ihre Nutzer.

Prüffrage: **„Wenn sich Fall A morgen ändert — muss B sich zwingend mitändern?"** Ja → echte Gemeinsamkeit, abstrahieren legitim. Nein → nur Ähnlichkeit, Duplikation ist der ehrlichere Zustand.

## Kernregeln

**MUSS:**
1. Dreierregel: Vor dem dritten echten Anwendungsfall wird keine verallgemeinernde Abstraktion gebaut. Zwei Fälle zeigen Ähnlichkeit; erst der dritte zeigt das Muster (und widerlegt meist die Verallgemeinerung, die man nach zweien gebaut hätte).
2. Nur echte Gemeinsamkeit abstrahieren (gleicher Änderungsgrund, s. o.) — nicht optische Ähnlichkeit. Fachliche Duplikate mit demselben Änderungsgrund dagegen *müssen* zusammengezogen werden (`skill-maintainability.md`, Regel 2 — kein Widerspruch: dort ist die Gemeinsamkeit echt).
3. Keine Abstraktion für hypothetische Zukunft: kein Interface „falls wir mal einen zweiten Provider haben", keine Konfigurierbarkeit ohne konkreten zweiten Nutzer (YAGNI). Der zweite Fall darf die Abstraktion bezahlen, wenn er kommt — er kommt meist anders als gedacht.
4. Leidende Abstraktionen erkennen und behandeln statt füttern: Wenn ein gemeinsamer Baustein Flag-Parameter, Typ-Abfragen (`if (x is SpecialCase)`) oder „nur für Y"-Sonderpfade sammelt, ist die Gemeinsamkeit zerbrochen. Der richtige Schritt ist **Inline-then-split**: Abstraktion in die Nutzer zurückkopieren, dann jeden Nutzer vereinfachen — nicht der vierte Flag.
5. Eine Abstraktion muss dicht sein: Wenn Nutzer regelmäßig ihre Interna kennen/umgehen müssen, kostet sie doppelt (Indirektion *plus* Durchgriff) — abdichten oder entfernen (`skill-design-smell-detection.md`, Regel 4).

**SOLL:**
6. So spät und so konkret wie möglich abstrahieren: Die beste Abstraktion wird aus real existierenden Fällen *extrahiert* (Muster liegt vor), nicht vorab *entworfen* (Muster wird geraten).
7. Abstraktionshöhe klein halten: die konkrete Hilfsfunktion vor der generischen Engine; drei benannte Varianten vor einem Strategie-Framework. Aufsteigen kann man immer, absteigen fast nie.
8. Fremd-Abstraktionen (Frameworks, Basisklassen von Bibliotheken) an der eigenen Grenze halten: dünne eigene Schicht um fremde Konzepte, wo sie tief ins Fachmodell wachsen würden (`skill-maintainability.md`, Framework-Verwachsung).
9. Beim Review neuer Abstraktionen die Nutzerzahl erfragen: „Wie viele echte Nutzer hat das heute?" Eine Abstraktion mit einem Nutzer ist ein Kredit ohne Gegenwert — als Befund benennen (spekulative Struktur).

**KANN:**
10. Bewusste Duplikation mit Querverweis-Kommentar markieren („bewusst dupliziert zu X, siehe skill-abstraction-judgment: Fälle divergieren fachlich") — nimmt dem nächsten Leser den Zusammenzieh-Reflex.
11. Bei Unsicherheit die Duplikation 1–2 Änderungszyklen beobachten: Ändern sich die Stellen tatsächlich gemeinsam? Die Historie beantwortet, was die Diskussion nicht kann.

## Arbeitsablauf

1. **Ähnlichkeit gefunden → Gemeinsamkeits-Test:** Gleicher fachlicher Änderungsgrund? (Prüffrage: Muss B sich mitändern, wenn A sich ändert?)
2. **Fallzahl prüfen:** Weniger als drei echte Fälle → duplizieren, ggf. mit Querverweis, beobachten.
3. **Bei echtem Muster: extrahieren statt entwerfen** — die Abstraktion aus den vorliegenden Fällen herausschälen, minimal halten.
4. **Namen und Vertrag schärfen:** Die Abstraktion muss in einem Satz sagbar sein (`skill-function-design.md`, Regel 1) — geht das nicht, war es keine.
5. **Bestehende leidende Abstraktion:** Flags/Typ-Checks/Sonderpfade zählen → ab 2–3: Inline-then-split vorschlagen, Aufwand gegen Weiterleiden abwägen.

## Checkliste

- [ ] Habe ich ≥ 3 echte Fälle (oder einen belegten gemeinsamen Änderungsgrund)?
- [ ] Ist die Gemeinsamkeit fachlich (ändert sich zwingend zusammen) statt optisch?
- [ ] Baue ich nichts für hypothetische zweite Nutzer?
- [ ] Ist die Abstraktion extrahiert (aus Realfällen) statt entworfen (aus Vermutung)?
- [ ] Sammelt keine bestehende Abstraktion, die ich anfasse, Flags/Typ-Checks (sonst: rückbauen statt füttern)?
- [ ] Ist sie dicht (Nutzer müssen Interna nicht kennen)?
- [ ] Ist bewusste Duplikation als solche markiert?

## Typische Fehler

- **DRY als Reflex:** Jede optische Ähnlichkeit sofort zusammenziehen. Drei Monate später: `sharedProcess(data, mode, isSpecial, skipValidation)` — vier Nutzer, sechs Flags, niemand ändert es ohne Angst.
- **Das Ein-Nutzer-Interface:** `IOrderProcessor` mit genau einer Implementierung `OrderProcessor` — Indirektion ohne Gegenwert, Navigation und Verständnis verteuert. (Ausnahme mit Grund: echte Testbarkeits- oder Modulgrenze — dann ist der Grund benennbar.)
- **Framework auf Vorrat:** Plugin-System, Rule-Engine, generischer Importer — für den einen Fall, der existiert. Der zweite Fall kommt anders oder nie.
- **Füttern statt heilen:** Die leidende Abstraktion bekommt den fünften Sonderfall-Parameter, weil Rückbau „jetzt zu teuer" ist. Er wird jeden Monat teurer.
- **Vererbung als Code-Sharing:** Basisklasse `BaseManager`, damit drei Klassen eine Hilfsmethode teilen — jetzt erben sie auch Lebenszyklus und Annahmen, die nicht passen. Komposition (Hilfsfunktion reingeben) hätte gereicht.
- **Rückbau-Tabu:** Abstraktionen gelten als Errungenschaft, ihr Entfernen als Rückschritt. Falsch: Inline-then-split ist oft der größte Wartbarkeitsgewinn im Bestand.

## Beispiele

**Dreierregel richtig gelebt:** CSV-Export für Kunden gebaut. Zwei Wochen später: CSV-Export für Bestellungen — 70 % ähnlich. Entscheidung: duplizieren mit Querverweis. Monat später: dritter Export (Lieferanten) — jetzt zeigt sich das echte Muster: gleich sind Escaping/Encoding/Streaming (technisch, ein Änderungsgrund), verschieden sind Spaltenwahl und Formatierung (fachlich, je eigener Grund). Extrahiert wird genau der technische Kern (`CsvWriter`); die Fachteile bleiben pro Export. Nach zwei Fällen hätte man vermutlich die Spaltenlogik mitverallgemeinert — falsch.

**Inline-then-split:** `renderDocument(doc, isInvoice, isReminder, skipFooter)` — drei Flags, zwei Typ-Checks. Rückbau: Funktion in die drei Aufrufer kopiert, je Aufrufer auf seinen Fall reduziert → `renderInvoice`, `renderReminder`, `renderQuote`, gemeinsam bleibt nur `renderHeader/Footer`. Diff größer, System kleiner.

## Eskalation

- Leidende zentrale Abstraktion mit vielen Nutzern (Rückbau = Großumbau) → als strukturellen Befund mit Schadensszenario und schrittweisem Rückbauplan vorlegen (`skill-clean-code-analysis.md`), nicht heimlich beginnen.
- Team-Konvention erzwingt Abstraktion (z. B. „jede Klasse braucht ein Interface") → Konvention hinterfragen als Teamentscheidung (`skill-consistency.md`, `skill-decision-records.md`), nicht einzeln brechen.
- Unklar, ob Gemeinsamkeit fachlich echt ist (ändern sich A und B zusammen?) → Fachbereich fragen oder Historie auswerten — nicht raten; die Antwort entscheidet die Struktur.
