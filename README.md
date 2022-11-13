# pigpio-cr

Crystal bindings to pigpio - https://github.com/joan2937/pigpio

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     pigpio-cr:
       github: SleepingInsomniac/pigpio-cr
   ```

2. Run `shards install`

## Usage

```crystal
require "pigpio"

if status = LibPigpio.Initialize < 0
  # pigpio initialisation failed.
  puts "LibPigpio initialization failed: #{status}"
  exit
end

LibPigpio.SetMode(2, LibPigpio::PI_OUTPUT)

60.times do
  LibPigpio.Write(2, 1)
  sleep 0.5
  LibPigpio.Write(2, 0)
  sleep 0.5
end
```

## Contributing

1. Fork it (<https://github.com/your-github-user/pigpio-cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Alex Clink](https://github.com/your-github-user) - creator and maintainer
