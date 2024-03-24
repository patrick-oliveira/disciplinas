f :: (b -> a) -> (c -> a) -> Either b c -> a
f g h (Left x) = g x
f g h (Right y) = h y

f_ :: (Either b c -> a) -> (b -> a, c -> a)
f_ w = (w . Left, w . Right)