#[inline]
pub fn half(mut num: i64) -> i64 {
    if num > 1 {
        num = half(num / 2);
    }
    num
}

pub fn main() {
    let j: i64 = (0..10000000000).into_iter().map(|x| half(x)).sum();
    print!("The result is {}\n", j);
}