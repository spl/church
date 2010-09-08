> module AlgorithmicEquality where
> import Prelude hiding (lookup)
> import Error
> import Datastructure
> import KindChecking


whnf constructs the weak head normal form of a term that includes definitions
parameters: cxt = the context under which the whnf has to be constructed
            exp = the expression to be normalized

> whnf :: Context -> Exp -> Exp

> whnf cxt (Var i) = 
>       let entry = lookup cxt i in
>		case entry of 
>			VarEntry _ _ -> Var i
>			DefEntry _ v _ -> whnf cxt v

> whnf cxt (App e1 e2) = whnfApp (whnf cxt e1)
>	where whnfApp (Abs _ _ e1) = whnf cxt (subst0 e2 e1)
>	      whnfApp e1 = App e1 e2

> whnf cxt (TyApp e1 e2) = whnfTyApp (whnf cxt e1)
>	where whnfTyApp (TyAbs _ _ e1) = whnf cxt (subst0 e2 e1)
>	      whnfTyApp e1 = TyApp e1 e2

> whnf _ e = e

KIND-DRIVEN EQUALITY

parameters: cxt = the context
	    f1  = the first Type
	    f2  = the second type
	    k   = the kind the types should have
returns an error if either one of the two types does not have the given kind

> kdEquality :: Context -> Exp -> Exp -> Exp -> Error ()

> kdEquality cxt f1 f2 Type =
>	let v1 = whnf cxt f1
>	    v2 = whnf cxt f2 in
>	    do 	k <- structEquality cxt v1 v2
>		case k of 
>			Type -> return ()
>			_ -> fail ("Kind-driven equality failed: at least one of the two types " ++
>				   printGood cxt v1 ++ " or " ++ printGood cxt v2 ++ 
>			   	   " does not have kind *")

> kdEquality cxt f1 f2 (Arr k1 k2) =
>	kdEquality (("X",VarEntry IsType (Just k1)):cxt) (App (shift 0 1 f1) (Var 0)) (App (shift 0 1 f2) (Var 0)) k2

> kdEquality cxt _ _ k = fail ("No check for Equality possible with kind: " ++ printGood cxt k)
				

STRUCTURAL EQUALITY

parameters: cxt = the context
	    f1  = the first Type
	    f2  = the second type
returns an error message if the types are not equal, else it returns the kind of the two types

> structEquality :: Context -> Exp -> Exp -> Error Exp

> structEquality cxt (Var i) (Var j) =
>	if(i==j)
>	then let entry = lookup cxt i in
>		 case entry of 
>		    VarEntry IsType (Just k) -> return k
>		    DefEntry IsType t k -> return k
>	    	    _ -> fail (printGood cxt (Var i) ++
>                              " is not a type variable and therefore cannot be kinded\n")
>	else fail (printGood cxt (Var i) ++ " is not structurally equivalent to " ++ printGood cxt (Var j))

> structEquality cxt (App f1 g1) (App f2 g2) = 
>	do k <- structEquality cxt f1 f2
>	   case k of
>		(Arr k1 k2) -> do kdEquality cxt g1 g2 k1
>				  return k2
>		_ -> fail (printGood cxt (App f1 g1) ++ " is not structurally equivalent to " ++ 
>			   printGood cxt (App f2 g2))

> structEquality cxt (Arr a1 b1) (Arr a2 b2) =
>	kdEquality cxt a1 a2 Type >> kdEquality cxt b1 b2 Type >> return Type

> structEquality cxt (Forall x1 k1 a1) (Forall x2 k2 a2) =
>	do kdEquality ((x1,VarEntry IsType (Just k1)):cxt) a1 a2 Type
>	   return Type

> structEquality cxt f1 f2 = fail ("The types \n" ++
>			           printGood cxt f1 ++ "\nand\n" ++ 
>			           printGood cxt f2 ++ "\nare not equivalent: Outermost constructors do not match.\n")
