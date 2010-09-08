> module Error where

This module contains the error monad.

Any function which returns either something of type 'a' or an error
message can be implemented with the "Error" monad.  The name looks a
little bit misleading in type signatures since looking at a
declaration

<    f :: a -> Error b

we might be tempted to think f always returns an error.  But the name
"Error" for this monad is quite standard.

> data Error a = Ok a | Fail String
>       deriving Show

"Error" is a type transformer, taking a type "a" and returning a
variant type "Error a" which might either contain a result of type "a"
or an error message of type "String".

> instance Monad Error where

There are two main monadic operations: "return" and the binding
operation ">>=".  First, the return operation which "wraps the monad"
around a value.

<      return :: a -> Error a

In our case, this is simply the "Ok" constructor.

>     return = Ok

The second standard operation is "bind", the infix ">>=" in Haskell.

<      (>>=) :: Error a -> (a -> Error b) -> Error b

It takes two arguments: the result of a monadic computation and a
continuation "k".  The result can either be "Fail s" for some message
"s" or "Ok a" for some 'pure' (as opposed to 'monadic') value "a" of
type "a".  In case of a value "a", it just passes the value to the
continuation "k".  In case an error has already occured (Fail s), the
continuation is discarded and the error is passed on.

>     (Ok a)   >>= k = k a
>     (Fail s) >>= k = Fail s

There is a special version of the bind operation for the case that the
value of the first computation is not needed for the second
computation.  It is predefined for all monads in the Haskell Prelude.

<      (>>) :: Error a -> Error b -> Error b
<      r >> k =  r >>= \ _ -> k

It is the canonical choice of binding operation if the first
computation can only be the unit element ().


The third monad operation, which is only standard in Haskell, is the
failure operation.

<      fail :: String -> Error a

Usually fail throws a program error.  In our case, it generates an
error result which is then passed on through the binding operation.

>     fail = Fail

The "do" notation:

Haskell provides some syntactic sugar for monadic programming, since
it is the default way to do in/out, mutable store, exceptions etc. and
thus, is ubiquituous.

<    do x <- r
<       t

is a synonym for

<    r >>= (\ x -> t)

but it is easier to read.  The meaning is: 

    Extract the pure value "a" as result of the computation "r", bind
    it to identifier "x" and continue with computation "t".

Multiple bindings are supported.

<    do x <- r
<       y <- s
<       t

Note that the order of the bindings DOES matter, even if "s" does not
mention "x".  The binding operation forces sequentialization.  In our
case, if "r" throws an error, and "s" would also cause one, the error
produced by "r" has precedence.


Non-monadic functions.

Update error message.

> newError :: Error a -> String -> Error a
> (Fail _) `newError` s = Fail s
> (Ok a)   `newError` _ = Ok a












