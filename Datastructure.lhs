> module Datastructure where
> import Prelude hiding (lookup)

the datastructure for our implementation of system-f-omega

> data Exp = Var Int			
> 	| Abs String (Maybe Exp) Exp		
> 	| App Exp Exp		
> 	| TyAbs String (Maybe Exp) Exp			
> 	| TyApp Exp Exp					
> 	| Arr Exp Exp		
> 	| Type				
> 	| Forall String Exp Exp

A function for printing an "empty" String of length n

> printEmpty :: Int -> String
> printEmpty 0 = ""
> printEmpty n = " " ++ printEmpty (n -1)

a very simple function for printing terms (for debugging purposes)
- prints deBruijn indices
- puts parenthesis everywhere

> printRaw :: Exp -> String

> printRaw (Var i) = show i

> printRaw (Abs s eopt e2) = "(\\"++s++(printMaybeRaw eopt)++"."++(printRaw e2)++")"

> printRaw (App e1 e2) = "("++(printRaw e1)++" "++(printRaw e2)++")"
 
> printRaw (TyAbs s eopt e2) = "(\\\\"++s++(printMaybeRaw eopt)++"."++(printRaw e2)++")"

> printRaw (TyApp e1 e2) = "("++(printRaw e1)++"["++(printRaw e2)++"])"
> printRaw (Arr e1 e2) = "("++(printRaw e1)++ " -> " ++ (printRaw e2)++")"
> printRaw Type = "*"
> printRaw (Forall s e1 e2) = "(forall "++s++":"++(printRaw e1)++"."++(printRaw e2)++")"


a function for printing "Maybe Exp"

> printMaybeRaw :: Maybe Exp -> String
> printMaybeRaw Nothing = ""
> printMaybeRaw (Just e) = ":"++(printRaw e)


SHIFT

shifting:  shift c d e [Pierce, 6.2], expanded to System-F-Omega

parameters: c = cutoff
            d = distance
            e = expression

> shift :: Int -> Int -> Exp -> Exp

> shift c d (Var k) = if k<c then (Var k) else (Var (k+d))

> shift c d (Abs s eopt e2) = Abs s (shiftMaybe c d eopt) (shift (c+1) d e2)
> shift c d (TyAbs s eopt e2) = TyAbs s (shiftMaybe c d eopt) (shift (c+1) d e2)

> shift c d (App e1 e2) = App (shift c d e1) (shift c d e2)
> shift c d (TyApp e1 e2) = TyApp (shift c d e1) (shift c d e2)

> shift c d (Arr e1 e2) = Arr (shift c d e1) (shift c d e2)
> shift _ _ Type = Type

> shift c d (Forall s e1 e2) = Forall s (shift c d e1) (shift (c+1) d e2)


> shiftMaybe :: Int -> Int -> Maybe Exp -> Maybe Exp
> shiftMaybe c d (Just exp) = Just (shift c d exp)
> shiftMaybe c d Nothing = Nothing

SUBSTITUTION

subst e j e' = [e/j]e'

> subst :: Exp -> Int -> Exp -> Exp

> subst e j (Var k) = if k==j then e else (Var k)

> subst e j (Abs s eopt e2) = Abs s (substMaybe e j eopt) (subst (shift 0 1 e) (j+1) e2)
> subst e j (TyAbs s eopt e2) = TyAbs s (substMaybe e j eopt) (subst (shift 0 1 e) (j+1) e2)

> subst e j (App e1 e2) = App (subst e j e1) (subst e j e2)
> subst e j (TyApp e1 e2) = TyApp (subst e j e1) (subst e j e2)

> subst e j (Arr e1 e2) = Arr (subst e j e1) (subst e j e2)
> subst e j Type = Type

> subst e j (Forall s e1 e2) = Forall s (subst e j e1) (subst (shift 0 1 e) (j+1) e2)
> substMaybe :: Exp -> Int -> Maybe Exp -> Maybe Exp
> substMaybe e j Nothing = Nothing
> substMaybe e j (Just e1) = Just (subst e j e1)

ABBREVIATION FOR SUBSTITUTION FOR 0TH VARIABLE

subst0 e f = [e]f

> subst0 :: Exp -> Exp -> Exp
> subst0 e f = shift 0 (-1) (subst (shift 0 1 e) 0 f)

CONTEXTS

An entry is either a type (term) Variable with an optional kind (type),
or a type (term) definition with a value (first Exp) and a kind (type), (second Exp)

> data Indicator = IsType | IsTerm
>	deriving Show

> data Entry = VarEntry Indicator (Maybe Exp)
>            | DefEntry Indicator Exp Exp
>		deriving Show

shifting entries (for context lookup)

> shiftEntry :: Entry -> Int -> Entry
> shiftEntry (VarEntry ind eOpt) k = (VarEntry ind (shiftMaybe 0 k eOpt))
> shiftEntry (DefEntry ind e e') k = (DefEntry ind (shift 0 k e) (shift 0 k e'))

a binding of a variable consist of the variable name and an entry for the variable

> type VarBin = (String,Entry)
> type Context = [VarBin]

lookup a binding in a context, shifting on the way back

lookup' gamma index shift

> lookup' :: Context -> Int -> Int -> Entry
> lookup' [] i k = error ("lookup: de Bruijn index " ++ show (i+k-1) ++ 
>		  " too large. Context has only " ++ show (k-1) ++ " entries.")
> lookup' ((x,e):cxt) 0 k = shiftEntry e k
> lookup' (v:vs) i k = lookup' vs (i-1) (k+1)


> lookup :: Context -> Int -> Entry
> lookup cxt i 
>     | i < 0 = error ("lookup: negative index " ++ show i)
>     | otherwise = lookup' cxt i 1



> freeVersion :: Context -> String -> String
> freeVersion gamma x 
>    = if any (\ (y, _ ) -> x == y) gamma
>      then freeVersion gamma (x ++ "'") 
>      else x

PRINT

a function that prints a term, naming variables (without deBruijn indices)

> printGood :: Context -> Exp -> String

> printGood cxt (Var i) = let (x,_) = (cxt !! i) in
>			      x
> printGood _ Type = "*"
> printGood cxt (Abs x s t) = let x' = freeVersion cxt x in
>			          "(\\" ++ x' ++ (printMaybe cxt s) ++ "." ++ (printGood ((x',(VarEntry IsTerm s)):cxt) t) ++ ")"
> printGood cxt (App e f) = "("++(printGood cxt e)++" "++(printGood cxt f)++")"
> printGood cxt (TyAbs x k t) = let x' = freeVersion cxt x in
>				    "(\\\\" ++ x' ++ (printMaybe cxt k) ++ "." ++ (printGood ((x',(VarEntry IsType k)):cxt) t) ++ ")"
> printGood cxt (TyApp e b) = "("++(printGood cxt e)++" ["++(printGood cxt b)++"])"
> printGood cxt (Arr a b) = "("++(printGood cxt a)++"->"++(printGood cxt b)++")"
> printGood cxt (Forall x k a) = let x' = freeVersion cxt x in
>				     "(forall " ++ x' ++ ":" ++ (printGood cxt k) ++ "." ++ (printGood ((x',(VarEntry IsType (Just k))):cxt) a) ++ ")"

> printMaybe :: Context -> Maybe Exp -> String

> printMaybe _ Nothing = ""
> printMaybe cxt (Just e) = ":"++(printGood cxt e)



defining instance of "Show" for Exp

> instance Show Exp where
>     show = printGood []


