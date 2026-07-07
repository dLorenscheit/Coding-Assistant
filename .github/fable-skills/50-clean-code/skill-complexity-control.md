# skill-complexity-control

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Erkennen und Begrenzen von Komplexität in Code und Design · **Empfohlene Einsatzkontexte:** Implementierung, Reviews, Design-Entscheidungen

**Kurzfassung:** Essenzielle Komplexität (das Problem ist schwer) akzeptieren und kapseln, hausgemachte (unsere Lösung macht es schwerer) unerbittlich bekämpfen: Zustand ist der größte Treiber — weniger veränderliche Variablen, weniger mögliche Zustände, weniger Sonderpfade; Cleverness ist ein Kostenfaktor, kein Ruhmesblatt.

## Skill-Name

Komplexitäts-Kontrolle

## Zweck

Komplexität ist der eigentliche Gegner: Sie macht Änderungen langsam, Bugs wahrscheinlich und Einarbeitung teuer — und sie wächst von allein, wenn niemand gegenhält. Dieser Skill trennt die Komplexität, die zum Problem gehört, von der, die die Lösung hinzufügt, und gibt konkrete Hebel, die zweite klein zu halten.

## Einsatzbereich

- Beim Schreiben: „Wird das gerade komplizierter als das Problem?"
- Im Review: Komplexitätszuwachs als eigenständiger Prüfpunkt
- Bei Designentscheidungen: Komplexitätsbudget mitverhandeln (`skill-architecture-thinking.md`, Regel 2)

## Denkweise

Unterscheide zwei Sorten: **Essenzielle Komplexität** steckt im Problem selbst (Steuerrecht *ist* kompliziert; Nebenläufigkeit *ist* schwer) — sie lässt sich nicht entfernen, nur an einem gut beschrifteten Ort kapseln. **Hausgemachte (akzidentelle) Komplexität** fügt die Lösung hinzu: unnötige Indirektion, geteilter veränderlicher Zustand, clevere Tricks, Sonderpfade, Technologie-Vielfalt. Die Kunst ist, beim Blick auf schwierigen Code sofort zu fragen: *Welcher Anteil davon ist das Problem — und welcher sind wir selbst?*

Der größte einzelne Treiber ist **Zustand**: Jede veränderliche Variable, jedes Flag, jeder Lebenszyklus multipliziert die Zahl der möglichen Systemzustände — und Verstehen heißt, alle möglichen Zustände denken zu können. Der wirksamste Hebel ist deshalb fast immer: weniger veränderlichen Zustand, kürzere Lebenszeiten, weniger mögliche Kombinationen (ungültige Zustände unrepräsentierbar machen, `skill-defensive-programming.md`, Regel 6).

## Kernregeln

**MUSS:**
1. Vor jedem Lösungsentwurf die Frage beantworten: Was ist die essenzielle Komplexität dieses Problems? Alles, was die Lösung darüber hinaus mitbringt, muss sich einzeln rechtfertigen.
2. Veränderlichen Zustand minimieren: Variablen so spät wie möglich, so lokal wie möglich, so unveränderlich wie möglich. Geteilter veränderlicher Zustand (zwischen Funktionen, Threads, Modulen) nur mit explizitem Grund und Schutzkonzept.
3. Zustandsräume klein schneiden: Kombinationen ausschließen statt behandeln (drei getrennte Booleans mit 8 Kombinationen, von denen 5 „nie vorkommen" → ein Enum mit 3 Werten). Was nicht existieren kann, muss nicht verstanden, getestet oder debuggt werden.
4. Cleverness als Kostenposten behandeln: Der Trick, der drei Zeilen spart, aber ein Denk-Rätsel hinterlässt (Bit-Magie, verschachtelte Ternaries, implizite Typkonversionen, Reflection wo Aufruf ginge), wird ausgeschrieben. Code wird für den Leser optimiert (`skill-readability.md`).
5. Komplexitätszuwachs im Review explizit machen: Ein Diff, der Sonderpfade, Flags, neue Zustände oder neue Technologien einführt, wird auf genau diesen Zuwachs geprüft — „funktioniert" reicht nicht, die Frage ist „was kostet das Verstehen ab jetzt?".

**SOLL:**
6. Verschachtelung flach halten (Richtwert ≤ 3 Ebenen): Guard Clauses, frühe Returns, Extraktion benannter Schritte — tiefe Verschachtelung ist fast immer versteckter Zustandsraum.
7. Sonderfälle an den Rand drängen: Erst den Regelfall gerade erzählen, Sonderfälle davor abfangen oder dahinter behandeln — nicht den Regelfall durch eingestreute Ausnahmen zerlöchern. Häufen sich Sonderfälle, das Modell hinterfragen (oft ist das „Sonder-" ein eigener Fall erster Klasse).
8. Technologie-Zoo begrenzen: Jede zusätzliche Sprache, Bibliothek, Infrastruktur ist Systemkomplexität — auch wenn jede für sich „einfach" ist (`skill-maintainability.md`, Regel 3).
9. Metriken (zyklomatische Komplexität, Verschachtelungstiefe) als Zeigefinger nutzen, nicht als Gesetz: Sie finden Kandidaten; das Urteil fällt am Verstehensaufwand (`skill-clean-code-analysis.md`, Regel 11).
10. Beim Wachsen gegensteuern: Wenn eine Einheit ihren dritten Sonderpfad bekommt, ist das der Moment für Strukturprüfung — nicht der zehnte.

**KANN:**
11. Komplexitäts-Hotspots kartieren (oft geändert × schwer verständlich) und gezielt vereinfachen — dort verzinst sich jede Vereinfachung sofort.
12. „Kann ich es einem Junior in 2 Minuten erklären?" als Schlusstest für eigene Lösungen — Scheitern heißt: vereinfachen oder dokumentieren.

## Arbeitsablauf

1. **Essenz bestimmen:** Was macht das Problem wirklich schwer? (Ein Satz.)
2. **Lösung dagegen halten:** Welche Konstrukte der Lösung dienen der Essenz — welche nur der Lösung selbst?
3. **Zustand inventarisieren:** Veränderliche Variablen, Flags, Lebenszyklen, geteilter Zustand — jeden Posten hinterfragen (nötig? lokalisierbar? unveränderlich machbar?).
4. **Zustandsraum schneiden:** Unmögliche Kombinationen per Typ/Enum/Invariante ausschließen.
5. **Fluss glätten:** Guards, Regelfall gerade, Sonderfälle an den Rand.
6. **Gegenlesen (lassen):** Der 2-Minuten-Junior-Test; im Review den Zuwachs benennen.

## Checkliste

- [ ] Kann ich Essenz und hausgemachten Anteil der Komplexität benennen?
- [ ] Ist veränderlicher Zustand minimal, lokal und kurzlebig?
- [ ] Sind unmögliche Zustandskombinationen ausgeschlossen statt behandelt?
- [ ] Verschachtelung ≤ 3 Ebenen, Regelfall gerade erzählt?
- [ ] Keine Cleverness, die ein Denk-Rätsel hinterlässt?
- [ ] Keine neue Technologie/Indirektion ohne benannten Gegenwert?
- [ ] Würde ein Junior es in 2 Minuten verstehen (oder gibt es die Warum-Doku)?

## Typische Fehler

- **Komplexität als Kompetenzbeweis:** Die generische, konfigurierbare, metaprogrammierte Lösung für ein einfaches Problem. Beeindruckt im PR, lähmt das Team zwei Jahre.
- **Flag-Akkumulation:** Jedes neue Bedürfnis ein Boolean (`isSpecial`, `skipCheck`, `legacyMode`) — nach acht Flags gibt es 256 theoretische Pfade und drei, die je getestet wurden.
- **Zustands-Spaghetti:** Felder, die von überall gesetzt werden, Reihenfolge-Abhängigkeiten („erst init() rufen!"), Wiederverwendung von Variablen für Verschiedenes.
- **Sonderfall-Erosion:** Der klare Ablauf bekommt pro Quartal ein `if (customer == 4711)` — nach zwei Jahren ist der Regelfall unauffindbar. (Fair bleiben: mancher Sonderfall ist essenziell — dann gehört er benannt und gekapselt, nicht eingestreut, `skill-legacy-code-handling.md`.)
- **Einzeiler-Stolz:** Die dreifach verschachtelte LINQ/Stream-Kette, die niemand debuggen kann. Kurz ist nicht einfach.
- **Vereinfachung am falschen Ort:** Die essenzielle Komplexität „wegvereinfachen" (Steuer-Sonderfälle ignorieren) — das ist kein Einfachheitsgewinn, sondern ein Korrektheitsverlust. Essenz wird gekapselt, nie geleugnet.

## Beispiele

**Zustandsraum geschnitten:**
```csharp
// vorher: 3 Flags, 8 Kombinationen, 5 davon "kommen nicht vor" (bis doch)
bool isPaid; bool isCancelled; bool isRefunded;
// nachher: 4 legale Zustände, Übergänge prüfbar, Unmögliches unrepräsentierbar
enum OrderState { Open, Paid, Cancelled, Refunded }
```
Jede Funktion, die vorher drei Flags konsultierte, prüft jetzt einen Zustand — und der Compiler kennt alle Fälle.

**Cleverness ausgeschrieben:** `active = accounts.GroupBy(a => a.CustomerId).Where(g => g.Any(x => (x.Flags & 0x4) != 0)).SelectMany(g => g)…` → drei benannte Schritte mit Zwischenvariablen (`customersWithActiveAccount`, …). Vier Zeilen mehr, null Rätsel — und der nächste Bug darin ist in Minuten statt Stunden gefunden.

## Eskalation

- Die essenzielle Komplexität selbst ist strittig („muss das Steuer-Modul wirklich alle 14 Sonderfälle können?") → Fach-/Produktfrage, klären lassen (`skill-requirements-analysis.md`) — Vereinfachung des Solls ist die stärkste Vereinfachung, aber nicht deine Entscheidung.
- Hausgemachte Komplexität steckt in zentraler Struktur (Framework-Eigenbau, God-Module) → struktureller Befund mit Rückbauplan (`skill-clean-code-analysis.md`, `skill-design-smell-detection.md`), kein Guerilla-Umbau.
- Nebenläufigkeits-Komplexität ohne etabliertes Muster im Repo → Architektur-/Senior-Review einholen; das ist die Komplexitätsklasse mit den teuersten stillen Fehlern (`skill-fable-sonnet.md`, Eskalation).
