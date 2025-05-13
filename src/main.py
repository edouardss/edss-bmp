import asyncio
from viam.module.module import Module
try:
    from models.bmp_sensor import BmpSensor
except ModuleNotFoundError:
    # when running as local module with run.sh
    from .models.bmp_sensor import BmpSensor


if __name__ == '__main__':
    asyncio.run(Module.run_from_registry())
