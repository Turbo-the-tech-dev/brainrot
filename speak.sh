#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

printf ">> [SYSTEM] Extracting latest neural thought...\n"

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# SECURITY GATE: Reject thoughts containing shell metacharacters to prevent command injection.
# We block characters that allow command substitution, chaining, or quoting manipulation.
if printf "%s" "$LAST_THOUGHT" | grep -qE '[`$;&|\\"]'; then
    printf ">> [ERROR] Malicious neural thought detected. Execution halted.\n"
    exit 1
fi

# DEPENDENCY CHECK: Ensure TTS engine is available
if ! command -v termux-tts-speak >/dev/null 2>&1; then
    printf ">> [WARNING] termux-tts-speak not found. Simulation mode active.\n"
    printf ">> [SPEAKING] \"%s\"\n" "$LAST_THOUGHT"
    exit 0
fi

printf ">> [SPEAKING] \"%s\"\n" "$LAST_THOUGHT"

# Pipe to Termux TTS
termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"

printf ">> [SUCCESS] Vocalization complete.\n"
