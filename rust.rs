pub fn half(mut num: i64) -> i64 {
  if num > 1 {
      num = half(num / 2);
  }
  num
}

pub fn main() {
  let mut j: i64 = 0;
  for i in 0..10000000000 {
      j = j + half(i);
  }
  print!("The result is {}", j);
}