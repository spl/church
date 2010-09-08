A monadic Lexer for use with the type checker for System F_omega

> module Lexer where
> import Char
> import Error
> import ParseMonad

Tokens

> data Token = TokenType
>       | TokenArr
>       | TokenLambda
>       | TokenTyLambda
>       | TokenCol
>       | TokenVar String
>       | TokenDot
>       | TokenLParen
>       | TokenRParen
>       | TokenForall
>       | TokenLBr
>       | TokenRBr
>       | TokenSemi
>       | TokenEOF
>       | TokenDef
>       | TokenIdType
>       | TokenIdTerm
>        deriving Show


> lexer :: (Token -> P a) -> P a

> lexer cont s i = lex s
>     where --lex :: String -> Error a
>           lex ('%':cs) = lexLineComment cont cs i
>	    lex ('/':'%':cs) = lexBlockComment cont cs i
>           lex ('\n':cs) = lexer cont cs (i + 1)
>           lex (c:cs) 
>               |isSpace c = lexer cont cs i
>               |isAlpha c = lexVar cont (c:cs) i
>           lex ('\\':'\\':cs) = cont TokenTyLambda cs i
>           lex ('\\':cs) = cont TokenLambda cs i
>           lex ('*':cs) = cont TokenType cs i
>           lex ('-':'>':cs) = cont TokenArr cs i
>           lex (':':cs) = cont TokenCol cs i
>           lex ('.':cs) = cont TokenDot cs i
>           lex ('(':cs) = cont TokenLParen cs i
>           lex (')':cs) = cont TokenRParen cs i
>           lex ('[':cs) = cont TokenLBr cs i
>           lex (']':cs) = cont TokenRBr cs i
>           lex (';':cs) = cont TokenSemi cs i
>           lex ('=':cs) = cont TokenDef cs i
>           lex [] = cont TokenEOF [] i
>           lex (c:cs) = fail ("unexpected character '" ++ [c] ++ 
>		       "' in line " ++ show i ++ "\n")

> lexLineComment cont (c:cs) i
>     | c == '\n' = lexer cont cs (i + 1)
>     | otherwise =  lexLineComment cont cs i

> lexBlockComment cont (c:cs) i
>     | c == '%' = lexSlash cont cs i
>     | c == '\n' = lexBlockComment cont cs (i + 1)
>     | otherwise = lexBlockComment cont cs i

> lexSlash cont (c:cs) i = if (c=='/')
>                          then lexer cont cs i
>                          else lexBlockComment cont cs i

> lexVar cont cs i
>     | var == "forall" = cont TokenForall rest i
>     | var == "type"   = cont TokenIdType rest i
>     | var == "term"   = cont TokenIdTerm rest i
>     | otherwise       = cont (TokenVar var) rest i
>       where (var,rest) = span isIdChar cs

A little help-function that combines isDigit with isAlpha.

> isIdChar :: Char -> Bool
> isIdChar c = isAlpha c || isDigit c || c == '\'' || c == '_' 



