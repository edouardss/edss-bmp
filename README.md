# Module edss-bmp 

Provide a description of the purpose of the module and any relevant information.

## Model edss:edss-bmp:bmp-sensor

Provide a description of the model and any relevant information.

### Configuration
The following attribute template can be used to configure this model:

```json
{
  "sea_level_pressure": <float>
}
```

#### Attributes

The following attributes are available for this model:

| Name                 | Type  | Inclusion | Description                                    |
|----------------------|-------|-----------|------------------------------------------------|
| `sea_level_pressure` | float | Optional  | Sea level pressure in hPa for altitude calculations (default: 1013.25) |

#### Example Configuration

```json
{
  "sea_level_pressure": 1013.25
}
```

### DoCommand

If your model implements DoCommand, provide an example payload of each command that is supported and the arguments that can be used. If your model does not implement DoCommand, remove this section.

#### Example DoCommand

```json
{
  "command_name": {
    "arg1": "foo",
    "arg2": 1
  }
}
```
