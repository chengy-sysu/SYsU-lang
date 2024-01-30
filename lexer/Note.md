## 涉及的token

1. `"#.*"` - 注释，处理函数未指定
2. `"\n"` - 换行符，处理函数未指定
3. `\"((\\\\)|(\\n)|(\\\")|([^\\\"]))*\"` - 字符串字面量（string_literal）
4. `"void"` - void关键字
5. `"int"` - int关键字
6. `"long"` - long关键字
7. `"char"` - char关键字
8. `"float"` - float关键字
9. `"const"` - const关键字
10. `"do"` - do关键字
11. `"while"` - while关键字
12. `"if"` - if关键字
13. `"else"` - else关键字
14. `"continue"` - continue关键字
15. `"break"` - break关键字
16. `"return"` - return关键字
17. `(` - 左括号（l_paren）
18. `)` - 右括号（r_paren）
19. `[` - 左方括号（l_square）
20. `]` - 右方括号（r_square）
21. `{` - 左大括号（l_brace）
22. `}` - 右大括号（r_brace）
23. `"+"` - 加号（plus）
24. `"-"` - 减号（minus）
25. `"*"` - 星号（star）
26. `"/"` - 斜杠（slash）
27. `"%"` - 百分号（percent）
28. `"||"` - 逻辑或（pipepipe）
29. `"&&"` - 逻辑与（ampamp）
30. `"!="` - 不等于（exclaimequal）
31. `"<="` - 小于等于（lessequal）
32. `">="` - 大于等于（greaterequal）
33. `"=="` - 等于（equalequal）
34. `"<"` - 小于（less）
35. `">"` - 大于（greater）
36. `"="` - 赋值（equal）
37. `"!"` - 感叹号（exclaim）
38. `","` - 逗号（comma）
39. `"..."` - 省略号（ellipsis）
40. `";"` - 分号（semi）
41. `0[xX][0-9a-fA-F]*(\.[0-9a-fA-F]+)?([pP][-+]?[0-9]+)?` - 十六进制浮点数（numeric_constant）
42. `0?[1-9][0-9]*(\.[0-9]+)?([eE][-+]?[0-9]+)?` - 十进制浮点数（numeric_constant）
43. `[0-9]+` - 十进制整数（numeric_constant）
44. `([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?` - 带小数点的十进制数（numeric_constant）
45. `[a-zA-Z_][a-zA-Z_0-9]*` - 标识符（identifier）
46. `<<EOF>>` - 文件结束（eof）
47. `.` - 未知字符（unknown）

处理空白字符（如空格、制表符等），这些在提供的代码中被忽略（`[\f\r\t\v ] {}`）。此外，`<<EOF>>` 规则用于处理文件结束的情况。

## 小脚本

```Makefile
# Makefile

# 默认目标，构建项目
all:
	cmake --build ${HOME}/sysu/build

# 安装目标，构建并安装项目
install:
	cmake --build ${HOME}/sysu/build -t install

# 清理目标，删除构建目录
clean:
	rm -rf ${HOME}/sysu/build

define TEST_CMD
    export PATH=${HOME}/sysu/bin:${PATH} \
    CPATH=${HOME}/sysu/include:${CPATH} \
    LIBRARY_PATH=${HOME}/sysu/lib:${LIBRARY_PATH} \
    LD_LIBRARY_PATH=${HOME}/sysu/lib:${LD_LIBRARY_PATH}
endef

test1-1:
	( $(TEST_CMD) \
	  && sysu-compiler --unittest=lexer-1 "**/*.sysu.c" )

test1-2:
	( $(TEST_CMD) \
	  && sysu-compiler --unittest=lexer-2 "**/*.sysu.c" )

test1-3:
	( $(TEST_CMD) \
	  && sysu-compiler --unittest=lexer-3 "**/*.sysu.c" )

test2-1:
	( $(TEST_CMD) \
	  && sysu-compiler --unittest=parser-1 "**/*.sysu.c" )

test2-2:
	( $(TEST_CMD) \
	  && sysu-compiler --unittest=parser-1 "**/*.sysu.c" )

test2-3:
	( $(TEST_CMD) \
	  && sysu-compiler --unittest=parser-1 "**/*.sysu.c" )
```

## 打印到文件

```bash
sysu-preprocessor *.c | sysu-lexer >1.txt 2>&1
```