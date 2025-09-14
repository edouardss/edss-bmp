import asyncio
from viam.module.module import Module
try:
    from models.bmp_sensor import BmpSensor
except ModuleNotFoundError:
    # when running as local module with run.sh
    from .models.bmp_sensor import BmpSensor


if __name__ == '__main__':
    # Register the model with the module
    # module = Module()
    module.add_model(BmpSensor.MODEL, BmpSensor)
    asyncio.run(module.run_from_registry())
