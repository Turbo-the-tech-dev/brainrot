#!/bin/bash
set -euo pipefail
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

printf ">> [SYSTEM] Extracting latest neural thought...\n"

# Grab the last line, strip out the timestamps and formatting for clean audio
# Defensive check: ensure the file exists
if [[ ! -f "$TARGET_MD" ]]; then
    printf ">> [ERROR] %s not found.\n" "$TARGET_MD" >&2
    exit 1
fi

LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# Validation gate: Reject shell metacharacters to prevent command injection
# via $() or `` when the variable is expanded in double quotes.
if printf "%s" "$LAST_THOUGHT" | grep -qE '[\\`$;&|"]'; then
    printf ">> [ERROR] Malicious input detected in %s. Neural load rejected.\n" "$TARGET_MD" >&2
    exit 1
fi

printf ">> [SPEAKING] \"%s\"\n" "$LAST_THOUGHT"

# Pipe to Termux TTS if available
if command -v termux-tts-speak >/dev/null 2>&1; then
    termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"
else
    printf ">> [SIMULATION] termux-tts-speak not found. Audio: \"Sigma Protocol Update: %s\"\n" "$LAST_THOUGHT"
fi

printf ">> [SUCCESS] Vocalization complete.\n"
