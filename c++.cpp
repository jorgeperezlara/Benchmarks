#include <iostream>

long long int half(long long int index)
{
  if (index > 1)
  {
    index = half(index / 2);
  }
  return index;
}

int main()
{
  long long int j = 0;
  for (long long int i = 0; i < 10000000000; i++)
  {
    j = j + half(i);
  };
  std::cout << "The result is " << j;
}