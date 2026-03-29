import unittest
import os
import json
from processor import calculate_ohio_risk, generate_telemetry

class TestProcessorSecurity(unittest.TestCase):
    def test_calculate_ohio_risk_valid_input(self):
        # Valid input should return a float
        self.assertEqual(calculate_ohio_risk(100), 100.0)
        self.assertEqual(calculate_ohio_risk(0), 0.0)
        self.assertEqual(calculate_ohio_risk(50), 35.36)

    def test_calculate_ohio_risk_invalid_input_type(self):
        # String input should raise ValueError
        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk("not a number")
        self.assertEqual(str(cm.exception), "Neural load must be numeric")

    def test_calculate_ohio_risk_out_of_range_low(self):
        # Input < 0 should raise ValueError
        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk(-1)
        self.assertEqual(str(cm.exception), "Neural load must be between 0 and 100")

    def test_calculate_ohio_risk_out_of_range_high(self):
        # Input > 100 should raise ValueError
        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk(101)
        self.assertEqual(str(cm.exception), "Neural load must be between 0 and 100")

    def test_telemetry_output_file(self):
        # Clean up existing telemetry.json if it exists
        if os.path.exists('telemetry.json'):
            os.remove('telemetry.json')

        # Run the processor (main block simulation)
        data = generate_telemetry()
        with open('telemetry.json', 'w') as f:
            json.dump(data, f)

        # Verify telemetry.json is created and deadpan-brainrot.json is untouched
        self.assertTrue(os.path.exists('telemetry.json'))

        # Verify deadpan-brainrot.json content (legacy data)
        # Note: We already read it, it contains "observations"
        with open('deadpan-brainrot.json', 'r') as f:
            legacy_data = json.load(f)
            self.assertIn('observations', legacy_data)
            self.assertNotIn('status', legacy_data) # New telemetry has 'status'

if __name__ == '__main__':
    unittest.main()
