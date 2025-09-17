import asyncio
from viam.module.module import Module

try:
    from models.bmp_sensor import BmpSensor
except ModuleNotFoundError:
    print("Count not find the module BmpSensor")
    from .models.bmp_sensor import BmpSensor

if __name__ == '__main__':
    # Register the model with the module
    # module = Module()
    # module.add_model(BmpSensor.MODEL, BmpSensor)
    print("trying to run BmpSensor from main")
    asyncio.run(Module.run_from_registry())
