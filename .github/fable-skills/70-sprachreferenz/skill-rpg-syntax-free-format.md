# skill-rpg-syntax-free-format

**Version:** 1.0 · **Stand:** 2026-07-08 · **Gültigkeitsbereich:** Syntax-Referenz für **FREE, ILE RPG (RPG IV) und SQLRPGLE · **Empfohlene Einsatzkontexte:** Jede Erstellung/Änderung von Free-Format-RPG-Code, insbesondere bei Unsicherheit über korrekte Syntax

**Kurzfassung:** Verlässliche Syntax-Fakten statt Erinnerung — Trainingsdaten zu RPG sind dünn und oft mit RPG III/COBOL/C vermischt; bei jeder Unsicherheit hier nachschlagen statt aus Analogie zu anderen Sprachen zu raten.

## Skill-Name

RPG-Syntax-Referenz (Free-Format)

## Zweck

Kompensiert die Wissenslücke: RPG/IBM i ist im Trainingsmaterial selten, oft veraltet oder mit anderen Sprachen vermengt. Dieser Skill hält die syntaktischen Grundfakten von **FREE fest, die typischerweise falsch erinnert oder aus C#/Java/COBOL analogisiert werden — als Nachschlagewerk, nicht als Stilvorgabe (Stil regelt `skill-agent-rpg-coder.md`).

## Einsatzbereich

- Neuer Code oder Änderungen in **FREE, ILE RPG (RPG IV) und SQLRPGLE
- Vor allem bei Unsicherheit: Deklarationssyntax, Kontrollstrukturen, eingebettetes SQL, BIFs
- Nicht für spaltengebundenes RPG III/RPG400 → `skill-rpg-syntax-fixed-format.md`
- Nicht für Stilfragen (Bestandsstil, Modernisierung, Verifikationspflicht) → die jeweiligen Agenten-/Engineering-Skills

## Denkweise

Ein Compiler ist gnadenlos exakt; ein Sprachmodell „erinnert sich" an Syntax aus wenigen, oft widersprüchlichen Quellen. Deshalb: **Nachschlagen schlägt Erinnern.** Bei jedem Zweifel gilt diese Datei (bzw. im Zweifel die IBM-Doku) als Quelle der Wahrheit, nicht das „sieht plausibel aus" eines Modells, das auch Delphi, COBOL und C kennt und die Syntaxen mischt.

## Kernregeln

**MUSS:**
1. Jede Anweisung endet mit `;` — auch Deklarationen, Zuweisungen, Aufrufe. Kein Zeilenende ersetzt das Semikolon.
2. Quelltyp `**FREE` steht allein in Zeile 1 (kein Spaltenzwang danach); Kommentare mit `//` (Zeilenkommentar). Block-Kommentare `/* ... */` sind selten und meist vermeidbar.
3. Deklarationen: `dcl-s name typ [inz(wert)];`, `dcl-c name wert;`, `dcl-ds name [qualified] [likeds(...)] [dim(n)]; ... end-ds;`, `dcl-pr name [rückgabetyp]; ... end-pr;`, `dcl-proc name; dcl-pi *n [rückgabetyp]; ... end-pi; ... end-proc;`. `*n` bei `dcl-pi` bedeutet: Name kommt von `dcl-proc`.
4. Kontrollstrukturen und ihr exaktes Ende: `if/elseif/else/endif`, `dow/enddo`, `dou/enddo`, `for/endfor`, `select/when/other/endsl`, `monitor/on-error/endmon`. `end` allein existiert nicht als Kontrollstruktur-Ende — nie `end;` schreiben, wenn `endif`/`enddo`/`endsl` gemeint ist.
5. Vergleichsoperatoren: `=`, `<>`, `>`, `<`, `>=`, `<=`, `and`, `or`, `not` — **kein** `==`, `!=`, `&&`, `||`, `!`.
6. Zuweisung ist `=` (implizites EVAL) — kein `:=`, kein `eval` erforderlich (aber erlaubt, wenn Optionen wie `eval(h)` gebraucht werden).
7. Eingebettetes SQL: `exec sql ... ;` bzw. `exec sql ... end-exec;` (Semikolon-Form ist Standard in **FREE); Host-Variablen werden **ohne** Doppelpunkt referenziert (anders als in C/COBOL-Embedded-SQL); nach jeder SQL-Anweisung `sqlstate`/`sqlcode` prüfen.
8. Prozeduraufrufe sind implizit (`meineProc(param1 : param2);`), kein `CALLP` in **FREE nötig; Parameterliste mit `:` getrennt, nicht `,`.

**SOLL:**
9. Häufige BIFs korrekt: `%len`, `%trim`/`%triml`/`%trimr`, `%subst`, `%char`, `%dec`, `%int`, `%found`, `%eof`, `%open`, `%error`, `%parms`, `%elem`, `%addr`. String-Verkettung mit `+` (mit Blank-Behandlung) oder `%trim(a) + %trim(b)`.
10. Datei-Deklaration: `dcl-f Dateiname usage(*input : *output : *update) keyed;` — `usage` als Liste, nicht mehrere Schlüsselwörter.
11. Konstanten/Prototypen aus `/copy` bzw. `/include` übernehmen statt Werte hart zu codieren.

**KANN:**
12. `%bif`-Kurzformen wie `%int(x)` und `%dec(x:p:s)` verwenden statt manueller Konvertierung.

## Arbeitsablauf

1. Vor dem Schreiben klären: Ziel ist **FREE/SQLRPGLE (nicht Fixed-Format) — sonst `skill-rpg-syntax-fixed-format.md`.
2. Deklarationsart wählen (Regel 3) und exakte End-Schlüsselwörter der Kontrollstrukturen prüfen (Regel 4).
3. Bei eingebettetem SQL: Host-Variablen ohne Doppelpunkt, `sqlstate` danach behandeln (Regel 7).
4. Nach dem Schreiben: jede Zeile gegen Kernregeln 1–8 gegenprüfen, insbesondere Semikolons und End-Schlüsselwörter.
5. Bei Restunsicherheit: nicht raten, im Briefing/Rückgabe als offene Frage benennen (siehe Eskalation).

## Checkliste

- [ ] Jede Anweisung mit `;` beendet?
- [ ] Kontrollstruktur-Enden exakt (`endif`/`enddo`/`endsl`/`endfor`/`endmon`, nie bloßes `end`)?
- [ ] Keine `==`, `!=`, `&&`, `||`, `:=` im Code?
- [ ] Eingebettetes SQL ohne Doppelpunkt vor Host-Variablen, mit `sqlstate`-Prüfung?
- [ ] Prozeduraufruf-Parameter mit `:` getrennt, nicht `,`?
- [ ] Keine C#/Java/COBOL-Idiome eingestreut (z. B. `//` ist ok, aber keine `{ }`-Blöcke, kein `;;`)?

## Typische Fehler

- **`end;` statt `endif;`/`enddo;`** — Compiler-Fehler, weil `end` keine eigenständige Kontrollstruktur-Endung ist.
- **C-Vergleichsoperatoren** (`==`, `!=`, `&&`) aus Trainingsdaten anderer Sprachen übernommen.
- **Doppelpunkt vor Host-Variablen** in `EXEC SQL` (`:variable`) — das ist C-/COBOL-Embedded-SQL-Syntax, in RPG falsch.
- **Parameterliste mit Komma** statt Doppelpunkt bei Prozeduraufrufen (`proc(a, b)` statt `proc(a : b)`).
- **`dcl-pi` ohne `*n`** oder mit eigenem, abweichendem Namen, obwohl der Prozedurname aus `dcl-proc` gemeint ist.
- **Fixed-Format-Reste** in **FREE-Membern (z. B. Spaltenbezug, Denken in Formularpositionen) — beide Welten nicht mischen.

## Beispiele

**Gut:**
```
dcl-proc getPreis;
  dcl-pi *n packed(9:2);
    pArtikel char(10) const;
  end-pi;
  dcl-s preis packed(9:2) inz(0);

  exec sql
    select preis into :preis
    from artikel
    where artikelnr = :pArtikel;

  if sqlstate <> '00000';
    preis = 0;
  endif;

  return preis;
end-proc;
```

**Schlecht (typische Modell-Halluzination):**
```
dcl-proc getPreis;
  dcl-pi *n packed(9:2);
    pArtikel char(10) const;
  end-pi;
  dcl-s preis packed(9:2) inz(0);

  exec sql
    select preis into :preis
    from artikel
    where artikelnr = :pArtikel
  end-exec

  if (sqlstate != '00000') {
    preis = 0;
  }

  return preis;
end
```
Fehler: fehlendes Semikolon nach der SQL-Anweisung, `!=` statt `<>`, C-Blockklammern `{ }`, `end` statt `end-proc;`.

## Eskalation

- Syntaxfrage betrifft eine seltene/neue Sprachfunktion (z. B. neue **FREE-BIFs aktueller Release-Stände) und ist hier nicht abgedeckt → gegen aktuelle IBM-Doku oder Compile-Versuch verifizieren, nicht raten.
- Unsicherheit bleibt nach Prüfung bestehen → im Rückgabeformat als offene Annahme benennen, nicht stillschweigend eine Variante wählen.
