pub mod cnf_formula;
use cnf_formula::*;

pub fn find_propogatable(f:& Formula) -> Option<(Variable,bool)> {
    // unimplemented!()
    for clause in f {
        if clause.len() == 1 {
            for atom in clause {
                match atom {
                    Atom::Base(var) => return Some((*var, true)),
                    Atom::Not(var) => return Some((*var, false)),
                }
            }
        }
    }
    None
}

pub fn propogate_unit(f:& mut Formula,v:Variable,b:bool) {
    // unimplemented!()
    if b == true {
        f.retain(|clause | !clause.contains(&Atom::Base(v)));
        for clause in f {
            clause.retain(|atom | atom != &Atom::Not(v));
        }
    }
    else { // == false
        f.retain(|clause | !clause.contains(&Atom::Not(v)));
        for clause in f {
            clause.retain(|atom | atom != &Atom::Base(v));
        }
    }
}

pub fn find_pure_var(f:& Formula) -> Option<Variable> {
    // unimplemented!()
    let v = get_vars(f);
    for i in v {
        if is_pure(f, i) == true {
            return Some(i);
        }
    }
    None
}

pub fn assign_pure_var(f: & mut Formula, v: Variable) {
    // unimplemented!()
    let mut i = 0; 
    let mut c = 0;
    for atom in f.clone() {
        if has_var_clause(&atom, v) {
            f.remove(i - c);
            c += 1;
        }
        i += 1;
    }
}

pub fn unit_propogate(f:& mut Formula) {
    match find_propogatable(f) {
        Option::None => return,
        Option::Some((v,b)) => {
            propogate_unit(f, v, b);
            unit_propogate(f)
        }
    }
}

pub fn assign_pure_vars(f:& mut Formula) {
    match find_pure_var(f) {
        Option::None => return,
        Option::Some(v) => {
            assign_pure_var(f,v);
            assign_pure_vars(f); 
        }
    }
}

pub fn dpll(f:& mut Formula) -> bool {
    // unimplemented!()
    if f.is_empty() {
        return true;
    }

    unit_propogate(f);
    assign_pure_vars(f);

    let mut not = f.clone();
    let mut base = f.clone();
    let v = get_vars(f);

    for v in f {
        if v.is_empty() {
            return false;
        }
    }
    
    for var in v {
        base.push(vec![Atom::Base(var)]);
        not.push(vec![Atom::Not(var)]);
    }

    return dpll(&mut base) || dpll(&mut not);
}