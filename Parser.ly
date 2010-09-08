> {
> module Parser where
> import Error
> import Lexer
> import Datastructure
> import ParseMonad
> }

> %monad { P } { thenP } { returnP }
> %lexer { lexer } { TokenEOF }
> %name parseDef Defs


> %tokentype { Token }

> %token
>       "*"             {TokenType}
>       "->"            {TokenArr}
>       lambda          {TokenLambda}
>       biglambda       {TokenTyLambda}
>       ":"             {TokenCol}
>       var             {TokenVar $$}
>       "."             {TokenDot}
>       "("             {TokenLParen}
>       ")"             {TokenRParen}
>       "["             {TokenLBr}
>       "]"             {TokenRBr}
>       forall          {TokenForall}
>       ";"             {TokenSemi}
>       type            {TokenIdType}   
>       term            {TokenIdTerm}
>       "="             {TokenDef}

Like yacc, we include %% here, for no real reason

> %%

And now the Production rules for the grammar


The parsing process will not give us a deBruijn representation of the parsed term.
In a following step (function pExptoExp??) the term must be "deBruijnised"

We can parse definitions, which consist of an identifier (term or type) which tells us whether we
define a term or a type variable, the variable name, the kind or type of the variable, and the "value"

> Defs :: { [PDef] }
> Defs : {- empty -}                                    {[]}
>      | Def Defs                                       { ($1:$2) }

> Def :: { PDef }
> Def : type var ":" KindExp "=" TypeExp ";"          { PDefEntry $2 IsType $6 $4 }     --defining a type
>     | term var ":" TypeExp "=" Tm ";"               { PDefEntry $2 IsTerm $6 $4 }     --defining a term
>     | type var ":" KindExp ";"                      { PVarEntry $2 IsType $4}         --defining a hypothetical type
>     | term var ":" TypeExp ";"                      { PVarEntry $2 IsTerm $4}         --defining a hypothetical term

term-level parsing

Tm is a non-empty vector of "Term" returned as a preliminary expression.

> Tm :: { PExp }
> Tm : Term Tms                                         { listToTerm ($1:$2) }

Tms is a possibly empty vector of "Term" returned as a list.

> Tms :: { [PExp] }
> Tms : {- empty -}                                     { [] }
>       | Term Tms                                      { $1:$2 }

> Term :: { PExp }
> Term  : var                                           { PVar $1 }
>       | "(" Tm ")"                                    { $2 }
>       | "." Tm                                        { $2 }
>       | lambda var PossT Term                         { PAbs $2 $3 $4 }
>       | biglambda var PossK Term                      { PTyAbs $2 $3 $4 }
>       | Term "[" TypeExp "]"                          { PTyApp $1 $3 }



> PossT :: { Maybe PExp }
> PossT         : {- empty -}                           { Nothing }
>               | ":" TypeAtom                          { Just $2 }
>
> PossK :: { Maybe PExp }
> PossK         : {- empty -}                           { Nothing }
>               | ":" KindAtom                          { Just $2 }



type-level parsing

> TypeAtom :: { PExp}
> TypeAtom : var                                        { PVar $1 }
>          | "(" TypeExp ")"                            { $2 }
>          | "." TypeExp                                { $2 }
>          | forall var ":" KindAtom TypeAtom           { PForall $2 $4 $5 }   
>          | lambda var PossK TypeAtom                  { PAbs $2 $3 $4 }

> TypeFactor :: { PExp }
> TypeFactor : TypeAtom                                 { $1 }
>            | TypeFactor TypeAtom                      { PApp $1 $2 }

> TypeExp    :: { PExp }
> TypeExp    : TypeFactor                               { $1 }
>            | TypeFactor "->" TypeExp                  { PArr $1 $3 }


kind-level parsing

> KindAtom :: { PExp }
> KindAtom      : "*"                                   { PType }
>               | "(" KindExp ")"                       { $2 }
>               | "." KindExp                           { $2 }

> KindExp  :: { PExp }
> KindExp       : KindAtom                              { $1 }
>               | KindAtom "->" KindExp                 { PArr $1 $3 }

> {
> happyError :: P a
> happyError = getLineNo `thenP` \line ->
>               failP ("Parse Error at line: "++ show line)

> type TTPair = (PExp,PExp)

> data PDef = PDefEntry String Indicator PExp PExp
>           | PVarEntry String Indicator PExp

> data PExp = PVar String                       
>       | PAbs String (Maybe PExp) PExp         
>       | PApp PExp PExp                
>       | PTyAbs String (Maybe PExp) PExp                       
>       | PTyApp PExp PExp                                      
>       | PArr PExp PExp                
>       | PType                         
>       | PForall String PExp PExp
>       deriving Show


This function is used to convert a list of PExps into a single PExp if
the length of the list is 1, else into a "chain" of PApps

> listToTerm :: [PExp] -> PExp
> listToTerm (e:es) = foldl PApp e es

This function converts the parsed Term into deBruijn representation

> pExpToExp :: PExp -> [String] -> Exp
> pExpToExp (PVar v) vs = Var (posOf v vs)
> pExpToExp (PAbs s mbe e) vs = Abs s (maybePtE mbe vs) (pExpToExp e (s:vs))
> pExpToExp (PApp e1 e2) vs = App (pExpToExp e1 vs) (pExpToExp e2 vs)
> pExpToExp (PTyAbs s mbe e) vs = TyAbs s (maybePtE mbe vs) (pExpToExp e (s:vs))
> pExpToExp (PTyApp e1 e2) vs = TyApp (pExpToExp e1 vs) (pExpToExp e2 vs)
> pExpToExp (PArr e1 e2) vs = Arr (pExpToExp e1 vs) (pExpToExp e2 vs)
> pExpToExp (PType) vs = Type
> pExpToExp (PForall s e1 e2) vs = Forall s (pExpToExp e1 vs) (pExpToExp e2 (s:vs))

> maybePtE :: (Maybe PExp) -> [String] -> (Maybe Exp)
> maybePtE Nothing vs = Nothing
> maybePtE (Just e) vs = Just (pExpToExp e vs)

This function converts a PDef into a VarBin

> pDefToDef :: PDef -> [String] -> VarBin
> pDefToDef (PDefEntry name ind e1 e2) vs = (name,(DefEntry ind (pExpToExp e1 vs) (pExpToExp e2 vs)))
> pDefToDef (PVarEntry name ind e) vs = (name, VarEntry ind (Just (pExpToExp e vs)))

converts [PDef] into a Context containing the definitions

> allPDefToDef :: [PDef] -> [String] -> Context
> allPDefToDef [] _ = []
> allPDefToDef ((PDefEntry name ind e1 e2):defs) vs =
> --let name' = freeV vs name in
>     (pDefToDef (PDefEntry name ind e1 e2) vs):(allPDefToDef defs (name:vs))
> allPDefToDef ((PVarEntry name ind e):defs) vs = 
>     (pDefToDef (PVarEntry name ind e) vs):(allPDefToDef defs (name:vs))


help function. works like freeVersion of module Datastructure, but on a list of Strings, not on a context.

> freeV :: [String] -> String -> String
> freeV vs v = 
>       if any (\s -> s==v) vs
>       then freeV vs (v ++ "'")
>       else v


This function looks up the index (and therefor the deBruijn-representation) of a Variable in a list of Strings

> posOf :: String -> [String] -> Int
> posOf s xs = intposOf s xs 0

> intposOf s [] i = error ("Variable " ++ s ++ " nicht im Kontext!")
> intposOf s (x:xs) i
>       | s==x = i
>       | otherwise = intposOf s xs (i+1)

this function finally concatenates lexer, parser and pExpToExp , so that it converts a string into our internal representation

> parseDefinitions :: String -> Error Context
> parseDefinitions s =
>	do	pd <- parseDef s 1
>		return (allPDefToDef pd [])


> }
