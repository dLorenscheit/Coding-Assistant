# skill-handover

**Version:** 1.0 · **Stand:** 2026-07-02 · **Gültigkeitsbereich:** Übergabe von Arbeit, Verantwortung oder Systemen an andere (Menschen oder Modelle) · **Empfohlene Einsatzkontexte:** Urlaubs-/Personalwechsel, Projektübergaben, Session-Enden, Staffelstab zwischen Modellen

**Kurzfassung:** Zustand statt Chronik übergeben: Ziel & Stand, nächste Schritte, verworfene Wege, Gefahrenzonen, Zugänge — Halbfertiges explizit listen und die Übergabe am Empfänger testen.

## Skill-Name

Übergabe (Handover)

## Zweck

Bei jeder Übergabe geht Wissen verloren — die Frage ist nur, wie viel und wie teuer. Der Übergebende hat Kontext im Kopf, der nirgendwo steht: offene Fäden, halbfertige Gedanken, „das darf man auf keinen Fall anfassen", „das habe ich schon probiert, funktioniert nicht". Dieser Skill strukturiert Übergaben so, dass der Übernehmende **handlungsfähig** ist, ohne den Übergebenden fragen zu können. Der Maßstab ist hart: Eine Übergabe ist erst dann gut, wenn der Übergebende ab morgen unerreichbar sein könnte.

## Einsatzbereich

- Personalwechsel, Urlaub, Teamwechsel, Renteneintritt
- Projekt-/Verantwortungsübergaben zwischen Teams
- Ende einer Arbeits-Session mit halbfertigem Stand (auch: Modell übergibt an nächste Session oder an anderes Modell)
- Übergabe eines Systems in den Betrieb/an die Wartung

## Denkweise

Denke wie ein Pilot beim Schichtwechsel im Cockpit: Er übergibt nicht „das Flugzeug", sondern den **Zustand**: Wo sind wir, wohin wollen wir, was ist ungewöhnlich, was ist als Nächstes zu tun, was wurde bereits versucht. Die Maschine selbst (der Code) ist sichtbar — der Zustand des Fluges (die Arbeit daran) ist es nicht. Genau dieser unsichtbare Zustand ist der Inhalt einer Übergabe.

Kernsatz für Junioren: **Übergib nicht, was du getan hast — übergib, was der Nächste wissen muss, um weiterzumachen.** Das ist nicht dasselbe: Deine Chronologie interessiert ihn nur, wo sie ihm Irrwege erspart.

Zweiter Grundsatz: **Negative Erkenntnisse sind Übergabe-Gold.** „Ansatz X haben wir verworfen, weil Y" erspart dem Nächsten Tage. Genau dieses Wissen steht nie im Code und verdunstet als Erstes.

## Kernregeln

**MUSS:**
1. Jede Übergabe beantwortet schriftlich fünf Fragen: **(1) Ziel & Stand** — was soll erreicht werden, wo stehen wir (fertig/offen/halbfertig, je mit Ort im Code)? **(2) Nächste Schritte** — was wäre als Nächstes zu tun, in welcher Reihenfolge, warum? **(3) Verworfene Wege** — was wurde probiert/erwogen und warum verworfen? **(4) Gefahrenzonen** — was darf man nicht anfassen/ändern, welche nicht offensichtlichen Abhängigkeiten bestehen, welche Zeitbomben ticken? **(5) Zugänge & Ansprechpartner** — welche Systeme, Rechte, Personen braucht der Nächste?
2. Halbfertiges explizit kennzeichnen: Jeder halbfertige Zustand (Branch, Migration, deaktivierter Test, Feature-Flag, auskommentierter Block) wird gelistet mit „warum halbfertig" und „was fehlt bis fertig". Unkommentiertes Halbfertiges ist eine gelegte Falle.
3. Die Übergabe **am Empfänger testen**: Er wiederholt in eigenen Worten (oder führt einen Einstiegsschritt real aus), der Übergebende korrigiert. Ohne diese Schleife ist die Übergabe eine Sendung ohne Empfangsbestätigung.
4. Undokumentiertes Kopfwissen, das bei der Übergabe zutage tritt („ach ja, dazu muss man wissen…"), sofort festhalten — nicht auf später verschieben. Später ist der Übergebende weg.
5. Übergaben schriftlich und auffindbar ablegen (im Repo/Projektort, nicht in Chatverläufen oder Mail-Postfächern).

**SOLL:**
6. Nach Wichtigkeit ordnen, nicht nach Chronologie: Gefahrenzonen und nächster Schritt nach oben; Historie ans Ende oder weglassen.
7. Bei Systemübergaben zusätzlich: Wie merkt man, dass es dem System schlecht geht (Monitoring, typische Symptome), und was tut man dann (Verweis auf Runbook, `skill-runbook-writing.md`)?
8. Bei personellen Übergaben mit Vorlauf: Übergabe als **Begleitphase** planen (Übernehmender arbeitet, Übergebender assistiert) statt als Dokumenten-Stapel am letzten Tag. Ein gemeinsam gelöster Vorfall überträgt mehr als 20 Seiten.
9. Ehrlich sein über Zustand und Wackelstellen: Eine geschönte Übergabe („läuft alles") ist eine Falle für den Nachfolger. Bekannte Schwächen, Abkürzungen und technische Schulden gehören auf den Tisch.
10. Bei Session-Übergaben zwischen Modellen: den Zustand so schreiben, dass ein Modell **ohne** den bisherigen Konversationskontext weiterarbeiten kann — konkrete Dateipfade, exakte offene Punkte, ausgeführte vs. ausstehende Verifikationen.

**KANN:**
11. Eine „erste Woche"-Empfehlung mitgeben: Womit sollte der Übernehmende anfangen, um das System kennenzulernen (guter erster Bug, gute erste Lektüre)?
12. Offene Entscheidungen als Entscheidungsvorlagen übergeben (Optionen + Empfehlung), statt sie unentschieden im Raum zu lassen.

## Arbeitsablauf

1. **Inventur:** Alles Offene sammeln — Branches, Tickets, halbfertige Stände, mündliche Zusagen, gewusste-aber-nie-notierte Eigenheiten.
2. **Fünf Fragen beantworten:** Ziel & Stand, nächste Schritte, verworfene Wege, Gefahrenzonen, Zugänge (Regel 1) — schriftlich, nach Wichtigkeit geordnet.
3. **Halbfertiges entschärfen:** Wo möglich, halbfertige Stände vor Übergabe abschließen oder sauber zurückbauen. Was bleibt, wird explizit gelistet (Regel 2). Ein kleinerer, sauberer Übergabeumfang schlägt einen großen chaotischen.
4. **Ablegen und verlinken:** Dokument an den vereinbarten Ort, von den betroffenen Stellen (Ticket, README) darauf verweisen.
5. **Empfangsschleife:** Durchsprache mit dem Übernehmenden; er spielt einen Einstieg durch; Lücken sofort nachtragen.
6. **Restfragen-Kanal klären:** Falls der Übergebende noch begrenzt erreichbar ist: wie lange, wofür, auf welchem Weg — explizit vereinbaren statt stillschweigend annehmen.

## Checkliste

- [ ] Sind die fünf Kernfragen schriftlich beantwortet?
- [ ] Ist jeder halbfertige Zustand gelistet — mit Warum und Rest-Weg?
- [ ] Stehen Gefahrenzonen und verworfene Wege drin (nicht nur Erfolge)?
- [ ] Hat der Übernehmende die Übergabe in eigenen Worten gespiegelt oder einen Schritt real ausgeführt?
- [ ] Ist das Dokument dort abgelegt, wo der Nächste sucht?
- [ ] Sind alle Zugänge/Rechte geklärt (nicht nur benannt)?
- [ ] Würde die Übergabe funktionieren, wenn ich ab morgen unerreichbar bin?

## Typische Fehler

- **Chronik statt Zustand:** Zehn Seiten „was ich alles gemacht habe" — und der Nachfolger weiß trotzdem nicht, was er Montag zuerst tun soll.
- **Nur Erfolge übergeben:** Verworfene Ansätze und bekannte Wackelstellen fehlen. Der Nachfolger läuft in jede Sackgasse noch einmal.
- **Halbfertiges verschweigen:** Der ausgeschaltete Test, die halbe Migration im Branch — unerwähnt. Drei Monate später explodiert es, und niemand weiß, warum es so ist.
- **Übergabe als Monolog:** Dokument geschickt, Haken dran. Ob der Empfänger es verstanden hat (oder je gelesen), bleibt offen.
- **Zugänge vergessen:** Die perfekte Doku nützt nichts, wenn der Nachfolger drei Wochen auf DB-Rechte wartet. Zugänge sind Teil der Übergabe, nicht Verwaltungskram.
- **Letzte-Woche-Übergabe:** Jahrzehnte Wissen in fünf Tagen „übergeben" wollen. Wissenskonservierung braucht Vorlauf — je früher begonnen, desto mehr bleibt (siehe `skill-knowledge-transfer.md`).
- **Bei Modellen: Kontext-Illusion:** Eine Session-Übergabe schreiben, die nur mit dem bisherigen Gesprächsverlauf verständlich ist. Der Nächste hat diesen Verlauf nicht.

## Beispiele

**Session-Übergabe (Modell → nächste Session), gut:**
> **Ziel:** Rabattberechnung von `OrderService` in eigene Klasse `DiscountPolicy` extrahieren (Ticket SHOP-412).
> **Stand:** Extraktion fertig für Standardrabatte (`DiscountPolicy.cs`, Tests grün: `DiscountPolicyTests`, 11 Stück). Offen: Sonderfall Staffelrabatt — Logik steckt noch in `OrderService.cs:200–260`.
> **Nächster Schritt:** Staffelrabatt extrahieren; Vorsicht: die Methode mutiert `order.Items` (Sortierung!) — Verhalten muss erhalten bleiben, Test dafür fehlt noch (zuerst schreiben).
> **Verworfen:** Strategy-Pattern pro Kundentyp — überdimensioniert, nur 2 Varianten (mit D. am 30.06. abgestimmt).
> **Gefahr:** `LegacyPriceExport` liest Rabatte per Reflection aus `OrderService` — bei Feldumbenennung bricht er ohne Compilerfehler (`Export/LegacyPriceExport.cs:74`).
> **Verifikation ausstehend:** Integrationstest-Suite lokal nicht lauffähig (braucht DB-Container), im CI prüfen.

**Warnbeispiel:** „Habe am Rabatt-Refactoring gearbeitet, ist fast fertig, Rest ist selbsterklärend." — Keine Orte, keine Gefahren, kein nächster Schritt. Der Nachfolger bricht den Reflection-Zugriff und merkt es erst im Monatsexport.

## Eskalation

- Wenn absehbar ist, dass **kritisches Wissen nicht rechtzeitig übertragbar** ist (zu viel, zu wenig Zeit, Bus-Faktor 1): sofort an Verantwortliche melden mit Priorisierungsvorschlag — welche 20 % Wissen decken 80 % des Risikos?
- Wenn der Übernehmende erkennbar nicht befähigt oder nicht verfügbar ist (keine Zeit, fehlende Grundlagen): nicht still „an die Ablage" übergeben — das Problem benennen; eine Übergabe ohne Empfänger ist keine.
- Wenn bei der Inventur Risiken zutage treten (ungesicherte Produktionszugänge, tickende Zeitbomben, nie getestete Restore-Pfade): als eigene Befunde melden, nicht in der Übergabe-Doku verstecken.
- Wenn Zusagen an Dritte existieren, die der Übergebende mündlich gegeben hat: explizit klären, wer sie übernimmt oder absagt — sonst platzen sie unbemerkt.
