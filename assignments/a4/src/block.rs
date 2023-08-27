#![allow(unused)]

use crate::queue::{Task, WorkQueue};
use digest::consts::U32;
use sha2::digest::generic_array::GenericArray;
use sha2::{Digest, Sha256};
use std::fmt::Write;
use std::sync;

pub type Hash = GenericArray<u8, U32>;

#[derive(Debug, Clone)]
pub struct Block {
    pub prev_hash: Hash,
    pub generation: u64,
    pub difficulty: u8,
    pub data: String,
    pub proof: Option<u64>,
}

impl Block {
    pub fn initial(difficulty: u8) -> Block {
        // TODO: create and return a new initial block
        // unimplemented!()
        let mut new_block = Block {prev_hash: Hash::default(), generation: 0, difficulty, data: "".to_string(), proof: None};
        new_block
    }

    pub fn next(previous: &Block, data: String) -> Block {
        // TODO: create and return a block that could follow `previous` in the chain
        // unimplemented!()
        let mut new_block = Block {
            prev_hash: previous.hash(), 
            generation: previous.generation + 1, 
            difficulty: previous.difficulty, 
            data, 
            proof: None
        };
        new_block
    }

    pub fn hash_string_for_proof(&self, proof: u64) -> String {
        // TODO: return the hash string this block would have if we set the proof to `proof`.
        // unimplemented!()
        return format!("{:02x}:{}:{}:{}:{}", self.prev_hash, self.generation, self.difficulty, self.data, proof);
    }

    pub fn hash_string(&self) -> String {
        // self.proof.unwrap() panics if block not mined
        let p = self.proof.unwrap();
        self.hash_string_for_proof(p)
    }

    pub fn hash_for_proof(&self, proof: u64) -> Hash {
        // TODO: return the block's hash as it would be if we set the proof to `proof`.
        // unimplemented!()
        let mut hash = Sha256::new();
        hash.update(self.hash_string_for_proof(proof));
        hash.finalize()
    }

    pub fn hash(&self) -> Hash {
        // self.proof.unwrap() panics if block not mined
        let p = self.proof.unwrap();
        self.hash_for_proof(p)
    }

    pub fn set_proof(self: &mut Block, proof: u64) {
        self.proof = Some(proof);
    }

    pub fn hash_satisfies_difficulty(difficulty:u8,hash:Hash) -> bool {
        // TODO: does the hash `hash` have `difficulty` trailing 0s
        // unimplemented!()
        let _bytes = difficulty/8;
        let _bits = difficulty%8;

        let _hash = hash.clone();
        for i in (32 - _bytes)..32 {
            if _hash[i as usize] != 0u8 {
                return false;
            }
        }

        if (_hash[31 - _bytes as usize] % (1<<_bits)) != 0 {
            return false;
        }

        true
    }

    pub fn is_valid_for_proof(&self, proof: u64) -> bool {
        Self::hash_satisfies_difficulty(self.difficulty,self.hash_for_proof(proof))
    }

    pub fn is_valid(&self) -> bool {
        if self.proof.is_none() {
            return false;
        }
        self.is_valid_for_proof(self.proof.unwrap())
    }

    // Mine in a very simple way: check sequentially until a valid hash is found.
    // This doesn't *need* to be used in any way, but could be used to do some mining
    // before your .mine is complete. Results should be the same as .mine (but slower).
    pub fn mine_serial(self: &mut Block) {
        let mut p = 0u64;
        while !self.is_valid_for_proof(p) {
            p += 1;
        }
        self.proof = Some(p);
    }

    pub fn mine_range(self: &Block, workers: usize, start: u64, end: u64, chunks: u64) -> u64 {
        // TODO: with `workers` threads, check proof values in the given range, breaking up
	// into `chunks` tasks in a work queue. Return the first valid proof found.
        // HINTS:
        // - Create and use a queue::WorkQueue.
        // - Use sync::Arc to wrap a clone of self for sharing.
        // unimplemented!()
        let _arc = sync::Arc::new(self.clone());
        let mut _queue = WorkQueue::new(workers);
        let _max_size;
        let _chunk_size;
        if (end - start) < chunks {
            _chunk_size = 1;
            _max_size = end - start;
        } else {
            _chunk_size = (end - start) / chunks;
            _max_size = chunks;
        }

        for i in 0..(_max_size - 1) {
            let temp =  MiningTask{
                block:sync::Arc::clone(&_arc),
                start:i*_chunk_size,end:((i+1)*_chunk_size)-1};
            _queue.enqueue(temp).unwrap();
        }

        let last = MiningTask{
            block:sync::Arc::clone(&_arc),
            start:_chunk_size*(_max_size-1),end:end};
        _queue.enqueue(last).unwrap();

        loop {
            let _recv = _queue.recv();
            if self.is_valid_for_proof(_recv) {_queue.shutdown(); return _recv;}
        }
    }

    pub fn mine_for_proof(self: &Block, workers: usize) -> u64 {
        let range_start: u64 = 0;
        let range_end: u64 = 8 * (1 << self.difficulty); // 8 * 2^(bits that must be zero)
        let chunks: u64 = 2345;
        self.mine_range(workers, range_start, range_end, chunks)
    }

    pub fn mine(self: &mut Block, workers: usize) {
        self.proof = Some(self.mine_for_proof(workers));
    }
}

struct MiningTask {
    block: sync::Arc<Block>,
    // TODO: more fields as needed
    start: u64,
    end: u64
}

impl Task for MiningTask {
    type Output = u64;

    fn run(&self) -> Option<u64> {
        // TODO: what does it mean to .run?
        // unimplemented!()
        for i in self.start..self.end {
            if self.block.is_valid_for_proof(i) {return Some(i)}
        }
        None
    }
}