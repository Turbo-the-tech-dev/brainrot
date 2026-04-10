#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

printf ">> [SYSTEM] Extracting latest neural thought...\n"

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# SECURITY GATE: Reject input with shell metacharacters to prevent injection
if printf "%s" "$LAST_THOUGHT" | grep -qE '[`$;&|\\"]'; then
    printf ">> [ERROR] Security breach detected: Unsafe neural thought rejected.\n"
    exit 1
fi

printf ">> [SPEAKING] \"%s\"\n" "$LAST_THOUGHT"

# Check if TTS engine is available
if ! command -v termux-tts-speak > /dev/null 2>&1; then
    printf ">> [WARNING] termux-tts-speak not found. Vocalization skipped.\n"
    exit 0
fi

# Pipe to Termux TTS
termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"

printf ">> [SUCCESS] Vocalization complete.\n"
