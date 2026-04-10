#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

printf ">> [SYSTEM] Extracting latest neural thought...\n"

# Grab the last line, strip out the timestamps and formatting for clean audio
# We use a temp variable to check for injection risks before speaking
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# SECURITY GATE: Reject input with shell metacharacters to prevent injection
if printf "%s" "$LAST_THOUGHT" | grep -qE '[`$;&|\\"]'; then
    printf ">> [SECURITY] Critical: Malicious neural thought detected. Execution halted.\n"
    exit 1
fi

printf ">> [SPEAKING] \"%s\"\n" "$LAST_THOUGHT"

# SAFE EXECUTION: Verify TTS engine exists before calling
if command -v termux-tts-speak >/dev/null 2>&1; then
    # Double quote variable to prevent word splitting, though validation gate
    # already handles the most dangerous characters.
    termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"
    printf ">> [SUCCESS] Vocalization complete.\n"
else
    printf ">> [OFFLINE] TTS Engine (termux-tts-speak) not found. Text-only fallback active.\n"
fi
