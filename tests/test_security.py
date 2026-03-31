import unittest
import os
import json
from processor import calculate_ohio_risk, generate_telemetry

class TestSecurity(unittest.TestCase):
    def test_calculate_ohio_risk_input_validation(self):
        self.assertEqual(calculate_ohio_risk(0), 0)
        self.assertEqual(calculate_ohio_risk(100), 100)
        with self.assertRaises(ValueError):
            calculate_ohio_risk(-1)
        with self.assertRaises(ValueError):
            calculate_ohio_risk(101)
        with self.assertRaises(TypeError):
            calculate_ohio_risk("84")

    def test_telemetry_output_file(self):
        data = generate_telemetry()
        self.assertIn('risk_factor', data)
        self.assertIn('status', data)

if __name__ == '__main__':
    unittest.main()
