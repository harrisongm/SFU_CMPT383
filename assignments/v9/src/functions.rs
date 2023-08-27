pub fn prefixes(s:&str) -> Vec<&str> {
    // unimplemented!()
    let mut v:Vec<&str> = Vec::new();
    let mut i:usize = 1;
    v.push("");
    while i <= s.len() {
        v.push(&s[0..i]);
        i += 1;
    }
    return v;
}

pub fn return_if_satisfies_both<'a,'b,T,F:Fn(&T)->bool>(f:F,x:&'a T,y:&'b T) 
-> Option<(&'a T,&'b T)> {
    // unimplemented!()
    if f(x) == true && f(y) == true {
        return Some((&x, &y));
    }
    None
}

#[derive(Clone,PartialEq,Debug)]
pub enum List<T> {
    Nil,
    Cons(T,Box<List<T>>)
}

pub fn map<T,U,F:Fn(&T)->U>(f:F,l:& List<T>) -> List<U> {
    // unimplemented!()
    match l {
        List::Nil => List::Nil,
        List::Cons(x, xs) => List::Cons(f(x), Box::new(map(f, xs))),
    }
}

pub fn concat<T:Copy>(l1:& List<T>,l2:& List<T>) -> List<T> {
    // unimplemented!()
    match (l1, l2) {
        (List::Nil, l2) => l2.clone(),
        (List::Cons(x, xs), l2) => List::Cons(*x, Box::new(concat(xs, l2))),
    }
}
