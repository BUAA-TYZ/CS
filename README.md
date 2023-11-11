# CS61C

### Lab 01

- `scp <source> <destination>`

使用 ssh 进行复制

- 使用 cgdb

**《gdb高级调试教程》**

由于使用 cgdb 自带了窗口，所以 list 就不必要了。

| 命令          | 效果                                             |
| ------------- | ------------------------------------------------ |
| r             | 运行至下一个断点                                 |
| b+行号/函数名 | 添加断点                                         |
| info b        |                                                  |
| bt            | 查看当前线程堆栈                                 |
| c             | 继续运行                                         |
| finish        | 直接执行完当前函数返回                           |
| n             | 单步步过（不进入函数）                           |
| s             | 单步步入                                         |
| display       | 每次暂停，打印监视的变量的值（info/del display） |
| print         |                                                  |
| set args      | 设置命令行启动参数                               |
| show args     |                                                  |

其中 info 有很多组合

- info locals
- info functions
- info args

- 详见 help info

可以直接这样传入参数 `set args < name.txt`
