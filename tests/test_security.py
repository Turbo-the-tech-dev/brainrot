import unittest
import os
import json
from processor import calculate_ohio_risk, generate_telemetry, write_telemetry_to_file

class TestSecurity(unittest.TestCase):

    def test_ohio_risk_valid_input(self):
        # Test valid inputs
        self.assertEqual(calculate_ohio_risk(0), 0)
        self.assertEqual(calculate_ohio_risk(100), 100.0)
        self.assertIsInstance(calculate_ohio_risk(50), float)

    def test_ohio_risk_invalid_numeric_range(self):
        # Test out of range inputs
        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk(-1)
        self.assertEqual(str(cm.exception), "Neural load must be between 0 and 100.")

        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk(101)
        self.assertEqual(str(cm.exception), "Neural load must be between 0 and 100.")

    def test_ohio_risk_non_numeric_input(self):
        # Test non-numeric inputs
        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk("skibidi")
        self.assertEqual(str(cm.exception), "Neural load must be numeric.")

        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk(None)
        self.assertEqual(str(cm.exception), "Neural load must be numeric.")

    def test_telemetry_output_file(self):
        # Ensure telemetry is written to a specified file correctly
        test_file = 'test_telemetry_output.json'
        if os.path.exists(test_file):
            os.remove(test_file)

        data = generate_telemetry()
        write_telemetry_to_file(data, test_file)

        self.assertTrue(os.path.exists(test_file))
        with open(test_file, 'r') as f:
            saved_data = json.load(f)
            self.assertEqual(saved_data['velocity'], 'ABSOLUTE')

        # Clean up
        if os.path.exists(test_file):
            os.remove(test_file)

if __name__ == '__main__':
    unittest.main()
