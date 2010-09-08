> module Main where
> import IO
> import System
> import Parser
> import Datastructure
> import Lexer
> import TypeChecking
> import KindChecking
> import Error


checks all definitions in file s
parameter: s = The file name

> checkDefinitions :: String -> IO ()
>
> checkDefinitions s =
>	do putStr ("checking types and kinds of defined variables in file \" " ++ s ++ " \"\n\n")
>	   fileContent <- readFile s
>	   putStr ( let parsed = (parseDefinitions fileContent) in
>			case parsed of
>			     Fail s -> s
>			     Ok defs -> checkDefs defs [])

checks all Definitions in the first Context under the second Context
parameters: first Context = the defintions to be checked
            second Context =  the Context under which to check definitions

> checkDefs :: Context -> Context -> String

> checkDefs [] _ = []
> checkDefs ((x,DefEntry ind e a):defs) cxt =
>    (checkOne cxt ind e a) ++ "\n" ++ (checkDefs defs ((x,DefEntry ind e a):cxt)) where
> 	checkOne cxt ind e a =
>	    case ind of 
>		IsTerm -> let r = typeChecking cxt e a in
>                             "term " ++ x ++ " : " ++ printGood cxt a ++"\n"++ 
>			      printEmpty ((length x) + 5) ++ " = " ++ 
>			      printGood cxt e ++ "\n" ++
>	    		      case r of
>				Ok () -> ""
>				Fail s -> "Typing Error: " ++ s ++ "\n"
>		IsType -> let r = kindChecking cxt e a in
>                             "type " ++ x ++ " : " ++ printGood cxt a ++ "\n"++
>			      printEmpty ((length x) + 5) ++ " = " ++ 
>			      printGood cxt e ++ "\n" ++
>	    		      case r of
>				Ok () -> "" -- x ++": kinded correctly\n"
>				Fail s -> "Kinding Error: " ++ s ++ "\n"
> checkDefs ((x,VarEntry ind a):defs) cxt =
>    checkDefs defs ((x,VarEntry ind a):cxt)


> run :: [String] -> IO ()
> run [] = return ()
> run (file:files) = 
>     do putStrLn ("[Opening file " ++ file ++ "]")
> 	 checkDefinitions file 
>        putStrLn ("[Closing file " ++ file ++ "]")
>        run files

> mainHugs :: [String] -> IO ()
> mainHugs cmdline =
>     do putStrLn "Fomega Church Type Checker"
>	 run cmdline

> main :: IO ()
> main = do cmdline <- getArgs
>           mainHugs cmdline
