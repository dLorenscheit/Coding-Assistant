# skill-function-design

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Entwurf und Bewertung von Funktionen/Methoden · **Empfohlene Einsatzkontexte:** Implementierung, Reviews, Refactoring

**Kurzfassung:** Eine Funktion hat eine Aufgabe und eine ehrliche Signatur: Effekte, die die Signatur verschweigt, sind der Kernfehler — nicht die Zeilenzahl. Eingaben rein, Ergebnis raus, Überraschungen null; Länge ist Hinweis, Verantwortung ist Maßstab.

## Skill-Name

Funktions-Design

## Zweck

Funktionen sind die kleinste Einheit, in der Verstehen und Testen stattfindet. Dieser Skill liefert das Prüfraster: Wann ist eine Funktion gut geschnitten, wann ist sie ein Risiko — und woran erkennt man den Unterschied jenseits von Dogmen wie „maximal 20 Zeilen"?

## Einsatzbereich

- Schreiben neuer Funktionen; Zerlegen zu großer
- Review-Bewertung („zu lang?" ist die falsche Frage — dieser Skill stellt die richtigen)
- Testbarkeits-Diagnose: schwer testbare Funktionen sind fast immer schlecht geschnitten

## Denkweise

Lies jede Signatur als Vertrag: **Eingaben → Ergebnis.** Alles, was die Funktion darüber hinaus tut oder braucht — globaler Zustand, versteckte Schreibzugriffe, Uhrzeit, Netzwerk — ist Kleingedrucktes, das der Aufrufer nicht sieht und der Tester nachbauen muss. Die Qualität einer Funktion misst sich daran, wie wenig Kleingedrucktes sie hat.

Zur Größenfrage: **Länge ist ein Symptom, Verantwortung der Befund.** Die richtige Frage ist nicht „wie viele Zeilen?", sondern: „Kann ich in einem Satz ohne ‚und' sagen, was sie tut?" Eine 60-Zeilen-Funktion, die einen Ablauf linear erzählt, ist besser als sechs 10-Zeilen-Splitter, zwischen denen der Leser springt und Zustand im Kopf trägt (`skill-complexity-control.md`).

## Kernregeln

**MUSS:**
1. Ein-Satz-Test: Was die Funktion tut, muss in einem Satz ohne „und" sagbar sein. Braucht es „und", ist es meist zwei Funktionen — oder eine Orchestrator-Funktion, die zwei benannte Schritte aufruft (das ist legitim: koordinieren *ist* eine Aufgabe).
2. Keine versteckten Effekte: Was die Funktion außer dem Rückgabewert verändert (Objektzustand, DB, Datei, globale Variable), muss aus Name + Signatur erkennbar sein (`skill-naming.md`, Regel 1). Command und Query trennen: Entweder etwas verändern oder etwas beantworten — Funktionen, die beim Abfragen heimlich schreiben, sind Fallen.
3. Keine versteckten Eingaben in Logik-Funktionen: Uhrzeit, Config, globaler Zustand als Parameter hereinreichen statt drinnen ziehen — sonst ist die Funktion nicht testbar und ihr Verhalten nicht aus dem Aufruf ablesbar.
4. Ehrliche Rückgaben: kein `null` als Sonderbedeutung ohne Dokumentation im Typ (Optional/Nullable/Result), keine Magic-Rückgabewerte (`-1` = nicht gefunden), keine halbbefüllten Objekte im Fehlerfall.
5. Boolean-Parameter, die das Verhalten umschalten (`process(order, true, false)`), vermeiden: Am Aufrufer ist unlesbar, was passiert. Stattdessen zwei benannte Funktionen oder ein benanntes Options-/Enum-Argument.

**SOLL:**
6. Parameterzahl klein halten (Richtwert ≤ 3–4): Mehr Parameter deuten auf ein fehlendes Konzept — zusammengehörige Parameter zu einem benannten Typ bündeln (`(street, city, zip)` → `Address`).
7. Eine Abstraktionsebene pro Funktion: Fachliche Schritte und Bit-Gefummel nicht mischen — der Leser muss nicht pro Zeile die Flughöhe wechseln. Details in benannte Unterfunktionen, wenn sie den Fluss stören.
8. Guard Clauses zuerst: Vorbedingungen am Anfang prüfen und früh zurückkehren — statt den Happy Path in drei `if`-Ebenen einzupacken (`skill-readability.md`).
9. Erst beim zweiten echten Bedarf parametrisieren: Eine Funktion nicht auf Vorrat mit Optionen ausstatten (`skill-abstraction-judgment.md`).
10. Fehlerverhalten pro Funktion bewusst wählen und konsistent zum Repo (werfen? Result? — `skill-error-handling.md`, Regel 7–8).

**KANN:**
11. Reine Funktionen (gleiche Eingabe → gleiches Ergebnis, keine Effekte) bevorzugen, wo es natürlich geht — sie sind trivial testbar und gefahrlos wiederverwendbar. Effekte an den Rand des Ablaufs schieben, Kern rein halten.
12. Lange, aber lineare Abläufe (Setup-Skripte, Report-Aufbau) als eine erzählende Funktion mit Abschnitts-Kommentaren belassen, statt künstlich zu zersplittern.

## Arbeitsablauf

1. **Aufgabe in einem Satz formulieren** — geht es nicht, erst die Verantwortung klären.
2. **Signatur zuerst entwerfen:** Was rein, was raus, welche Fehler? Signatur einem imaginären Aufrufer vorlesen: versteht er den Vertrag?
3. **Kleingedrucktes eliminieren:** versteckte Ein-/Ausgaben zu Parametern/Rückgaben machen oder in den Aufrufer heben.
4. **Körper linear erzählen:** Guards zuerst, eine Flughöhe, Details auslagern nur wo sie den Fluss stören.
5. **Test schreiben:** Fällt der Test schwer (viel Setup, viele Mocks) → zurück zu Schritt 3, die Funktion ist falsch geschnitten.

## Checkliste

- [ ] Ein Satz ohne „und"?
- [ ] Alle Effekte aus Name + Signatur erkennbar (Command/Query getrennt)?
- [ ] Keine versteckten Eingaben (Zeit, Config, Globals) in Logik?
- [ ] Rückgaben ehrlich (kein bedeutungsschwangeres null/-1)?
- [ ] Keine verhaltensschaltenden Boolean-Parameter?
- [ ] ≤ 3–4 Parameter oder benanntes Bündel?
- [ ] Guards zuerst, eine Abstraktionsebene?
- [ ] Leicht testbar ohne Mock-Orgie?

## Typische Fehler

- **Der Doppelagent:** `validateOrder` validiert — und korrigiert nebenbei still die Daten. Zwei Aufgaben, eine davon geheim.
- **Zeilen-Dogma:** Funktionen auf 10 Zeilen zerhacken, bis die Logik über acht private Methoden verschmiert ist — Verstehen erfordert jetzt Sprünge und mentalen Stack. Das Gegenteil von lesbar.
- **Flag-Parameter-Wildwuchs:** `export(data, true, false, true)` — niemand kann den Aufruf lesen; jede neue Option verdoppelt die Pfade.
- **Uhr im Keller:** `isExpired()` zieht `DateTime.Now` intern — der Test für „läuft morgen ab" braucht jetzt Zeitreisen oder bleibt ungeschrieben.
- **Halbfertig-Rückgabe:** Im Fehlerfall ein Objekt mit teilbefüllten Feldern zurückgeben — der Aufrufer kann Erfolg nicht von Trümmern unterscheiden.
- **Parameter-Lawine:** 9 Parameter, davon 4 fast immer null — das fehlende Konzept (ein Request-Objekt, ein Kontext) wurde nie gebaut.

## Beispiele

**Kleingedrucktes → ehrlicher Vertrag:**
```csharp
// vorher: versteckte Eingabe (Now), versteckter Effekt (schreibt!), lügender Name
bool CheckDiscount(Order o) {
    if (o.Created < DateTime.Now.AddDays(-30)) { o.Discount = 0; return false; }
    return true;
}
// nachher: reine Prüfung, Zeit als Parameter, Schreiben liegt sichtbar beim Aufrufer
bool IsDiscountEligible(Order o, DateTime now) => o.Created >= now.AddDays(-30);
// Aufrufer: if (!IsDiscountEligible(order, clock.Now)) order.Discount = 0;
```
Testbar ohne Tricks, Verhalten am Aufrufer ablesbar, keine Überraschung.

**Flag → benannte Absicht:** `sendInvoice(order, true)` → `sendInvoiceCopy(order)` und `sendInvoiceOriginal(order)` — der Aufruf dokumentiert sich selbst.

## Eskalation

- Funktion lässt sich nicht schneiden, weil Verantwortungen im umgebenden Modul verfilzt sind → Modul-Befund (`skill-module-design.md`, `skill-separation-of-concerns.md`), nicht an der Funktion herumdoktern.
- Signaturänderung beträfe viele Aufrufer oder öffentliche Verträge → Wirkradius prüfen (`skill-change-impact-analysis.md`), ggf. als eigenes Refactoring (`skill-refactoring.md`).
- Bestand nutzt bewusst ein anderes Muster (z. B. Output-Parameter überall) → Konsistenzfrage klären statt Einzelinsel bauen (`skill-consistency.md`).
