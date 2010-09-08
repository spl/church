> module ParseMonad where
> import Error

> type LineNumber = Int
> type P a = String -> LineNumber -> Error a

> thenP :: P a -> (a -> P b) -> P b
> m `thenP` k = \s l ->
> 	case m s l of
>		Ok a -> k a s l
>		Fail e -> Fail e

> returnP :: a -> P a
> returnP a = \s l -> Ok a

> failP :: String -> P a
> failP err = \s l -> fail err

> getLineNo :: P LineNumber
> getLineNo = \s l -> return l

> {- cannot define P as instance of a Monad since P is only type synonym
> instance Monad P where
>     (>>=) = thenP
>     return = returnP
>     fail = failP
> -}
