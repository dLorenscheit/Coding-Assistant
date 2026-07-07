# skill-debugging

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Fehlersuche bei unbekannter Ursache · **Empfohlene Einsatzkontexte:** Bugs, Produktionsvorfälle, „funktioniert bei mir nicht"

**Kurzfassung:** Erst reproduzieren, dann Hypothesen bilden und einzeln mit Experimenten widerlegen/bestätigen, pro Experiment genau eine Variable ändern, Suchraum halbieren — gefixt ist erst, wenn die belegte Ursache behoben und der Fix am Reproduktionsfall bewiesen ist.

## Skill-Name

Debugging

## Zweck

Unsystematisches Debugging („mal hier was ändern, mal da schauen") kostet Stunden und endet oft in Symptomfixes, die den Bug nur verschieben. Dieser Skill macht Fehlersuche zu einem Erkenntnisprozess: Hypothese → Experiment → Beleg. Das Ziel ist nicht „der Fehler ist weg", sondern „ich weiß, warum er auftrat, und kann zeigen, dass er es nicht mehr tut".

## Einsatzbereich

- Jeder Fehler, dessen Ursache nicht belegt bekannt ist (bekannte Ursache → direkt `skill-code-implementation.md`)
- Produktionsvorfälle (dort zusätzlich: erst stabilisieren, dann forschen)
- „Heisenbugs": sporadische, last- oder timing-abhängige Fehler
- Vertiefung für Ursachenketten über Systeme hinweg: `skill-root-cause-analysis.md`

## Denkweise

Denke wie ein Arzt, nicht wie ein Handwerker mit Ersatzteilkiste: Erst Anamnese (was genau, seit wann, unter welchen Bedingungen), dann Diagnose (belegte Ursache), dann Therapie (Fix). Wer Teile tauscht, bis das Symptom weg ist, hat nichts geheilt — er hat es maskiert.

Merksatz: **Der Fehler ist immer logisch — nur deine Annahmen sind falsch.** Der Computer würfelt nicht. Wenn das Verhalten „unmöglich" erscheint, ist eine deiner Gewissheiten falsch. Debugging heißt: herausfinden, welche. Kandidaten in dieser Reihenfolge prüfen: (1) Läuft überhaupt der Code, den ich anschaue (Version, Deployment, Cache, Build-Artefakt)? (2) Sind die Daten die, die ich annehme? (3) Ist der Ablauf der, den ich annehme?

## Kernregeln

**MUSS:**
1. **Reproduzieren vor allem anderen.** Ein Fehler, den man nicht auslösen kann, kann man nicht verstehen und keinen Fix beweisen. Wenn Reproduktion unmöglich: Beobachtbarkeit erhöhen (Logging, Metriken) ist der eigentliche erste Arbeitsschritt.
2. Pro Experiment genau **eine** Variable ändern. Wer drei Dinge gleichzeitig ändert und der Fehler verschwindet, weiß nichts.
3. Hypothesen vor dem Experiment aufschreiben („Ich glaube X, weil Y — wenn X stimmt, muss Experiment Z das zeigen"). Debug-Log führen: Was wurde probiert, was kam heraus. Nach zwei Stunden ohne Log dreht man Schleifen.
4. Zuerst verifizieren, dass der betrachtete Code der laufende Code ist (Version/Deployment/Cache) — die peinlichste und häufigste verlorene Stunde.
5. Der Fix gilt erst als Fix, wenn: (a) die Ursache benannt und belegt ist, (b) der Reproduktionsfall vor dem Fix fehlschlägt und danach besteht, (c) erklärt ist, warum genau dieses Symptom aus dieser Ursache folgt. Alle drei — sonst ist es ein Symptomfix.
6. Alle Experimentier-Reste (Debug-Ausgaben, auskommentierte Checks, Test-Hacks) vor Abschluss entfernen.

**SOLL:**
7. Suchraum systematisch halbieren (binäre Suche): funktionierender vs. kaputter Zustand — in der Zeit (git bisect), im Datenfluss (wo ist der Wert zuletzt korrekt?), im Stack (Schicht für Schicht).
8. „Was hat sich geändert?" früh fragen: letzte Deployments, Config-Änderungen, Datenänderungen, Abhängigkeits-Updates. Die meisten neuen Fehler haben neue Ursachen.
9. Fehlermeldungen wörtlich ernst nehmen und vollständig lesen — inklusive innerer Exceptions und der *ersten* Fehlermeldung im Log (Folgefehler lenken ab).
10. Bei sporadischen Fehlern nach dem Muster suchen (Uhrzeit, Last, Datenkonstellation, Parallelität) statt auf erneutes Auftreten zu hoffen.

**KANN:**
11. Rubber-Duck-Erklärung: den Fehler jemandem (oder schriftlich) komplett erklären — oft fällt die falsche Annahme dabei selbst auf.
12. Nach dem Fix suchen: Wo könnte derselbe Fehlertyp noch stecken? (Gleiche Ursache, andere Stelle.)

## Arbeitsablauf

1. **Anamnese:** Symptom exakt erfassen (Fehlermeldung wörtlich, betroffene Fälle, seit wann, wie oft). Erwartung vs. Beobachtung notieren.
2. **Reproduzieren:** Kleinsten auslösenden Fall bauen. Gelingt es nicht → Beobachtbarkeit erhöhen und auf nächstes Auftreten vorbereiten.
3. **Verifizieren, was läuft:** Richtige Version, richtige Umgebung, richtige Daten?
4. **Hypothese bilden:** Aus Symptom + „was hat sich geändert" + Codelektüre. Aufschreiben.
5. **Experimentieren:** Eine Variable, klares erwartetes Ergebnis, Resultat ins Log. Hypothese bestätigt → weiter zu 6; widerlegt → zurück zu 4 (mit neuem Wissen).
6. **Ursache belegen und fixen:** Fix an der Ursache; Reproduktionsfall als Test verankern; Erklärungskette dokumentieren.
7. **Aufräumen und berichten:** Debug-Reste entfernen; Ursache, Beleg und Fix knapp festhalten (fürs Team und für `skill-change-documentation.md`).

## Checkliste

- [ ] Kann ich den Fehler auslösen (oder habe ich Beobachtbarkeit geschaffen)?
- [ ] Habe ich verifiziert, dass ich den laufenden Code/die echten Daten betrachte?
- [ ] Steht jede Hypothese samt Experimentergebnis im Log?
- [ ] Habe ich pro Experiment nur eine Variable geändert?
- [ ] Ist die Ursache belegt und erklärt das Symptom vollständig?
- [ ] Schlägt der Reproduktionsfall vor dem Fix fehl und besteht danach?
- [ ] Sind alle Debug-Reste entfernt?

## Typische Fehler

- **Shotgun-Debugging:** Wahllos Dinge ändern, bis das Symptom verschwindet. Der Bug ist nicht weg, er ist umgezogen.
- **Symptomfix:** Null-Check an der Absturzstelle statt Klärung, warum der Wert null war. Der Datenfehler wandert stumm weiter.
- **Falscher Code:** Eine Stunde in einer Datei suchen, die gar nicht deployt ist. Regel 4 zuerst.
- **Fixierung auf die Lieblingshypothese:** Belege ignorieren, die dagegen sprechen; nur Bestätigung suchen. Gegenmittel: aufschreiben, was die Hypothese widerlegen würde — und genau das testen.
- **Folgefehler jagen:** Die dritte Exception im Log debuggen statt der ersten.
- **„Kann nicht sein"-Blockade:** Verhalten für unmöglich erklären statt die eigene Annahme zu suchen, die falsch ist.
- **Fix ohne Beweis:** „Müsste jetzt gehen" — ohne den Reproduktionsfall erneut auszuführen.

## Beispiele

**Gut:** Symptom: Import bricht sporadisch nachts ab. Anamnese: nur Dienstag/Donnerstag, seit 14 Tagen. „Was änderte sich?" → neuer Backup-Job, gleiche Zeit. Hypothese: Lock-Konkurrenz auf Tabelle X. Experiment: Backup manuell während Test-Import starten → reproduziert. Beleg: DB-Lock-Log. Fix: Import-Transaktion verkürzt + Retry; Reproduktionsszenario als Test dokumentiert. Erklärungskette vollständig.

**Schlecht:** Gleiche Lage — „wahrscheinlich Speicherproblem", RAM verdoppelt, zwei Wochen Ruhe (Zufall), dann wieder Abbruch. Zwei Wochen verloren, nichts gelernt.

## Eskalation

- Produktionsvorfall mit laufendem Schaden → erst stabilisieren (Rollback, Feature abschalten), dann forschen. Stabilisierung dokumentieren, Beweise (Logs, Dumps) vorher sichern.
- Nach zwei belegbar widerlegten Hypothesen ohne neuen Kandidaten → Zwischenstand mit Log teilen, zweites Paar Augen oder tieferes Modell holen. Nicht stundenlang allein kreisen.
- Verdacht auf Fehler außerhalb des eigenen Einflussbereichs (Framework, Treiber, Fremd-API) → minimalen Reproduktionsfall bauen und an den Verantwortlichen geben; Workaround separat entscheiden.
- Fehler betrifft Datenintegrität (falsche Buchungen, korrupte Datensätze) → sofort melden; Umfang des Schadens klären hat Vorrang vor dem Code-Fix.
