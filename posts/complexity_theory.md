---
title: Complexity Theory
date: 2018-05-27
author: Oliver Fleckenstein
---
# Complexity Theory

<!-- Time and space -->
When developing algorithms it is necessary to analyze how well it is performing, known as the *computational complexity* of the algorithm.
The two most important metrics are the *running time* when executed and *space* consumption of the algorithm.
Sometimes it is also interesting to analyze the *preproccessing time* used to build the data structure.
These complexities are in general expressed using a function $n \rightarrow f(n)$ where $n$ is the size of the input to the algorithm.
The function $f(n)$ is used to express either the worst-case or the average case complexity for a problem.
To be precise, how difficult a problem of size $n$ is to solve can vary a lot, hence $f(n)$ should express the complexity of the algorithm for any problem.

<!-- Asymptotic -->
It is often hard to predict the exact complexity of a problem, and in pratice it can also vary from machine to machine.
It is also not so interesting to look at the complexities for small problems.
Because of this, when analyzing algorithms, we are in general only consider the complexity for problems that are *asymptotic* large.
These complexities can be expressed using the following notations.

## Big-O

The *Big-O* notation is used to express the worst case complexity for an algorithm.
This means that we can always find a function $g(x)$ that for every large $n$ will be greater than or equal to $f(x)$.
The formal definition for the Big-O notation is:

<div class="definition">
<header>
###### Big-O
</header>
<section>

$f(x) \in O(g(x))$ such that there exists $c > 0$ and $x_0$ such that $f(x) > c g(x)$ for $x \geq x_0$.
</section>
</div>

This is illustrated below, where the function $f(x)$ is bounded by some linear function $g(x)$.

<div style="max-width:500px" class="center">
![Illustration of how Big-O bounds the complexity for any algorithm.](/images/complexity/Big-O.png)
</div>

But this is quite abstract.
Lets look at a few examples of the most common functions used.

### Constant time $O(1)$

The simplest form of algorithms used are those that can be executed in the same space or time independent of the problems size.
This is the basis of all computations that are done in algorithms.
This is called *constant time* and is denoted $O(1)$.

```Typescript
function isZero(value: number): boolean {
    return value === 0;
}
```

### Linear time $O(n)$

For many problems, it is difficulty to solve without being depended on the size of the problem.
The simplest example of program whose performance is directly and linearly dependend on the problem size is a loop.
The membership problem can be solved by iterating through the list of elements, testing if each value is equal to the element.

Each iteration of the list can be seen to take constant time, as only a comparison have to be done.
As there is $n$ elements in the list, this comparison have to be executed $n$ times.
This is denoted $O(n)$

```Typescript
function contains(list: any[], x: any): boolean {
    for (let i = 0; i < list.length; i++) {
        if (list[i] === x) {
            return true;
        }
    }
    return false;
}
```

Note that this algorithm can return early if the element is preset in the list.
However, as the Big-O notation is used to analyze the worst-case, the case were the element is not in the list have to be considered, hence the algorithm will not return until all values in the list have been considered.

### Polynomial time $O(n^k)$

Many programs also use nested iterations over the data set, which causes the program's performance to be directly proportional to some polynomial.
For example, a naive function to sort a data set would be

```Typescript
function insertSort(list: any[]): any[] {
    let i = 0;
    while (i < list.length) {
        let j = i;
        while (j > 0 && list[j-1] > list[j]) {
            let temp = list[j];
            list[j] = list[j-1];
            list[j-1] = temp;
            j--;
        }
        i++;
    }
    return list;
}
```


### Logarithmic time $O(\lg n)$


### Exponential time $O(2^n)$

### Extra: Little-o

## Big-$\Theta$

### Little-$\theta$

## Big-$\Omega$

### Little-$\omega$

## Summary
