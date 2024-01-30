%{
#include <cctype>
#include <cstdio>
#include <string>
#define YYEOF 0
int yylex();
int main() {
  do {
  } while (yylex() != YYEOF);
}
int nowrow = 0;
int space = 0;
#define test();   std::fprintf(yyout, "'%s'\t%s\t%s\tLoc=<%s:%d:%d>\n", yytext, (nowrow!=yyrow)?"[StartOfLine]":"", space?"[LeadingSpace]":"", yyloc.c_str(), yyrow, yycolumn - yyleng); nowrow = yyrow; space = 0;
std::string yyloc = "<stdin>";
int yyrow = 1, yycolumn = 1, yycolpre = 1;
#define YY_USER_ACTION                                                         \
  do {                                                                         \
    yycolumn += yyleng;                                                        \
  } while (0);
%}
%option noyywrap
%%
#.* {
  std::string s(yytext);
  auto l = s.find("\""), r = s.rfind("\"");
  yyloc = s.substr(l + 1, r - l - 1);
  for (int i = 0; i < s.size(); ++i)
    if (std::isdigit(s[i])) {
      for (yyrow = 0; i < s.size() && std::isdigit(s[i]); ++i)
        yyrow = yyrow * 10 + s[i] - '0';
      --yyrow;
      break;
    }
}
\n {
  ++yyrow;
  yycolpre = yycolumn;
  yycolumn = 1;
}
[\f\r\t\v ] {
  space = 1;
}

\"((\\\\)|(\\n)|(\\\")|([^\\\"]))*\" {
  std::fprintf(yyout, "string_literal ");
  test();
  return ~YYEOF;  
}
void {
  std::fprintf(yyout, "void ");
  test();
  return ~YYEOF;
}
int {
  std::fprintf(yyout, "int ");
  test();
  return ~YYEOF;
}
long {
  std::fprintf(yyout, "long ");
  test();
  return ~YYEOF;
}
char {
  std::fprintf(yyout, "char ");
  test();
  return ~YYEOF;
}
float {
  std::fprintf(yyout, "float ");
  test();
  return ~YYEOF;
}
const {
  std::fprintf(yyout, "const ");
  test();
  return ~YYEOF;
}
do {
  std::fprintf(yyout, "do ");
  test();
  return ~YYEOF;
}
while {
  std::fprintf(yyout, "while ");
  test();
  return ~YYEOF;
}
if {
  std::fprintf(yyout, "if ");
  test();
  return ~YYEOF;
}
else {
  std::fprintf(yyout, "else ");
  test();
  return ~YYEOF;
}
continue {
  std::fprintf(yyout, "continue ");
  test();
  return ~YYEOF;
}
break {
  std::fprintf(yyout, "break ");
  test();
  return ~YYEOF;
}
return {
  std::fprintf(yyout, "return ");
  test();
  return ~YYEOF;
}
\( {
  std::fprintf(yyout, "l_paren ");
  test();
  return ~YYEOF;
}
\) {
  std::fprintf(yyout, "r_paren ");
  test();
  return ~YYEOF;
}
\[ {
  std::fprintf(yyout, "l_square ");
  test();
  return ~YYEOF;
}
\] {
  std::fprintf(yyout, "r_square ");
  test();
  return ~YYEOF;
}
\{ {
  std::fprintf(yyout, "l_brace ");
  test();
  return ~YYEOF;
}
\} {
  std::fprintf(yyout, "r_brace ");
  test();
  return ~YYEOF;
}
"+" {
  std::fprintf(yyout, "plus ");
  test();
  return ~YYEOF;
}
"-" {
  std::fprintf(yyout, "minus ");
  test();
  return ~YYEOF;
}
"*" {
  std::fprintf(yyout, "star ");
  test();
  return ~YYEOF;
}
"/" {
  std::fprintf(yyout, "slash ");
  test();
  return ~YYEOF;
}
"%" {
  std::fprintf(yyout, "percent ");
  test();
  return ~YYEOF;
}
"||" {
  std::fprintf(yyout, "pipepipe ");
  test();
  return ~YYEOF;
}
"&&" {
  std::fprintf(yyout, "ampamp ");
  test();
  return ~YYEOF;
}
"!=" {
  std::fprintf(yyout, "exclaimequal ");
  test();
  return ~YYEOF;
}
"<=" {
  std::fprintf(yyout, "lessequal ");
  test();
  return ~YYEOF;
}
">=" {
  std::fprintf(yyout, "greaterequal ");
  test();
  return ~YYEOF;
}
"==" {
  std::fprintf(yyout, "equalequal ");
  test();
  return ~YYEOF;
}
"<" {
  std::fprintf(yyout, "less ");
  test();
  return ~YYEOF;
}
">" {
  std::fprintf(yyout, "greater ");
  test();
  return ~YYEOF;
}
"=" {
  std::fprintf(yyout, "equal ");
  test();
  return ~YYEOF;
}
"!" {
  std::fprintf(yyout, "exclaim ");
  test();
  return ~YYEOF;
}
"," {
  std::fprintf(yyout, "comma ");
  test();
  return ~YYEOF;  
}
"..." {
  std::fprintf(yyout, "ellipsis ");
  test();
  return ~YYEOF;  
}
; {
  std::fprintf(yyout, "semi ");
  test();
  return ~YYEOF;
}
0[xX][0-9a-fA-F]*(\.[0-9a-fA-F]+)?([pP][-+]?[0-9]+)? {
  std::fprintf(yyout, "numeric_constant ");
  test();
  return ~YYEOF;
}
0?[1-9][0-9]*(\.[0-9]+)?([eE][-+]?[0-9]+)? {
  std::fprintf(yyout, "numeric_constant ");
  test();
  return ~YYEOF;
}
[0-9]+ {
  std::fprintf(yyout, "numeric_constant ");
  test();
  return ~YYEOF;
}
([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)([eE][-+]?[0-9]+)? {
  std::fprintf(yyout, "numeric_constant ");
  test();
  return ~YYEOF;
}
[a-zA-Z_][a-zA-Z_0-9]* {
  std::fprintf(yyout, "identifier ");
  test();
  return ~YYEOF;
}
<<EOF>> {
  std::fprintf(yyout, "eof ''\t\tLoc=<%s:%d:%d>\n", yyloc.c_str(), yyrow - 1,
               yycolpre - yyleng);
  return YYEOF;
}
. {
  std::fprintf(yyout, "unknown ");
  test();
  return ~YYEOF;
}
%%