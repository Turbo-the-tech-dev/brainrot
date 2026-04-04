#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

echo ">> [SYSTEM] Extracting latest neural thought..."

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# --- VALIDATION GATE ---
if echo "$LAST_THOUGHT" | grep -qE '`|\$\('; then
    echo ">> [ERROR] SECURITY VIOLATION: Malicious shell metacharacters detected in lore."
    exit 1
fi

echo ">> [SPEAKING] \"$LAST_THOUGHT\""

# Pipe to Termux TTS
termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"

echo ">> [SUCCESS] Vocalization complete."
