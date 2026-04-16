#!/bin/bash
set -euo pipefail
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================

TARGET_MD="GEMINI_BRAINROT.md"

# Ensure TTS command is available
if ! command -v termux-tts-speak >/dev/null 2>&1; then
  echo ">> [ERROR] termux-tts-speak not found. Are you in Termux?"
  exit 1
fi

echo ">> [SYSTEM] Extracting latest neural thought..."

# Grab the last line, strip out the timestamps and formatting for clean audio
if [ ! -f "$TARGET_MD" ]; then
  echo ">> [ERROR] Target file $TARGET_MD not found."
  exit 1
fi

LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# Security Gate: Reject shell metacharacters to prevent command injection
if printf "%s" "$LAST_THOUGHT" | grep -qE '[\\`$;&|"]'; then
  echo ">> [SECURITY] Neural thought contains prohibited characters. Aborting."
  exit 1
fi

echo ">> [SPEAKING] \"$LAST_THOUGHT\""

# Pipe to Termux TTS
termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"

echo ">> [SUCCESS] Vocalization complete."
