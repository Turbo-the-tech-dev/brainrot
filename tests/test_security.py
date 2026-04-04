import unittest
import subprocess
import os
from processor import calculate_ohio_risk

class TestSecurity(unittest.TestCase):
    def test_calculate_ohio_risk_validation(self):
        # Valid input
        self.assertEqual(calculate_ohio_risk(50), round((50 ** 1.5) / 10, 2))
        self.assertEqual(calculate_ohio_risk(0), 0.0)
        self.assertEqual(calculate_ohio_risk(100), round((100 ** 1.5) / 10, 2))

        # Invalid input - Out of range
        self.assertEqual(calculate_ohio_risk(-1), 0.0)
        self.assertEqual(calculate_ohio_risk(101), 0.0)

        # Invalid input - Type check
        self.assertEqual(calculate_ohio_risk("not_a_number"), 0.0)
        self.assertEqual(calculate_ohio_risk(None), 0.0)

    def test_speak_sh_injection_prevention(self):
        target_md = "GEMINI_BRAINROT.md"
        # Save original content
        original_content = ""
        if os.path.exists(target_md):
            with open(target_md, 'r') as f:
                original_content = f.read()

        try:
            # Test case: Malicious injection with backticks
            with open(target_md, 'a') as f:
                f.write("\n>> [TEST] 2026-03-11 - `ls` should not run")

            result = subprocess.run(['./speak.sh'], capture_output=True, text=True)
            self.assertEqual(result.returncode, 1)
            self.assertIn("SECURITY VIOLATION", result.stdout)

            # Test case: Malicious injection with command substitution
            with open(target_md, 'w') as f:
                f.write(">> [TEST] 2026-03-11 - $(whoami) should not run")

            result = subprocess.run(['./speak.sh'], capture_output=True, text=True)
            self.assertEqual(result.returncode, 1)
            self.assertIn("SECURITY VIOLATION", result.stdout)

            # Test case: Clean input
            with open(target_md, 'w') as f:
                f.write(">> [TEST] 2026-03-11 - This is a safe thought")

            result = subprocess.run(['./speak.sh'], capture_output=True, text=True)
            # The test might fail if termux-tts-speak is not installed, but it shouldn't return 1 due to our validation
            self.assertNotEqual(result.returncode, 1)
            self.assertNotIn("SECURITY VIOLATION", result.stdout)

        finally:
            # Restore original content
            if original_content:
                with open(target_md, 'w') as f:
                    f.write(original_content)

if __name__ == "__main__":
    unittest.main()
