
/*
1. Bitwise operators done
2. Ternary operator done
3. & operaroter pointers
4. pointer dot done
5. sizeof operartor
6. shorthand assignement opearators
7. @ synbol



Future : , operator for lists
*/

enum keywords
{
  INT=100,
  FLOAT,
  LONG,
  LONG_LONG,
  SHORT,
  SIGNED,
  UNSIGNED,
  FOR,
  WHILE,
  BREAK,
  CONTINUE,
  RETURN,
  CHAR,
  IF,
  ELSE
};

enum operators
{
  DECREMENT=200,
  INCREMENT,
  INCREMENT_ONE,
  DECREMENT_ONE,
  PTR_SELECT,
  LOGICAL_AND,
  LOGICAL_OR,
  LS_THAN_EQ,
  GR_THAN_EQ,
  EQ,
  NOT_EQ,
  ASSIGN,
  MINUS,
  PLUS,
  STAR,
  MODULO,
  LS_THAN,
  GR_THAN,
  LS_SHIFT,
  RS_SHIFT,
  BITWISE_AND,
  BITWISE_OR,
  BITWISE_XOR,
  BITWISE_NOT,
  TERNARY_COND,
  TERNARY_COLON,
  ACCESS_DOT
};

enum special_symbols
{
  DELIMITER=300,
  OPEN_BRACES,
  CLOSE_BRACES,
  COMMA,
  OPEN_PAR,
  CLOSE_PAR,
  OPEN_SQ_BRKT,
  CLOSE_SQ_BRKT,
  FW_SLASH
};

enum constants
{
  HEX_CONSTANT=400,
  DEC_CONSTANT,
  HEADER_FILE,
  STRING
};

enum IDENTIFIER
{
  IDENTIFIER=500
};