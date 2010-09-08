> module TypeChecking where
> import Prelude hiding (lookup)
> import Error
> import Datastructure
> import KindChecking
> import AlgorithmicEquality

TYPE CHECKING

parameters: cxt = the context
	    e   = the term that has to be type-checked
	    c   = the type e has to be checked for(i.e., e is supposed to have)
returns an error if e does not have type c under context cxt

> typeChecking :: Context -> Exp -> Exp -> Error ()

> typeChecking cxt e c = 
>	do a <- typeSynthesis cxt e
>	   kdEquality cxt a c Type
>	      `newError` ("Expected " ++ printGood cxt e ++ 
>		          " to be of type " ++ printGood cxt c ++
>		          ", but found type " ++ printGood cxt a ++ ".\n")


TYPE SYNTHESIS

parameters: cxt = the context
            e   = the term for which the type has to be synthesized

> typeSynthesis :: Context -> Exp -> Error Exp

> typeSynthesis cxt (Var i) =
>     let entry = lookup cxt i in
>	  case entry of
>	     VarEntry IsTerm (Just f) -> return f
>	     DefEntry IsTerm t f -> return f
>	     _ -> fail ("Type synthesis failed: " ++ printGood cxt (Var i) ++
>		        " is not a term variable and therefore cannot be typed")

> typeSynthesis cxt (Abs x (Just a) e) =
>	do kindChecking cxt a Type
>	   b <- typeSynthesis ((x,VarEntry IsTerm (Just a)):cxt) e
>	   return (Arr a (shift 0 (-1) b))

> typeSynthesis cxt e0@(Abs x Nothing e) =
>     fail ("Cannot synthesize the type of " ++ printGood cxt e0 ++
>           ", because type annotation is missing in abstraction.")

> typeSynthesis cxt (App f e) =
>	do a0 <- typeSynthesis cxt f
>	   let ab = whnf cxt a0 in
>	       case ab of 
>		    (Arr a b) -> do typeChecking cxt e a
>				    return b
>		    _ -> fail ("Expected " ++ 
>		               printGood cxt f ++ 
>		               " to be of function type, but found type " ++ 
>		               printGood cxt ab)


> typeSynthesis cxt (TyAbs x (Just k) e) =
>	do a <- typeSynthesis ((x,VarEntry IsType (Just k)):cxt) e
>	   return (Forall x k a)

> typeSynthesis cxt e0@(TyAbs x Nothing e) =
>     fail ("Cannot synthesize the type of " ++ printGood cxt e0 ++
>           ", because type annotation is missing in abstraction.")

> typeSynthesis cxt (TyApp e f) =
>	do a0 <- typeSynthesis cxt e
>	   let fa = whnf cxt a0 in
>	       case fa of
>			(Forall _ k a) -> do kindChecking cxt f k
>					     return (shift 0 (-1) (subst (shift 0 1 f) 0 a))
>			_ -> fail ("Expected " ++ printGood cxt e ++ 
>			           " to be of universal type, but found type " ++ 
>          			   printGood cxt fa)

