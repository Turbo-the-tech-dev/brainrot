#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

printf ">> [SYSTEM] Extracting latest neural thought...\n"

# Check if target exists
if [ ! -f "$TARGET_MD" ]; then
    printf ">> [ERROR] Target manifest %s not found.\n" "$TARGET_MD"
    exit 1
fi

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# SECURITY GATE: Reject shell metacharacters to prevent command injection
# This acts as a defense-in-depth measure for inputs derived from external files.
if printf "%s" "$LAST_THOUGHT" | grep -qE '[`$;&|\\"]'; then
    printf ">> [SECURITY] Neural thought contains illegal characters. Vocalization aborted.\n"
    exit 1
fi

printf ">> [SPEAKING] \"%s\"\n" "$LAST_THOUGHT"

# Check if TTS engine is available
if ! command -v termux-tts-speak >/dev/null 2>&1; then
    printf ">> [WARNING] termux-tts-speak not found. Simulating output only.\n"
    exit 0
fi

# Pipe to Termux TTS
termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"

printf ">> [SUCCESS] Vocalization complete.\n"
