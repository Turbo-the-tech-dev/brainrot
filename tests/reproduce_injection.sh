#!/bin/bash
TARGET_MD="TEST_BRAINROT.md"
echo "2026-03-10 - \"; touch HACKED #" > "$TARGET_MD"

# Mock termux-tts-speak
mkdir -p bin
echo '#!/bin/bash' > bin/termux-tts-speak
echo 'echo "TTS CALLED WITH: $1"' >> bin/termux-tts-speak
chmod +x bin/termux-tts-speak
export PATH="$PWD/bin:$PATH"

# Simplified speak.sh logic
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')
echo "Extracted thought: $LAST_THOUGHT"

# The vulnerable call
termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"

if [ -f HACKED ]; then
    echo "SUCCESS: Injection successful!"
    rm HACKED
else
    echo "FAILURE: Injection failed."
fi
rm "$TARGET_MD"
rm -rf bin
