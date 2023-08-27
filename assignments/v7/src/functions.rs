pub fn next_hailstone(x:u32) -> u32 {
    // unimplemented!();
    if x % 2 == 0 {
        return x / 2;
    }
    else {
        return 3 * x + 1;
    }
}

pub fn hailstone_sequence(init:u32) -> Vec<u32> {
    // unimplemented!();
    let mut seq = Vec::new();
    let mut next = init;
    seq.push(init);
    while next != 1  {
        next = if next % 2 == 0 {
            next / 2 
        } 
        else {
            3 * next + 1
        };
        seq.push(next);
    }seq
}

pub fn find_elt<T : Eq>(v: Vec<T>,elt: T) -> Option<usize> {
    // unimplemented!();
    let vec_size = v.len();
    let mut i: usize = 0;
    while i < vec_size {
        if v[i] == elt {
            return Some(i);
        }
        else{
            i += 1
        }
    }
    None
}

pub fn all_indices<T : Eq>(v: Vec<T>,elt: T) -> Vec<usize> {
    // unimplemented!();
    let vec_size = v.len();
    let mut i: usize = 0;
    let mut seq:Vec<usize> = Vec::new();
    while i < vec_size {
        if v[i] == elt {
            seq.push(i);
        }
        i += 1;
    }
    return seq;
}