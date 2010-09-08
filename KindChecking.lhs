> module KindChecking where
> import Error
> import Prelude hiding (lookup)
> import Datastructure

KIND EQUALITY

checking if two kinds are equal; if not, return an error message
parameters: e1 = the first kind
            e2 = the second kind

> kindEquals :: Exp -> Exp -> Error ()

> kindEquals Type Type = return ()
> kindEquals (Arr e1 e2) (Arr e3 e4) = kindEquals e1 e3 >> kindEquals e2 e4
> kindEquals k k' = fail ("Kind equality failed: kind " ++ show k ++ 
>		          " not equal to " ++ show k' ++ ".")


KIND CHECKING

parameters: cxt = the context
	      f = the type to be kindchecked
	      k = the kind f has to be checked for
returns an error if f does not have kind k under context cxt

> kindChecking :: Context -> Exp -> Exp -> Error ()
> kindChecking cxt f k = 
>     do k' <- kindSynthesis cxt f
>        kindEquals k' k
>	     `newError` ("Kind checking failed: expected " ++
>		         printGood cxt f ++ " to be of kind " ++
>		         printGood cxt k ++ ", but found kind " ++
>		         printGood cxt k' ++ ".")

KIND SYNTHESIS

parameters: cxt = the context
	      f	= the type to be kinded

returns the kind of f under context cxt or an error

> kindSynthesis :: Context -> Exp -> Error Exp

to determine the kind of a variable, we simply look it up in the context

> kindSynthesis cxt (Var i) = 
>     let entry = lookup cxt i in
>	  case entry of
>	     VarEntry IsType (Just k) -> return k
>	     DefEntry IsType _ k -> return k
>	     _ -> fail ("Kind synthesis failed: " ++ printGood cxt (Var i) ++
>		        " is not a type variable and therefore cannot be kinded")

> kindSynthesis cxt (Abs x (Just k1) f) = 
>     do k2 <- kindSynthesis ((x,VarEntry IsType (Just k1)):cxt) f
>        return (Arr k1 k2)

> kindSynthesis cxt f0@(Abs x Nothing f) = 
>     fail ("Cannot synthesize kind of " ++ printGood cxt f0 ++ ", because kind annotation is missing in abstraction.")

> kindSynthesis cxt (App f g) = 
>     do k <- kindSynthesis cxt f 
>        case k of 
>	      (Arr k1 k2) -> (kindChecking cxt g k1) >> return k2 
>	      _ -> fail ("Kind synthesis failed: expected " ++
>		         printGood cxt f ++ " to be of function kind.")

> kindSynthesis cxt (Arr a b) = 
>     kindChecking cxt a Type >> 
>     kindChecking cxt b Type >> return Type

> kindSynthesis cxt (Forall x k a) = 
>     kindChecking ((x,VarEntry IsType (Just k)):cxt) a Type >> return Type

> kindSynthesis cxt a = fail ("No rule for synthesizing the kind of type: " ++ printGood cxt a)


