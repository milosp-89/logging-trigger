# Logging Trigger Script Structure:
The logging trigger script consists of two steps:

- Create a logging SQL table where audit changes will be stored.
- Initiate a trigger for the affected SQL table to fetch necessary changes.
  
# Logging SQL Table Overview:
![Capture](https://github.com/milosp-89/logging_trigger_script/assets/155644532/e299ec32-9348-427f-ad88-7e84ffd957a2)

As depicted above, the logging SQL table will capture all detected changes within the designated SQL tables.
It records the timestamp of the change, the user responsible, the affected table, and importantly, the type of change implemented,
providing comprehensive details.
