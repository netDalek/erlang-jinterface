-module(test_module).
-compile(export_all).

atom() -> atom.

binary() -> <<"binary">>.
binary(Bin) when is_binary(Bin) -> ok.

utf_binary() -> <<"слово"/utf8>>.

float() -> 3.14.

long() -> 123.

string() -> "string".

list() -> [100,200,300].

tuple() -> {ok, tuple}.

map() -> #{key1 => "value", key2 => 123}.

echo(E) -> E.

error() -> erlang:error(some_error).

pid() -> self().
