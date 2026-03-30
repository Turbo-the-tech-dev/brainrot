import unittest
import os
import json
from processor import calculate_ohio_risk, generate_telemetry

class TestSecurity(unittest.TestCase):
    def test_calculate_ohio_risk_valid(self):
        # Test with valid inputs
        self.assertEqual(calculate_ohio_risk(0), 0)
        self.assertEqual(calculate_ohio_risk(100), 100.0)
        # (84^1.5)/10 = 76.9922... -> 76.99
        self.assertEqual(calculate_ohio_risk(84), 76.99)

    def test_calculate_ohio_risk_invalid_type(self):
        # Test with invalid types
        with self.assertRaises(ValueError):
            calculate_ohio_risk("84")
        with self.assertRaises(ValueError):
            calculate_ohio_risk(None)

    def test_calculate_ohio_risk_out_of_bounds(self):
        # Test with out of bounds values
        with self.assertRaises(ValueError):
            calculate_ohio_risk(-1)
        with self.assertRaises(ValueError):
            calculate_ohio_risk(101)

    def test_telemetry_output_file(self):
        # Test that telemetry is written to telemetry.json and NOT deadpan-brainrot.json
        if os.path.exists('telemetry.json'):
            os.remove('telemetry.json')

        # Run the script to generate telemetry.json
        os.system('python3 processor.py > /dev/null')

        self.assertTrue(os.path.exists('telemetry.json'))
        with open('telemetry.json', 'r') as f:
            data = json.load(f)
            self.assertIn('risk_factor', data)
            self.assertIn('status', data)

if __name__ == '__main__':
    unittest.main()
