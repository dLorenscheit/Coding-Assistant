# install-fable.ps1 — installiert das Fable-Skill-System PROJEKTLOKAL in ein Zielprojekt.
#
# Seit Layout 2.0 liegt alles unter .claude\ — manuell genuegt daher:
#   .claude\  und  CLAUDE.md  aus dem Fable-Repo ins Zielprojekt kopieren.
# Dieses Skript macht dasselbe, aber sicher und idempotent:
#   - ueberschreibt keine fremden Dateien in .claude\ (nur agents-Dateien + fable-skills\)
#   - haengt bei vorhandener Projekt-CLAUDE.md nur den Fable-Block an (nie doppelt)
#   - warnt bei Altlasten aus dem 1.x-Layout (<Projekt>\fable-skills\)
#
# Nutzung (aus dem Fable-Skills-Ordner heraus):
#   powershell -File .\install-fable.ps1 -Target "<Pfad zum Zielprojekt>"
#
# Erneut ausfuehren, um ein Projekt nach Aenderungen im Fable-Repo zu aktualisieren
# (Kopien werden ersetzt; die Projekt-CLAUDE.md bleibt unangetastet).
#
# Optional: -RemoveGlobal entfernt die 8 Fable-Agenten aus ~\.claude\agents\
# (Altbestand der frueheren globalen Installation — projektlokale Agenten genuegen).

param(
    [Parameter(Mandatory = $true)]
    [string]$Target,

    [switch]$RemoveGlobal
)

$ErrorActionPreference = 'Stop'

$sourceRoot   = $PSScriptRoot
$agentsSource = Join-Path $sourceRoot '.claude\agents'
$skillsSource = Join-Path $sourceRoot '.claude\fable-skills'

# --- Quelle und Zielprojekt pruefen ------------------------------------------

foreach ($src in @($agentsSource, $skillsSource)) {
    if (-not (Test-Path $src)) {
        Write-Error "Quellordner fehlt im Fable-Repo: $src"
        exit 1
    }
}

if (-not (Test-Path $Target)) {
    Write-Error "Zielprojekt nicht gefunden: $Target"
    exit 1
}
$targetRoot = (Resolve-Path $Target).Path

$srcNorm = $sourceRoot.TrimEnd('\').ToLower()
$tgtNorm = $targetRoot.TrimEnd('\').ToLower()
if ($tgtNorm -eq $srcNorm -or $tgtNorm.StartsWith($srcNorm + '\')) {
    Write-Error "Zielprojekt liegt im Fable-Skills-Ordner selbst - hier ist nichts zu installieren."
    exit 1
}

# --- 1. Skills -> <Projekt>\.claude\fable-skills\ (komplett ersetzen) --------

$skillsTarget = Join-Path $targetRoot '.claude\fable-skills'
if (Test-Path $skillsTarget) {
    Remove-Item -Path $skillsTarget -Recurse -Force
}
New-Item -ItemType Directory -Force -Path (Join-Path $targetRoot '.claude') | Out-Null
Copy-Item -Path $skillsSource -Destination (Join-Path $targetRoot '.claude') -Recurse -Force
Write-Host "Skills + INDEX.md + Betriebsanleitung -> $skillsTarget"

# --- 2. Subagenten -> <Projekt>\.claude\agents\ (nur eigene Dateien) ---------

$agentsTarget = Join-Path $targetRoot '.claude\agents'
$agents = Get-ChildItem -Path $agentsSource -Filter '*.md'
if ($agents.Count -eq 0) {
    Write-Error "Keine Agenten-Dateien in $agentsSource gefunden."
    exit 1
}

New-Item -ItemType Directory -Force -Path $agentsTarget | Out-Null
foreach ($agent in $agents) {
    Copy-Item -Path $agent.FullName -Destination (Join-Path $agentsTarget $agent.Name) -Force
}
Write-Host "$($agents.Count) Subagenten -> $agentsTarget"

# --- 3. Projekt-CLAUDE.md (anlegen bzw. Fable-Block anhaengen) ---------------

$projectClaudeMd = Join-Path $targetRoot 'CLAUDE.md'
$importLine = '@.claude/fable-skills/FABLE-AGENT.md'
$block = @'
## Fable-Agent (aktiv)

@.claude/fable-skills/FABLE-AGENT.md

Dieses Projekt nutzt das Fable-Skill-System als Coding-Agent (projektlokal, alles unter `.claude/`).
Falls der Import oben nicht automatisch geladen wurde: Lies zu Sitzungsbeginn
`.claude/fable-skills/FABLE-AGENT.md` und befolge sie.
'@

if (Test-Path $projectClaudeMd) {
    $existing = Get-Content -Path $projectClaudeMd -Raw
    if ($existing -like "*$importLine*") {
        Write-Host "Projekt-CLAUDE.md enthaelt den Fable-Import bereits - unveraendert."
    } else {
        Add-Content -Path $projectClaudeMd -Value "`r`n$block" -Encoding UTF8
        Write-Host "Fable-Block an bestehende Projekt-CLAUDE.md angehaengt."
        if ($existing -like '*fable-skills/CLAUDE.md*') {
            Write-Host "HINWEIS: Alter Fable-Block (1.x, verweist auf fable-skills/CLAUDE.md) in der Projekt-CLAUDE.md gefunden - bitte manuell entfernen."
        }
    }
} else {
    Copy-Item -Path (Join-Path $sourceRoot 'CLAUDE.md') -Destination $projectClaudeMd -Force
    Write-Host "Projekt-CLAUDE.md aus Vorlage angelegt."
}

# --- 4. Altlasten aus dem 1.x-Layout melden ----------------------------------

$oldSkills = Join-Path $targetRoot 'fable-skills'
if (Test-Path $oldSkills) {
    Write-Host "HINWEIS: Altes Layout gefunden: $oldSkills - wird nicht mehr benutzt und kann nach Pruefung geloescht werden."
}

# --- Optional: Altbestand der globalen Installation entfernen ----------------

if ($RemoveGlobal) {
    $globalAgents = Join-Path $env:USERPROFILE '.claude\agents'
    foreach ($agent in $agents) {
        $globalCopy = Join-Path $globalAgents $agent.Name
        if (Test-Path $globalCopy) {
            Remove-Item -Path $globalCopy -Force
            Write-Host "Global entfernt: $($agent.Name)"
        }
    }
}

Write-Host ""
Write-Host "Fable-Agent projektlokal installiert in: $targetRoot"
Write-Host "Verfuegbar nach dem naechsten Start von Claude Code im Zielprojekt."
