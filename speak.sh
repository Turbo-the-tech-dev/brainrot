#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

echo ">> [SYSTEM] Extracting latest neural thought..."

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# Security check: Validate LAST_THOUGHT for shell metacharacters
# We use printf to avoid issues with thoughts starting with '-'
if printf "%s" "$LAST_THOUGHT" | grep -qE '[\\`$;&|"]'; then
    echo ">> [ERROR] Security Breach: Illegal characters detected in neural thought."
    exit 1
fi

echo ">> [SPEAKING] \"$LAST_THOUGHT\""

# Pipe to Termux TTS
termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"

echo ">> [SUCCESS] Vocalization complete."
