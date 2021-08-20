# Conq

Conq is a simple Log library for ruby applications.

## **Features**

- Multiple log levels
- Global logging object
- Custom and multiple Log objects
- Custom log message format
- Logs in STDOUT or in a predefined file

## **Usage**

### **Simple usage**

```ruby
Conq.init()

Conq.debug("It's a debug message")
Conq.info("It's a info message")
Conq.warning("It's a warning message")
Conq.error("It's a error message")
Conq.critical("It's a critical message")

# [2021-52-20 17:52:28] DEBUG: It's a debug message
# [2021-52-20 17:52:28] INFO: It's a info message
# [2021-52-20 17:52:28] WARNING: It's a warning message
# [2021-52-20 17:52:28] ERROR: It's a error message
# [2021-52-20 17:52:28] CRITICAL: It's a critical message
```

### **Setting an output stream**

```ruby
log_file = File.open("./log_file.txt", "w")

Conq.init(log_file)
Conq.debug("This message will appear in 'log_file.txt'")

Conq.init()
Conq.debug("This message will appear in the console")

Conq.config(output: log_file)
Conq.debug("Now, it'll appear in 'log_file.txt')
```

### **Setting custom message shapes**

```ruby
Conq.init()

Conq.debug("Default format")
# [2021-52-20 17:52:28] DEBUG: Default format

Conq.config(shape: "[%{TIME}] Message: %{MESSAGE}")
Conq.debug("New format")
# [17:52:28] Message: New format

# Named parameters:
#
# %{DATE}    -> Log's date
# %{TIME}    -> Log's time
# %{MESSAGE} -> Log's message
# %{LEVEL}   -> Log's level
```

### **Creating custom log objects**

```ruby
log_file = File.open("./log_file.txt", "w")

logger = Conq::Logger.new STDOUT
logger.debug("This will be printed in the console")

logger.config(output: log_file)
logger.debug("Now, in the 'log_file.txt'")
```
