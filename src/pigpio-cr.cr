@[Link("pigpio")]
lib LibPigpio
  struct HeaderT
    func : LibC::UInt16T
    size : LibC::UInt16T
  end

  struct ExtentT
    size : LibC::SizeT
    ptr : Void*
    data : LibC::UInt32T
  end

  struct SampleT
    tick : LibC::UInt32T
    level : LibC::UInt32T
  end

  struct ReportT
    seqno : LibC::UInt16T
    flags : LibC::UInt16T
    tick : LibC::UInt32T
    level : LibC::UInt32T
  end

  struct PulseT
    gpioOn : LibC::UInt32T
    gpioOff : LibC::UInt32T
    usDelay : LibC::UInt32T
  end

  WAVE_FLAG_READ = 1
  WAVE_FLAG_TICK = 2

  struct RawWaveT
    gpioOn : LibC::UInt32T
    gpioOff : LibC::UInt32T
    usDelay : LibC::UInt32T
    flags : LibC::UInt32T
  end

  # ...

  # gpio: 0-53

  PI_MIN_GPIO =  0
  PI_MAX_GPIO = 53

  # user_gpio: 0-31

  PI_MAX_USER_GPIO = 31

  # level: 0-1

  PI_OFF = 0
  PI_ON  = 1

  PI_CLEAR = 0
  PI_SET   = 1

  PI_LOW  = 0
  PI_HIGH = 1

  # level: only reported for GPIO time-out, see gpioSetWatchdog

  PI_TIMEOUT = 2

  # mode: 0-7

  PI_INPUT  = 0
  PI_OUTPUT = 1
  PI_ALT0   = 4
  PI_ALT1   = 5
  PI_ALT2   = 6
  PI_ALT3   = 7
  PI_ALT4   = 3
  PI_ALT5   = 2

  # ...

  fun Initialize = gpioInitialise : LibC::Int
  # Initialises the library.
  # Returns the pigpio version number if OK, otherwise PI_INIT_FAILED.
  # gpioInitialise must be called before using the other library functions
  # with the following exceptions:
  # . .
  # [*gpioCfg**]
  # [*gpioVersion*]
  # [*gpioHardwareRevision*]
  # . .
  # ...
  # if (gpioInitialise() < 0)
  # {
  #    // pigpio initialisation failed.
  # }
  # else
  # {
  #    // pigpio initialised okay.
  # }
  # ...

  fun Terminate = gpioTerminate : Void
  # Terminates the library.
  # Returns nothing.
  # Call before program exit.
  # This function resets the used DMA channels, releases memory, and
  # terminates any running threads.
  # ```
  # gpioTerminate()
  # ```

  fun SetMode = gpioSetMode(gpio : LibC::UInt, mode : LibC::UInt) : LibC::Int
  # Sets the GPIO mode, typically input or output.
  # ```
  # gpio: 0-53
  # mode: 0-7
  # ```
  # Returns 0 if OK, otherwise PI_BAD_GPIO or PI_BAD_MODE.
  # Arduino style: pinMode.
  # ```
  # gpioSetMode(17, PI_INPUT);  // Set GPIO17 as input.
  # gpioSetMode(18, PI_OUTPUT); // Set GPIO18 as output.
  # gpioSetMode(22,PI_ALT0);    // Set GPIO22 to alternative mode 0.
  # ```
  # See [[http://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2835/BCM2835-ARM-Peripherals.pdf]] page 102 for an overview of the modes.

  fun GetMode = gpioGetMode(gpio : LibC::UInt) : LibC::Int
  # Gets the GPIO mode.
  # ```
  # gpio: 0-53
  # ```
  # Returns the GPIO mode if OK, otherwise PI_BAD_GPIO.
  # ```
  # if (gpioGetMode(17) != PI_ALT0)
  # {
  #    gpioSetMode(17, PI_ALT0);  // set GPIO17 to ALT0
  # }
  # ```

  fun SetPullUpDown = gpioSetPullUpDown(gpio : LibC::UInt, pud : LibC::UInt) : LibC::Int
  # Sets or clears resistor pull ups or downs on the GPIO.
  #
  # ```
  # gpio: 0-53
  #  pud: 0-2
  # ```
  #
  # Returns 0 if OK, otherwise PI_BAD_GPIO or PI_BAD_PUD.
  #
  # ```
  # gpioSetPullUpDown(17, PI_PUD_UP);   // Sets a pull-up.
  #
  # gpioSetPullUpDown(18, PI_PUD_DOWN); // Sets a pull-down.
  #
  # gpioSetPullUpDown(23, PI_PUD_OFF);  // Clear any pull-ups/downs.
  # ```

  fun Read = gpioRead(gpio : LibC::UInt) : LibC::Int
  # Reads the GPIO level, on or off.
  #
  # ```
  # gpio: 0-53
  # ```
  #
  # Returns the GPIO level if OK, otherwise PI_BAD_GPIO.
  #
  # Arduino style: digitalRead.
  #
  # ```
  # printf("GPIO24 is level %d", gpioRead(24))
  # ```

  fun Write = gpioWrite(gpio : LibC::UInt, level : LibC::UInt) : LibC::Int
  # Sets the GPIO level, on or off.
  #
  # ```
  #  gpio: 0-53
  # level: 0-1
  # ```
  #
  # Returns 0 if OK, otherwise PI_BAD_GPIO or PI_BAD_LEVEL.
  #
  # If PWM or servo pulses are active on the GPIO they are switched off.
  #
  # Arduino style: digitalWrite
  #
  # ```
  # gpioWrite(24, 1); // Set GPIO24 high.
  # ```
end
