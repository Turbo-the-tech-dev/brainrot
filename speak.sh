#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================
set -euo pipefail

TARGET_MD="GEMINI_BRAINROT.md"

if [[ ! -f "$TARGET_MD" ]]; then
    printf ">> [ERROR] %s not found.\n" "$TARGET_MD"
    exit 1
fi

printf ">> [SYSTEM] Extracting latest neural thought...\n"

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# Validation gate: Reject shell metacharacters to prevent injection
if printf "%s" "$LAST_THOUGHT" | grep -qE '[\\`$;&|"]'; then
    printf ">> [SECURITY] Malicious input detected. Abortion initiated.\n"
    exit 1
fi

printf ">> [SPEAKING] \"%s\"\n" "$LAST_THOUGHT"

# Pipe to Termux TTS if available
if command -v termux-tts-speak >/dev/null 2>&1; then
    termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"
else
    printf ">> [WARN] termux-tts-speak not found. Simulation mode active.\n"
fi

printf ">> [SUCCESS] Vocalization complete.\n"
