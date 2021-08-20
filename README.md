# Conq

Conq is a simple Log library for ruby applications.

## **Features**

- Multiple log levels
- Min level for logs
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

Conq.init(output: log_file)
Conq.debug("This message will appear in 'log_file.txt'")

Conq.init()
Conq.debug("This message will appear in the console")

Conq.config(output: log_file)
Conq.debug("Now, it'll appear in 'log_file.txt')
```

### **Setting log's min level**

```ruby
Conq.init(min_level: Conq::Levels::ERROR)
Conq.debug("This log will be ignored")

Conq.error("This one will appear in console")
Conq.critical("This too")

Conq.config(min_level: Conq::Levels::DEBUG)
Conq.debug("Now, this will be shown")

# Levels in order
# - DEBUG
# - INFO
# - WARNING
# - ERROR
# - CRITICAL
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

### **Getting the global log object**

```ruby
Conq.init()

global = Conq.get_global()
global.debug("Directly on global object")
```

### **Creating custom log objects**

```ruby
log_file = File.open("./log_file.txt", "w")

logger = Conq::Logger.new STDOUT
logger.debug("This will be printed in the console")

logger.config(output: log_file)
logger.debug("Now, in the 'log_file.txt'")
```
