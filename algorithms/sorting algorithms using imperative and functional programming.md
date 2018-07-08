---
title: Sorting algorithms using imperative and functional programming
date: 2018-07-08
author: Oliver Fleckenstein
---
# Sorting algorithms using imperative and functional programming

Imperative programming have been dominating the software industry for most of its existence, while functional programming only have been practiced by a small communitive in the academic world.
However, concepts from functional programming languages are being introduced into many languages today, for example libraries like [React](https://www.reactjs.org).
The post will go through some of the classic algorithms for sorting datasets, and compare the implementation in a imperative ([TypeScript](https://www.typescriptlang.org/)) and functional ([Haskell](https://www.haskell.org/)) langauge.

The definition of the sorting problem is to take any list or array of elements and outputting the elements in a specific order.
For example sorting the natural numbers by their value.
The implementations shown here are by no means optimized, and only show of the simplest way of implementing these algorithms.
The algorithms that will be implemented and analyzed are:

- Insertion sort
- Merge sort
- Quick sort
- Bubble sort

## Insertion sort

One of the most basic algorithms for sorting a list is the insertion sort algorithm.
The principle is to go through the list and then first finding the smallest smallest element and inserting it first in the list.
In the basic approach, this requires a lot of swapping different elements in the list.

The imperative approach is displayed below.
The algorithm simple starts at the begining of the array, and then keeps swapping the current element with the next, if the next is smaller than the current element.
This means that the sorted list will be build up from the start, always ensuring that the elements before `i` is sorted.

```TypeScript
function insertSort(list: any[]): any[] {
    let i = 0;
    while (i < list.length) {
        let j = i;
        while (j > 0 && list[j - 1] > list[j]) {
            const temp = list[j];
            list[j] = list[j - 1];
            list[j - 1] = temp;
            j--;
        }
        i++;
    }

    return list;
}
```

Now this is a quite simple algorithm, but already not the easiest to read at first glance.
Nested loops and swapping elements in an array is never nice.

Now lets have a look at the functional approach to the same algorithm.
Remember how list is defined in a functional programming language: a list consists of a *head*, being the first element in the list, and a *tail*, being all the remaning elements in the list.

How does one insert an element at the correct position?
First consider the base case; what if the list is empty?
Well, then the list is simply the list containing only that element.
If there are elements in the list, then if the list is smaller than the head of this list, append the element to the list.
If not, the element should be inserted into the tail of the list.

These cases are written on the first few lines below.

```Haskell
insert :: (Ord a) => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)
    | x < y     = x : y : ys
    | otherwise = y : insert x ys

insertSort :: (Ord a) => [a] -> [a]
insertSort [] = []
insertSort (x:xs) = insert x $ insertSort xs
```

With `insert` defined, `insertSort` can be defined by inserting the first element into the sorted version of the tail.

If you have a bit more experience with functional programming, you might recognize this pattern as a `fold`.
We can rewrite the function above to fold over the unsorted list using the `insert` function.

```Haskell
insertSortFold :: (Ord a) => [a] -> [a]
insertSortFold [] = []
insertSortFold list = foldr insert [] list
```

Reasoning about how the functional implentation of this algorithm is, for me at least, a lot simpler.
It does exactly as one would describe how insertion sort would work, which is exactly how *declarative* programming should work.
