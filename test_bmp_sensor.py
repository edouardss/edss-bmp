#!/usr/bin/env python3
"""Test script to verify BmpSensor MODEL attribute"""

import sys
import os
sys.path.append(os.path.join(os.path.dirname(__file__), 'src'))

from models.bmp_sensor import BmpSensor
from viam.resource.types import Model, ModelFamily

def test_model_attribute():
    """Test that the MODEL attribute is correctly defined"""
    print("Testing BmpSensor MODEL attribute...")
    
    # Check that MODEL exists
    assert hasattr(BmpSensor, 'MODEL'), "BmpSensor should have MODEL attribute"
    
    # Check that it's a Model instance
    assert isinstance(BmpSensor.MODEL, Model), "MODEL should be a Model instance"
    
    # Check the model family
    expected_family = ModelFamily("edss", "edss-bmp")
    assert BmpSensor.MODEL.family == expected_family, f"Expected family {expected_family}, got {BmpSensor.MODEL.family}"
    
    # Check the model name
    assert BmpSensor.MODEL.name == "bmp-sensor", f"Expected name 'bmp-sensor', got '{BmpSensor.MODEL.name}'"
    
    print("✅ MODEL attribute test passed!")
    print(f"   Family: {BmpSensor.MODEL.family}")
    print(f"   Name: {BmpSensor.MODEL.name}")
    print(f"   Full model: {BmpSensor.MODEL}")

if __name__ == "__main__":
    test_model_attribute()
