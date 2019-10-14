

// 0..N arity argument containers - could just use tuples, however, 'generated' code becomes quite messy quickly

primitive Arguments0
    new create() => None

class Arguments1[A: Any #read]
    let a: A
    new create(a': A) =>
        a = a'

class Arguments2[A: Any #read, B: Any #read]
    let a: A
    let b: B
    new create(a': A, b': B) =>
        a = a'
        b = b'