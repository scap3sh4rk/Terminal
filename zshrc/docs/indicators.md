# Status Codes and Their Meaning 

|      Code | Meaning                                |
| --------: | -------------------------------------- |
|       `0` | Success                                |
|       `1` | Generic failure                        |
|       `2` | Misuse of shell builtins               |
|     `126` | Command found but **not executable**   |
| **`127`** | **Command not found**                  |
|     `130` | Script terminated by Ctrl+C            |
|     `255` | Exit status out of range / SSH failure |
