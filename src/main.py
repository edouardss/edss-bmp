import asyncio
from viam.module.module import Module
from models.bmp_sensor import BmpSensor

if __name__ == '__main__':
    asyncio.run(Module.run_from_registry())
