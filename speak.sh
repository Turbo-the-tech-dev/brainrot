#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

echo ">> [SYSTEM] Extracting latest neural thought..."

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# SECURITY GATE: Reject thoughts containing shell metacharacters (backticks or command substitution)
if echo "$LAST_THOUGHT" | grep -qE '`|\$\('; then
    echo ">> [SECURITY ERROR] Malicious neural activity detected! Execution halted."
    exit 1
fi

echo ">> [SPEAKING] \"$LAST_THOUGHT\""

# Pipe to Termux TTS
# Check if termux-tts-speak exists before calling
if command -v termux-tts-speak >/dev/null 2>&1; then
    termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"
else
    echo ">> [SYSTEM] termux-tts-speak not found. Audio simulation bypassed."
fi

echo ">> [SUCCESS] Vocalization complete."
