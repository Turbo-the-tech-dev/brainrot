#!/bin/bash
set -euo pipefail
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

# 1. Ensure target exists
if [[ ! -f "$TARGET_MD" ]]; then
    echo ">> [ERROR] Target manifesto $TARGET_MD not found."
    exit 1
fi

echo ">> [SYSTEM] Extracting latest neural thought..."

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# 2. SECURITY GATE: Validate input for shell metacharacters to prevent injection
# Since LAST_THOUGHT is passed in double-quotes to termux-tts-speak, we must
# block backticks and command substitution.
if printf "%s" "$LAST_THOUGHT" | grep -qE '[\\`$;&|"]'; then
    echo ">> [SECURITY] Aborting: Detected illegal characters in thought."
    exit 1
fi

echo ">> [SPEAKING] \"$LAST_THOUGHT\""

# 3. Check if TTS engine is available
if command -v termux-tts-speak >/dev/null 2>&1; then
    termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"
else
    echo ">> [NOTICE] termux-tts-speak not found. Simulation mode active."
fi

echo ">> [SUCCESS] Vocalization complete."
