# Module edss-bmp 

Provide a description of the purpose of the module and any relevant information.

## Model edss:edss-bmp:bmp-sensor

Altitude and pressure sensor. 
Based on the delta between sea level pressure and current pressure, this sensor estimates altitude and temperature. 

### Configuration
The following attribute template can be used to configure this model:

```json
{
  "sea_level_pressure": <int> (integer number given in Pa. Default value is 101325)
  "units": "metric" or "imperial" (default is "metric" - C, Pa and m. "imperial" is F, inHg, ft)
}
```

#### Attributes

The following attributes are available for this model:

| Name                 | Type  | Inclusion | Description                                    |
|----------------------|-------|-----------|------------------------------------------------|
| `sea_level_pressure` | int | Optional  | Sea level pressure in Pa for altitude calculations (default: 101325) |
| `units`              | string| Optional | metric or imperial units, default is metric |

#### Example Configuration

```json
{
  "sea_level_pressure": 101325,
  "units": "metric"
}
```

### DoCommand

There is a command to `tare` the sensor to the current altitude, which returns current readings and sets offsets so that readings will subtract those values from pressure and altitude going forward. 
There is also a command `reset_tare` to reset the offset values to 0. 

#### Example DoCommand

```json
{
  "tare": {}
}
```
